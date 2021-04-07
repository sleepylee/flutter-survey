import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/pages/login/login_controller.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/login_use_case.dart';

import 'login_controller_test.mocks.dart';

@GenerateMocks([LoginUseCase])
void main() {
  setUp(() {
    Get.testMode = true;
  });

  group('Validate login controller login action', () {
    final mockLoginUseCase = MockLoginUseCase();
    final loginController = LoginController();
    Get.lazyPut<LoginUseCase>(() => mockLoginUseCase);

    loginController.emailController.text = 'hello';
    loginController.passwordController.text = 'pwd';

    test('When login with a valid credential, it calls onSuccess', () async {
      var onSuccessCalled = false;

      when(mockLoginUseCase.call(any)).thenAnswer((_) async => Success(null));

      await loginController.attemptLogin(onSuccess: () {
        onSuccessCalled = true;
      });

      expect(onSuccessCalled, true);
      expect(loginController.isLoading.value, true);
    });

    test('When login with an invalid credential, it calls onFailed', () async {
      var onFailedCalled = false;

      when(mockLoginUseCase.call(any)).thenAnswer((_) async => Failed(null));

      await loginController.attemptLogin(onFailed: () {
        onFailedCalled = true;
      });

      expect(onFailedCalled, true);
      expect(loginController.isLoading.value, false);
    });
  });
}
