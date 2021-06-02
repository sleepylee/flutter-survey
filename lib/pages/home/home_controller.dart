import 'package:get/get.dart';
import 'package:survey/managers/user_manager.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    // TODO: remove all of these when start [Integrate] task
    final userManager = Get.find<UserManager>();
    userManager.getCurrentUser().listen((user) {
      print("User: ${user.id} ${user.email} ${user.avatarUrl}");
    });
  }
}
