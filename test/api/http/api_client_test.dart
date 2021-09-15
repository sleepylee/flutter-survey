import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/api/http/api_client_provider.dart';
import 'package:survey/api/http/request/oauth_token_request.dart';
import 'package:survey/api/http/request/refresh_token_request.dart';
import 'package:survey/api/http/response/auth_token_response.dart';

import '../../mocks/generate_mocks.mocks.dart';

main() {
  final testedApiClientProvider = ApiClientProvider();
  final mockHttpClientAdapter = MockHttpClientAdapter();
  testedApiClientProvider.injectHttpClientAdapter(mockHttpClientAdapter);

  final testedHttpApiClient = testedApiClientProvider.httpClient();

  group('Validate http ApiClient - login', () {
    test('When login successfully, it returns AuthTokenResponseData', () async {
      final oauthJsonFile = File('test/test_resources/oauth.json');

      final fakeHttpResponse = ResponseBody.fromString(
        oauthJsonFile.readAsStringSync(),
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
      when(mockHttpClientAdapter.fetch(any, any, any))
          .thenAnswer((_) async => fakeHttpResponse);

      // Use fromJson for more test coverage
      final result =
          await testedHttpApiClient.login(OAuthTokenRequest.fromJson({
        'grant_type': 'password',
        'email': 'any',
        'password': 'password',
        'client_id': 'client_id',
        'client_secret': 'client_secret'
      }));

      expect(result, isA<AuthTokenResponseData>());
      expect(result.data.type, 'token');
      expect(result.data.authToken.accessToken, 'access token');
    });

    test('When login unsuccessfully, it returns DioError', () async {
      final oauthJsonFile = File('test/test_resources/oauth_error.json');

      final fakeHttpResponse = ResponseBody.fromString(
        oauthJsonFile.readAsStringSync(),
        400,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
      when(mockHttpClientAdapter.fetch(any, any, any))
          .thenAnswer((_) async => fakeHttpResponse);

      final result =
          () => testedHttpApiClient.login(OAuthTokenRequest.fromJson({
                'grant_type': 'password',
                'email': 'any',
                'password': 'failed password',
                'client_id': 'client_id',
                'client_secret': 'client_secret'
              }));

      expect(result,
          throwsA(predicate<DioError>((ex) => ex.response.statusCode == 400)));
    });

    test('When refresh token successfully, it returns AuthTokenResponseData',
        () async {
      final oauthJsonFile = File('test/test_resources/oauth.json');

      final fakeHttpResponse = ResponseBody.fromString(
        oauthJsonFile.readAsStringSync(),
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
      when(mockHttpClientAdapter.fetch(any, any, any))
          .thenAnswer((_) async => fakeHttpResponse);

      // Use fromJson for more test coverage
      final result =
          await testedHttpApiClient.refreshToken(RefreshTokenRequest.fromJson({
        'grant_type': 'refresh',
        'refresh': 'refresh_token',
        'client_id': 'client_id',
        'client_secret': 'client_secret'
      }));

      expect(result, isA<AuthTokenResponseData>());
      expect(result.data.type, 'token');
      expect(result.data.authToken.accessToken, 'access token');
    });

    test('When refresh token unsuccessfully, it returns DioError', () async {
      final oauthJsonFile = File('test/test_resources/oauth_error.json');

      final fakeHttpResponse = ResponseBody.fromString(
        oauthJsonFile.readAsStringSync(),
        401,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
      when(mockHttpClientAdapter.fetch(any, any, any))
          .thenAnswer((_) async => fakeHttpResponse);

      final result =
          () => testedHttpApiClient.refreshToken(RefreshTokenRequest.fromJson({
                'grant_type': 'refresh',
                'refresh_token': 'failed refresh_token',
                'client_id': 'client_id',
                'client_secret': 'client_secret'
              }));

      expect(
          result,
          throwsA(predicate(
              (ex) => ex is DioError && ex.response.statusCode == 401)));
    });
  });
}
