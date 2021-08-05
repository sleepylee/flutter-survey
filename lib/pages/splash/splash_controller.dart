import 'package:get/get.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/get_login_state_use_case.dart';

class SplashController extends GetxController {
  Future<bool> get isLoggedInUser async => await _getLoggedInState();

  @override
  void onInit() {
    super.onInit();
    // Do further init here
  }

  Future<bool> _getLoggedInState() async {
    final getLoginStateUseCase = Get.find<GetLoginStateUseCase>();
    final isLoggedIn = await getLoginStateUseCase.call();
    if (isLoggedIn is Success<bool>) {
      return isLoggedIn.value;
    }
    return false;
  }
}
