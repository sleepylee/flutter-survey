import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:survey/managers/user_manager.dart';

const HOME_DISPLAY_DATE_FORMAT = 'EEEE, MMMM dd';

class HomeController extends GetxController {
  final currentDateText = "".obs;
  final currentUserAvatar = "".obs;

  @override
  void onInit() {
    super.onInit();

    _setDate();
    _setUserAvatar();
  }

  void _setDate() {
    currentDateText.value = DateFormat(HOME_DISPLAY_DATE_FORMAT)
        .format(DateTime.now())
        .toUpperCase();
  }

  void _setUserAvatar() {
    final userManager = Get.find<UserManager>();
    userManager.getCurrentUser().listen((user) {
      currentUserAvatar.value = user.avatarUrl;
    });
  }
}
