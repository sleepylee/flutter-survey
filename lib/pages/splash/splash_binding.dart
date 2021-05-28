import 'package:get/get.dart';
import 'package:survey/preferences/shared_preferences.dart';
import 'package:survey/use_cases/get_login_state_use_case.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    final sharedPref = Get.find<SharedPreferencesStorage>();
    Get.put(GetLoginStateUseCase(sharedPref));
  }
}
