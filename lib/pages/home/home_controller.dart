import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:survey/managers/user_manager.dart';

const HOME_DISPLAY_DATE_FORMAT = 'EEEE, MMMM dd';
const AVATAR_PLACE_HOLDER =
    "https://t3.ftcdn.net/jpg/02/33/46/24/360_F_233462402_Fx1yke4ng4GA8TJikJZoiATrkncvW6Ib.jpg";

class HomeController extends GetxController {
  final currentDateText = "".obs;
  final currentUserAvatar = AVATAR_PLACE_HOLDER.obs;

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
