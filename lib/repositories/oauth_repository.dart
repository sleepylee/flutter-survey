import 'package:survey/api/http/api_client.dart';
import 'package:survey/api/http/request/oauth_token_request.dart';
import 'package:survey/api/http/request/refresh_token_request.dart';
import 'package:survey/flavors.dart';
import 'package:survey/models/auth_token.dart';

abstract class OAuthRepository {
  Future<AuthToken> login(String email, String password);

  Future<AuthToken> refreshToken(String refreshToken);
}

class OAuthRepositoryImpl implements OAuthRepository {
  ApiClient _restApiClient;

  OAuthRepositoryImpl(this._restApiClient);

  @override
  Future<AuthToken> login(String email, String password) {
    return _restApiClient
        .login(OAuthTokenRequest(
            email: email,
            password: password,
            clientId: F.basicAuthClientId,
            clientSecret: F.basicAuthClientSecret))
        .then((value) {
      final authTokenResponse = value.data.authToken;
      return AuthToken(
        accessToken: authTokenResponse.accessToken,
        tokenType: authTokenResponse.tokenType,
        refreshToken: authTokenResponse.refreshToken,
        expiresIn: authTokenResponse.expiresIn,
      );
    });
  }

  @override
  Future<AuthToken> refreshToken(String refreshToken) {
    return _restApiClient
        .refreshToken(RefreshTokenRequest(
            refreshToken: refreshToken,
            clientId: F.basicAuthClientId,
            clientSecret: F.basicAuthClientSecret))
        .then((value) {
      final authTokenResponse = value.data.authToken;
      return AuthToken(
        accessToken: authTokenResponse.accessToken,
        tokenType: authTokenResponse.tokenType,
        refreshToken: authTokenResponse.refreshToken,
        expiresIn: authTokenResponse.expiresIn,
      );
    });
  }
}
