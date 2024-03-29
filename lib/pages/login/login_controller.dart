import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/login_use_case.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> attemptLogin(
      {VoidCallback onSuccess, VoidCallback onFailed}) async {
    isLoading.value = true;

    final loginUseCase = Get.find<LoginUseCase>();
    final credential = LoginCredential(
        email: emailController.text, password: passwordController.text);

    loginUseCase.call(credential).then((result) {
      if (result is Success && onSuccess != null) {
        onSuccess.call();
      } else {
        isLoading.value = false;
        if (onFailed != null) onFailed.call();
      }
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
