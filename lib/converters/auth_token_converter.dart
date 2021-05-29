import 'package:survey/api/http/response/auth_token_response.dart';
import 'package:survey/models/auth_token.dart';

extension AuthTokenConverter on AuthTokenResponse {
  AuthToken toAuthToken() {
    return AuthToken(
      accessToken: accessToken,
      tokenType: tokenType,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
    );
  }
}
