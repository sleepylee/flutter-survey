import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:survey/managers/user_manager.dart';
import 'package:survey/models/survey.dart';
import 'package:survey/pages/home/survey_carousel/survey_ui_model.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/get_surveys_use_case.dart';

const HOME_DISPLAY_DATE_FORMAT = 'EEEE, MMMM dd';

class HomeController extends GetxController {
  final _currentDateText = "".obs;

  String get currentDateText => _currentDateText.value;

  final _currentUserAvatarUrl = "".obs;

  String get currentUserAvatarUrl => _currentUserAvatarUrl.value;

  final RxList<Survey> _surveys = RxList.empty(growable: true);

  List<SurveyUiModel> get surveyUiModels => _surveys.isEmpty
      ? List.empty()
      // ignore: invalid_use_of_protected_member
      : _surveys.value
          .map((e) => SurveyUiModel(
                id: e.id,
                title: e.title,
                description: e.description,
                imageUrl: e.hdCoverImageUrl,
              ))
          .toList(growable: true);

  bool _paginationFinished = false;

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

  void _getSurveys() async {
    if (_paginationFinished) {
      return;
    }

    final getSurveysUseCase = Get.find<GetSurveysUseCase>();
    // ignore: invalid_use_of_protected_member
    if (_surveys.value.isEmpty) {
      final surveys = await getSurveysUseCase.call("");
      if (surveys is Success<List<Survey>>) {
        surveys.value.forEach((element) {
          _surveys.add(element);
        });
      }
    } else {
      // ignore: invalid_use_of_protected_member
      final lastCursor = _surveys.value.last.cursor;
      final surveys = await getSurveysUseCase.call(lastCursor);
      if (surveys is Success<List<Survey>>) {
        if (surveys.value.isEmpty) {
          _paginationFinished = true;
          return;
        }

        surveys.value.forEach((element) {
          _surveys.add(element);
        });
      }
    }
  }

  void onIndexChanged(int index) {
    // ignore: invalid_use_of_protected_member
    if (index == _surveys.value.length - 2) {
      _getSurveys(); // load more
    }
  }
}
