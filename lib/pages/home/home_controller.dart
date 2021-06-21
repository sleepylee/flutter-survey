import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:survey/managers/user_manager.dart';

const HOME_DISPLAY_DATE_FORMAT = 'EEEE, MMMM dd';

class HomeController extends GetxController {
  final _currentDateText = "".obs;

  String get currentDateText => _currentDateText.value;

  final _currentUserAvatarUrl = "".obs;

  String get currentUserAvatarUrl => _currentUserAvatarUrl.value;

  @override
  void onInit() {
    super.onInit();

    _setDate();
    _setUserAvatar();
  }

  void _setDate() {
    _currentDateText.value = DateFormat(HOME_DISPLAY_DATE_FORMAT)
        .format(DateTime.now())
        .toUpperCase();
  }

  void _setUserAvatar() {
    final userManager = Get.find<UserManager>();
    userManager.getCurrentUser().listen((user) {
      _currentUserAvatarUrl.value = user.avatarUrl;
    });
  }
}
