import 'dart:async';

import 'package:fresh/fresh.dart';
import 'package:graphql/client.dart';
import 'package:meta/meta.dart';
import 'package:pedantic/pedantic.dart';

typedef ShouldRefresh = bool Function(Response);

typedef RefreshToken<T> = Future<T> Function(T);

/// {@template custom_auth_link}
/// A GraphQL Link which handles manages an authentication token automatically.
///
/// A constructor that returns a Fresh interceptor that uses the
/// [OAuth2Token] token.
///
/// [tokenStorage] defines where do you want this link to automatically read/write
/// token from/to. Implement [TokenStorage] to your own storage solution then
/// this [CustomAuthLink] can manipulate its data automatically.
///
/// [shouldRefresh] a function invoked when any Request hits an error, most likely,
/// the error occurs due to token expired or token revoked.
/// It returns [bool], if [true] then [refreshToken] will be called next, false otherwise
///
/// [doRefreshToken] a function that invoked when the [CustomAuthLink] detects that
/// it needs to refresh the token. Implement this function to define your own
/// way on how to refresh a new access token.
///
/// [tokenHeader] defines how you want to form a token header.
/// By default, it uses the basic OAuth2 format:
/// 'Authorization': '${token.tokenType} ${token.accessToken}'.
///
/// {@endtemplate}
class CustomAuthLink<T> extends Link with FreshMixin<T> {
  /// {@macro custom_auth_link}
  CustomAuthLink({
    @required TokenStorage<T> tokenStorage,
    @required ShouldRefresh shouldRefresh,
    @required RefreshToken<T> doRefreshToken,
    TokenHeaderBuilder<T> tokenHeader,
  })
      : assert(tokenStorage != null),
        assert(doRefreshToken != null),
        assert(shouldRefresh != null),
        _refreshToken = doRefreshToken,
        _buildHeader = tokenHeader,
        _shouldRefresh = shouldRefresh {
    this.tokenStorage = tokenStorage;
  }

  ///{@template custom_auth_link}
  ///A GraphQL Link which handles manages an authentication token automatically.
  ///
  /// ```dart
  /// final customAuthLink = CustomAuthLink.oAuth2(
  ///   tokenStorage: InMemoryTokenStorage<OAuth2Token>(),
  ///   refreshToken: (token) {
  ///     // Perform refresh and return new token
  ///   },
  /// );
  /// final graphQLClient = GraphQLClient(
  ///   cache: InMemoryCache(),
  ///   link: Link.from([customAuthLink, HttpLink(uri: 'https://my.graphql.api')]),
  /// );
  /// ```
  /// {@endtemplate}
  static CustomAuthLink<OAuth2Token> oAuth2({
    @required TokenStorage<OAuth2Token> tokenStorage,
    @required ShouldRefresh shouldRefresh,
    @required RefreshToken<OAuth2Token> doRefreshToken,
    TokenHeaderBuilder<OAuth2Token> tokenHeader,
  }) {
    return CustomAuthLink<OAuth2Token>(
      doRefreshToken: doRefreshToken,
      tokenStorage: tokenStorage,
      shouldRefresh: shouldRefresh,
      tokenHeader: tokenHeader ??
          (token) =>
              {"Authorization": "${token.tokenType} ${token.accessToken}"},
    );
  }

  final RefreshToken<T> _refreshToken;
  final TokenHeaderBuilder<T> _buildHeader;
  final ShouldRefresh _shouldRefresh;

  @override
  Stream<Response> request(
    Request request, [
    NextLink forward,
  ]) async* {
    // First, try to intercept the current request, append Authorization header:
    final currentToken = await token;
    final shouldBuildAuthHeader = currentToken != null && _buildHeader != null;
    final tokenHeaders = shouldBuildAuthHeader
        ? _buildHeader(currentToken)
        : const <String, String>{};

    final interceptedRequest = _interceptTokenHeader(request, tokenHeaders);

    // Make an authorized request with the access token in the header:
    try {
      await for (final result in forward(interceptedRequest)) {
        yield result;
      }
    } on ServerException catch (exception) {
      // Potentially, access token is expired, let's check:
      if (token != null && _shouldRefresh(exception.parsedResponse)) {
        // Yes, it's expired, refresh the access token using refresh token:
        try {
          final refreshedToken = await _refreshToken(await token);
          await setToken(refreshedToken);
          final newHeaders = _buildHeader(refreshedToken);
          final updatedTokenRequest =
              _interceptTokenHeader(request, newHeaders);
          yield* forward(updatedTokenRequest);
        } on RevokeTokenException catch (_) {
          // Token is revoked, no use to refresh
          unawaited(revokeToken());
          yield exception.parsedResponse;
        }
      } else {
        // Different error, we don't handle here so passing it through
        yield exception.parsedResponse;
      }
    } catch (exception) {
      // Any other exception that is not [ServerException], we pass it through
      yield* exception;
    }
  }

  Request _interceptTokenHeader(
      Request currentRequest, Map<String, String> newHeaders) {
    return currentRequest.updateContextEntry<HttpLinkHeaders>(
      (headers) => HttpLinkHeaders(
        headers: {
          ...headers?.headers ?? <String, String>{},
        }..addAll(newHeaders),
      ),
    );
  }
}
