import 'package:get/get.dart';
import 'package:optional/optional.dart';
import 'package:survey/models/survey.dart';
import 'package:survey/navigator/const.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/create_response_use_case.dart';
import 'package:survey/use_cases/get_survey_detail_use_case.dart';

class SurveyController extends GetxController {
  final Rx<Optional<Survey>> _survey = Optional<Survey>.empty().obs;

  Optional<Survey> get optionalSurvey => _survey.value;

  int get questionAmount => optionalSurvey.value.questions.length;

  final _currentQuestion = 0.obs;

  int get currentQuestionIndex => _currentQuestion.value;

  SurveyQuestion get currentQuestion =>
      optionalSurvey.value.questions[currentQuestionIndex];

  String get nextQuestionImage {
    if (currentQuestionIndex != optionalSurvey.value.questions.length - 1) {
      return optionalSurvey
          .value.questions[currentQuestionIndex + 1].hdCoverImageUrl;
    }
    return null;
  }

  String get indexTitleText => _getIndexText();

  ResponseInput _responseInput;
  List<AnswerDetail> _currentAnswer = List.empty(growable: true);

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
        _responseInput = ResponseInput(result.value.id);
      } else {
        print("Error when fetching survey, handle Error later.");
      }
    });
  }

  String _getIndexText() {
    if (_survey.value.isEmpty) return "";
    return "${currentQuestionIndex + 1}/$questionAmount";
  }

  void onNextQuestion() {
    if (currentQuestionIndex == questionAmount - 1) {
      // TODO: do submission
      return;
    }
    if (!currentQuestion.doesNotRequireAnswer) {
      _responseInput.questionsAndAnswers[currentQuestion.id] =
          List.from(_currentAnswer);
      _currentAnswer.clear();
    }
    print("ResponseInput: $_responseInput");

    _currentQuestion.value = currentQuestionIndex + 1;
  }

  void onAnswerSelected(Map<String, String> idAndAnswer) {
    _currentAnswer = idAndAnswer.entries
        .map((entry) => AnswerDetail(entry.key, entry.value))
        .toList();
    print("Rated on: Question: ${currentQuestion.id} Answers: $_currentAnswer");
  }
}
