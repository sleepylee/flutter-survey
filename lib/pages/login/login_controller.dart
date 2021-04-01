import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/login_use_case.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void attemptLogin() {
    if (formKey.currentState.validate()) {
      Get.focusScope.unfocus();
      final loginUseCase = Get.find<LoginUseCase>();
      final credential =
          LoginCredential(emailController.text, passwordController.text);

      loginUseCase.call(credential).then(
            (result) => {
              if (result is Success)
                Get.offAndToNamed('/home')
              else
                Get.snackbar('Error', 'Login failed')
            },
          );
    }
  }
}
