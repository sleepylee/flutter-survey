import 'package:survey/api/http/api_client.dart';
import 'package:survey/api/http/request/oauth_token_request.dart';
import 'package:survey/api/http/request/refresh_token_request.dart';
import 'package:survey/api/http/response/auth_token_response.dart';
import 'package:survey/exception/network_exceptions.dart';
import 'package:survey/flavors.dart';
import 'package:survey/models/auth_token.dart';

abstract class OAuthRepository {
  Future<AuthToken> login(String email, String password);

  Future<AuthTokenResponse> refreshToken(String refreshToken);
}

class OAuthRepositoryImpl implements OAuthRepository {
  ApiClient _restApiClient;

  OAuthRepositoryImpl(this._restApiClient);

  @override
  Future<AuthToken> login(String email, String password) async {
    try {
      final response = await _restApiClient.login(OAuthTokenRequest(
          email: email,
          password: password,
          clientId: F.basicAuthClientId,
          clientSecret: F.basicAuthClientSecret));
      final authTokenResponse = response.data.authToken;
      return AuthToken(
        accessToken: authTokenResponse.accessToken,
        tokenType: authTokenResponse.tokenType,
        refreshToken: authTokenResponse.refreshToken,
        expiresIn: authTokenResponse.expiresIn,
      );
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

  @override
  Future<AuthTokenResponse> refreshToken(String refreshToken) async {
    try {
      final response = await _restApiClient.refreshToken(
        RefreshTokenRequest(
          refreshToken: refreshToken,
          clientId: F.basicAuthClientId,
          clientSecret: F.basicAuthClientSecret,
        ),
      );
      return response.data?.authToken;
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
