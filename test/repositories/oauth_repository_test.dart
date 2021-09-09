import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/api/http/response/auth_token_response.dart';
import 'package:survey/exception/network_exceptions.dart';
import 'package:survey/models/auth_token.dart';
import 'package:survey/repositories/oauth_repository.dart';
import 'package:test/test.dart';

import '../mocks/generate_mocks.mocks.dart';

main() {
  final mockApiClient = MockApiClient();

  final oauthFile = File('test/test_resources/oauth.json');
  final oauthJsonData = jsonDecode(oauthFile.readAsStringSync());

  final testedOAuthRepository = OAuthRepositoryImpl(mockApiClient);

  group('Validate login', () {
    test('When login successfully, it returns AuthToken', () async {
      when(mockApiClient.login(any)).thenAnswer(
          (_) async => AuthTokenResponseData.fromJson(oauthJsonData));

      final result = await testedOAuthRepository.login("email", "password");

      expect(result, isA<AuthToken>());
      expect(result.accessToken, "access token");
    });

    test('When login unsuccessfully, it returns a NetworkException', () async {
      when(mockApiClient.login(any)).thenThrow(DioError(
          response: Response(statusCode: 400), type: DioErrorType.RESPONSE));
      final result = () => testedOAuthRepository.login("email", "password");

      expect(result, throwsA(isA<NetworkExceptions>()));
      expect(result, throwsA(isA<BadRequest>()));
    });
  });
}
