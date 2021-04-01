import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:survey/navigator/navigator.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/login_use_case.dart';

class LoginController extends GetxController {
  final AppNavigator _appNavigator = Get.find();

  final isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void attemptLogin() {
    if (formKey.currentState.validate()) {
      Get.focusScope.unfocus();
      isLoading.value = true;

      final loginUseCase = Get.find<LoginUseCase>();
      final credential =
          LoginCredential(emailController.text, passwordController.text);

      loginUseCase.call(credential).then((result) {
        if (result is Success) {
          _appNavigator.popAndNavigateToHome();
        } else {
          Get.snackbar(AppLocalizations.of(Get.context).titleGeneralError,
              AppLocalizations.of(Get.context).errorLoginFailed);
          isLoading.value = false;
        }
      });
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
