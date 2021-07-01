import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:survey/managers/user_manager.dart';
import 'package:survey/models/survey.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/get_surveys_use_case.dart';

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

    _getSurveys();
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

  // TODO: update this to get surveys with pagination in [Integrate]
  void _getSurveys() async {
    final getSurveysUseCase = Get.find<GetSurveysUseCase>();
    final surveys = await getSurveysUseCase.call("MQ");
    if (surveys is Success<List<Survey>>) {
      surveys.value.forEach((element) {
        print("Items: ${element.title} - ${element.description}");
      });
    }
  }
}
