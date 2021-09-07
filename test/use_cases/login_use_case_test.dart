import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/exception/network_exceptions.dart';
import 'package:survey/models/auth_token.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/login_use_case.dart';
import 'package:test/test.dart';

import '../fakers/fake_graphql_client_provider.dart';
import '../fakers/fake_shared_preferences_storage.dart';
import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('Validate login use case', () {
    final mockRepository = MockOAuthRepository();
    final mockStorage = FakeSharedPreferencesStorage();
    final mockGraphQLClientProvider = FakeGraphQLClientProvider();

    when(mockRepository.login('positive', 'test')).thenAnswer(
      (_) async => AuthToken(
          accessToken: 'token',
          tokenType: 'bearer',
          expiresIn: 5000,
          refreshToken: 'refresh token'),
    );

    when(mockRepository.login('negative', any)).thenAnswer((_) => Future.error(
        DioError(
            response: Response(statusCode: 400), type: DioErrorType.RESPONSE)));

    final loginUseCase =
        LoginUseCase(mockRepository, mockStorage, mockGraphQLClientProvider);

    test('When login with valid credential, it returns Success', () async {
      final result = await loginUseCase
          .call(LoginCredential(email: 'positive', password: 'test'));

      expect(result, isA<Success>());
    });

    test('When login with invalid credential, it returns Failed', () async {
      final result = await loginUseCase
          .call(LoginCredential(email: 'negative', password: 'meh'));

      expect(result, isA<Failed>());
      expect((result as Failed).exception.networkExceptions,
          NetworkExceptions.unauthorisedRequest());
    });
  });
}
