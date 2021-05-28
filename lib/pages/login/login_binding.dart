import 'package:get/get.dart';
import 'package:survey/preferences/shared_preferences.dart';
import 'package:survey/repositories/oauth_repository.dart';
import 'package:survey/use_cases/login_use_case.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    final oauthRepository = OAuthRepositoryImpl(Get.find());
    final sharedPref = Get.find<SharedPreferencesStorage>();
    Get.put(LoginUseCase(oauthRepository, sharedPref));
  }
}
