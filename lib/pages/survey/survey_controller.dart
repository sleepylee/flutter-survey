import 'package:get/get.dart';
import 'package:optional/optional.dart';
import 'package:survey/models/survey.dart';
import 'package:survey/navigator/const.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/get_survey_detail_use_case.dart';

class SurveyController extends GetxController {
  final Rx<Optional<Survey>> _survey = Optional<Survey>.empty().obs;

  Optional<Survey> get optionalSurvey => _survey.value;

  int get questionAmount => optionalSurvey.value.questions.length;

  final _currentQuestion = 0.obs;

  int get currentQuestionIndex => _currentQuestion.value;

  SurveyQuestion get currentQuestion =>
      optionalSurvey.value.questions[currentQuestionIndex];

  String get indexString => _getIndexString();

  @override
  void onInit() {
    super.onInit();
    _getSurvey();
  }

  void _getSurvey() {
    final surveyId = Get.arguments[DATA_SURVEY_ID];
    final getSurveyUseCase = Get.find<GetSurveyDetailUseCase>();
    getSurveyUseCase.call(surveyId).then((result) {
      if (result is Success<Survey>) {
        _survey.value = Optional.of(result.value);
      } else {
        print("Error when fetching survey, handle Error later.");
      }
    });
  }

  String _getIndexString() {
    if (_survey.value.isEmpty) return "";
    return "${currentQuestionIndex + 1}/$questionAmount";
  }

  void onNextQuestion() {
    if (currentQuestionIndex == questionAmount - 1) {
      // TODO: do submission
      return;
    }
    _currentQuestion.value = currentQuestionIndex + 1;
  }
}
