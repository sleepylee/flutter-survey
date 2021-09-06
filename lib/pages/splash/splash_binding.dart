import 'package:get/get.dart';
import 'package:survey/repositories/user_repository.dart';
import 'package:survey/use_cases/get_login_state_use_case.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    final userRepository = Get.find<UserRepository>();
    Get.put(GetLoginStateUseCase(userRepository));
  }
}
