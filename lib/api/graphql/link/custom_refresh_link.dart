import 'dart:async';

import 'package:fresh/fresh.dart';
import 'package:graphql/client.dart';
import 'package:meta/meta.dart';
import 'package:pedantic/pedantic.dart';

typedef ShouldRefresh = bool Function(Response);

typedef RefreshToken<T> = Future<T> Function(T);

/// {@template fresh_link}
/// A GraphQL Link which handles manages an authentication token automatically.
///
/// A constructor that returns a Fresh interceptor that uses the
/// [OAuth2Token] token, the standard token class and define the`
/// tokenHeader as 'authorization': '${token.tokenType} ${token.accessToken}'
///
/// ```dart
/// final freshLink = FreshLink(
///   tokenStorage: InMemoryTokenStorage(),
///   doRefreshing: (token) {
///     // Perform refresh and return new token
///   },
/// );
/// final graphQLClient = GraphQLClient(
///   cache: InMemoryCache(),
///   link: Link.from([freshLink, HttpLink(uri: 'https://my.graphql.api')]),
/// );
/// ```
/// {@endtemplate}
class CustomRefreshLink<T> extends Link with FreshMixin<T> {
  /// {@macro fresh_link}
  CustomRefreshLink({
    @required TokenStorage<T> tokenStorage,
    @required RefreshToken<T> refreshToken,
    @required ShouldRefresh shouldRefresh,
    TokenHeaderBuilder<T> tokenHeader,
  })  : assert(tokenStorage != null),
        assert(refreshToken != null),
        assert(shouldRefresh != null),
        _refreshToken = refreshToken,
        _tokenHeader = tokenHeader,
        _shouldRefresh = shouldRefresh {
    this.tokenStorage = tokenStorage;
  }

  ///{@template fresh_link}
  ///A GraphQL Link which handles manages an authentication token automatically.
  ///
  /// ```dart
  /// final freshLink = FreshLink.oAuth2(
  ///   tokenStorage: InMemoryTokenStorage<OAuth2Token>(),
  ///   refreshToken: (token, client) {
  ///     // Perform refresh and return new token
  ///   },
  /// );
  /// final graphQLClient = GraphQLClient(
  ///   cache: InMemoryCache(),
  ///   link: Link.from([freshLink, HttpLink(uri: 'https://my.graphql.api')]),
  /// );
  /// ```
  /// {@endtemplate}
  static CustomRefreshLink<OAuth2Token> oAuth2({
    @required TokenStorage<OAuth2Token> tokenStorage,
    @required RefreshToken<OAuth2Token> doRefreshing,
    @required ShouldRefresh shouldRefresh,
    TokenHeaderBuilder<OAuth2Token> tokenHeader,
  }) {
    return CustomRefreshLink<OAuth2Token>(
      refreshToken: doRefreshing,
      tokenStorage: tokenStorage,
      shouldRefresh: shouldRefresh,
      tokenHeader: tokenHeader ??
          (token) {
            return {
              'authorization': '${token.tokenType} ${token.accessToken}',
            };
          },
    );
  }

  final RefreshToken<T> _refreshToken;
  final TokenHeaderBuilder<T> _tokenHeader;
  final ShouldRefresh _shouldRefresh;

  @override
  Stream<Response> request(
    Request request, [
    NextLink forward,
  ]) async* {
    final currentToken = await token;
    final tokenHeaders = currentToken != null && _tokenHeader != null
        ? _tokenHeader(currentToken)
        : const <String, String>{};

    request.updateContextEntry<HttpLinkHeaders>(
      (headers) => HttpLinkHeaders(
        headers: {
          ...headers?.headers ?? <String, String>{},
        }..addAll(tokenHeaders),
      ),
    );
    try {
      await for (final result in forward(request)) {
        yield result;
      }
    } on ServerException catch (exception) {
      if (token != null && _shouldRefresh(exception.parsedResponse)) {
        try {
          final refreshedToken = await _refreshToken(await token);
          await setToken(refreshedToken);
          final tokenHeaders = _tokenHeader(refreshedToken);
          final newRequest = request.updateContextEntry<HttpLinkHeaders>(
            (headers) => HttpLinkHeaders(
              headers: {
                ...headers?.headers ?? <String, String>{},
              }..addAll(tokenHeaders),
            ),
          );
          yield* forward(newRequest);
        } on RevokeTokenException catch (_) {
          unawaited(revokeToken());
          yield exception.parsedResponse;
        }
      } else {
        yield exception.parsedResponse;
      }
    }
  }
}
