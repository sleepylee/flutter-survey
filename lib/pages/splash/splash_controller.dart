import 'package:get/get.dart';
import 'package:optional/optional.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/get_login_state_use_case.dart';

class SplashController extends GetxController {
  final Rx<Optional<bool>> isLoggedInUser = Optional<bool>.empty().obs;

  @override
  void onInit() {
    super.onInit();

    final getLoginStateUseCase = Get.find<GetLoginStateUseCase>();
    getLoginStateUseCase.call().then((result) {
      if (result is Success) {
        isLoggedInUser.value = Optional.of((result as Success).value);
      } else {
        isLoggedInUser.value = Optional.of(false);
      }
    });
  }
}
