import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/models/user.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/get_profile_use_case.dart';
import 'package:test/test.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('Validate get profile success use case', () {
    final mockRepository = MockUserRepository();

    when(mockRepository.getProfile()).thenAnswer(
      (_) async => User(id: "id"),
    );

    final getProfileUseCase = GetProfileUseCase(mockRepository);

    test('When get profile successfully, it returns Success', () async {
      final positiveResult = await getProfileUseCase.call();
      expect(positiveResult, isA<Success<User>>());
    });
  });

  group('Validate get profile unsuccessful use case', () {
    final mockRepository = MockUserRepository();
    when(mockRepository.getProfile()).thenAnswer(
      (_) => Future.error(
        DioError(
            response: Response(statusCode: 401), type: DioErrorType.RESPONSE),
      ),
    );
    final getProfileUseCase = GetProfileUseCase(mockRepository);

    test('When get profile unsuccessfully, it returns Failed with details',
        () async {
      final negativeResult = await getProfileUseCase.call();
      expect(negativeResult, isA<Failed>());
    });
  });
}
