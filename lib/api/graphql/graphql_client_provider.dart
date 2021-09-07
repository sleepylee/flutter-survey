import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fresh_graphql/fresh_graphql.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:survey/api/graphql/const.dart';
import 'package:survey/api/graphql/link/custom_auth_link.dart';
import 'package:survey/api/http/api_client.dart';
import 'package:survey/api/http/request/refresh_token_request.dart';
import 'package:survey/preferences/shared_preferences.dart';

import '../../flavors.dart';

class GraphQLClientProvider {
  final HttpLink _httpLink;

  const GraphQLClientProvider._(this._httpLink);

  static CustomAuthLink _customAuthLink;
  static GraphQLClient _client;

  factory GraphQLClientProvider({@nullable GraphQLClient injectedClient}) {
    _client = injectedClient;
    return GraphQLClientProvider._(
      HttpLink(F.graphQLEndpoint),
    );
  }

  GraphQLClient get client {
    if (_client == null) {
      Link _allLink;
      if (_customAuthLink != null) {
        _allLink = _customAuthLink.concat(_httpLink);
      } else {
        _allLink = _httpLink;
      }
      _client = GraphQLClient(
        cache: GraphQLCache(store: HiveStore()),
        link: _allLink,
      );
    }
    return _client;
  }

  /// Call this when you have already set up the token storage, the token header
  /// will be updated automatically
  void tokenIsReadyToUse() {
    _customAuthLink = CustomAuthLink.oAuth2(
      tokenStorage: LocalSharedPreferencesStorage(),
      shouldRefresh: (response) {
        var hasAuthError = response.errors != null &&
            response.errors.any((element) =>
            element.extensions['code'] == CODE_INVALID_OR_EXPIRED_TOKEN);
        return hasAuthError;
      },
      doRefreshToken: (oauth2Token) async {
        final httpClient = Get.find<ApiClient>();
        final refreshResult = await httpClient.refreshToken(
          RefreshTokenRequest(
            refreshToken: oauth2Token.refreshToken,
            clientId: F.basicAuthClientId,
            clientSecret: F.basicAuthClientSecret,
          ),
        );

        if (refreshResult.data == null) return null;

        final tokenResponse = refreshResult.data.authToken;
        return OAuth2Token(
          accessToken: tokenResponse.accessToken,
          refreshToken: tokenResponse.refreshToken,
          expiresIn: tokenResponse.expiresIn,
          tokenType: tokenResponse.tokenType,
        );
      },
    );
  }

  void removeAuthToken() {
    _customAuthLink = null;
  }
}
