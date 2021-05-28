import 'package:get/get.dart';

abstract class AppNavigator {
  void popAndNavigateToLogin();

  void popAndNavigateToHome();
}

class AppNavigatorImpl implements AppNavigator {
  @override
  void popAndNavigateToLogin() {
    Get.offAndToNamed('/login');
  }

  @override
  void popAndNavigateToHome() {
    Get.offAndToNamed('/home');
  }
}
