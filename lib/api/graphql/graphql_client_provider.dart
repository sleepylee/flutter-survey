import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fresh_graphql/fresh_graphql.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:survey/api/graphql/const.dart';
import 'package:survey/api/graphql/link/custom_auth_link.dart';
import 'package:survey/api/http/api_client.dart';
import 'package:survey/repositories/oauth_repository.dart';

import '../../flavors.dart';

class GraphQLClientProvider {
  final HttpLink _httpLink;

  const GraphQLClientProvider._(this._httpLink);

  static CustomAuthLink _customAuthLink;
  static GraphQLClient _client;

  factory GraphQLClientProvider() {
    return GraphQLClientProvider._(
      HttpLink(F.graphQLEndpoint),
    );
  }

  @visibleForTesting
  void setGraphQLClient(GraphQLClient injectedClient) {
    _client = injectedClient;
  }

  GraphQLClient get client {
    if (_client == null) {
      Link _allLink;
      if (_customAuthLink != null) {
        _allLink = _customAuthLink.concat(_httpLink);
      } else {
        _allLink = _httpLink;
      }

      final cacheStore = Get.find<Store>();
      _client = GraphQLClient(
        cache: GraphQLCache(store: cacheStore),
        link: _allLink,
      );
    }
    return _client;
  }

  /// Call this when you have already set up the token storage, the token header
  /// will be updated automatically
  void tokenIsReadyToUse() {
    final tokenStorage = Get.find<TokenStorage<OAuth2Token>>();
    _customAuthLink = CustomAuthLink.oAuth2(
      tokenStorage: tokenStorage,
      shouldRefresh: (response) {
        var hasAuthError = response.errors != null &&
            response.errors.any((element) =>
                element.extensions['code'] == CODE_INVALID_OR_EXPIRED_TOKEN);
        return hasAuthError;
      },
      doRefreshToken: (oauth2Token) async {
        final httpClient = Get.find<ApiClient>();
        final oauthRepositoryImpl = OAuthRepositoryImpl(httpClient);
        final refreshResult =
            await oauthRepositoryImpl.refreshToken(oauth2Token.refreshToken);

        return OAuth2Token(
          accessToken: refreshResult.accessToken,
          refreshToken: refreshResult.refreshToken,
          expiresIn: refreshResult.expiresIn,
          tokenType: refreshResult.tokenType,
        );
      },
    );
  }

  void removeAuthToken() {
    _customAuthLink = null;
  }
}
