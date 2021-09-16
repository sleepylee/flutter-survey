import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:survey/api/http/api_client.dart';
import 'package:survey/repositories/oauth_repository.dart';
import 'package:survey/repositories/user_repository.dart';
import 'package:survey/use_cases/get_profile_use_case.dart';

@GenerateMocks([
  UserRepository,
  OAuthRepository,
  GraphQLClient,
  GetProfileUseCase,
  ApiClient,
  HttpClientAdapter
])
main() {
  // empty class to generate mock repository classes
}
