import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:survey/models/user.dart';

part 'api_client.g.dart';

class Apis {
  static const String oauthLogin = '/api/v1/oauth/token';
  static const String me = '/api/v1/me';
}

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(Apis.me)
  Future<UserResponseData> getUser();
}
