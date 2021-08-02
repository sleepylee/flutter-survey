import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:survey/api/http/request/oauth_token_request.dart';
import 'package:survey/api/http/request/refresh_token_request.dart';
import 'package:survey/api/http/response/auth_token_response.dart';

part 'api_client.g.dart';

class Apis {
  static const String oauthToken = '/api/v1/oauth/token';
  static const String me = '/api/v1/me';
}

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST(Apis.oauthToken)
  Future<AuthTokenResponseData> login(@Body() OAuthTokenRequest body);

  @POST(Apis.oauthToken)
  Future<AuthTokenResponseData> refreshToken(@Body() RefreshTokenRequest body);
}
