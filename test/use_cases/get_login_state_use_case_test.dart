import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/repositories/user_repository.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/get_login_state_use_case.dart';
import 'package:test/test.dart';

import 'get_login_state_use_case_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  group('Validate logged-in case', () {
    final mockRepository = MockUserRepository();
    when(mockRepository.isLoggedIn()).thenAnswer((_) async => true);

    final getLoginStateUseCase = GetLoginStateUseCase(mockRepository);
    test('When the user has logged in before, it return Success<true>',
        () async {
      final positiveResult = await getLoginStateUseCase.call();
      expect(positiveResult, isA<Success>());
      expect((positiveResult as Success).value, true);
    });
  });

  group('Validate not logged-in case', () {
    final mockRepository = MockUserRepository();
    when(mockRepository.isLoggedIn()).thenAnswer((_) async => false);

    final getLoginStateUseCase = GetLoginStateUseCase(mockRepository);
    test('When the user has NOT logged in before, it return Success<false>',
        () async {
      final positiveResult = await getLoginStateUseCase.call();
      expect(positiveResult, isA<Success>()); // Not a Result-Failed
      expect((positiveResult as Success).value, false);
    });
  });
}
