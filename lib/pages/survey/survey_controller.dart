import 'package:get/get.dart';
import 'package:optional/optional.dart';
import 'package:survey/models/survey.dart';
import 'package:survey/navigator/const.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/get_survey_detail_use_case.dart';

class SurveyController extends GetxController {
  final Rx<Optional<Survey>> _survey = Optional<Survey>.empty().obs;

  Optional<Survey> get optionalSurvey => _survey.value;

  @override
  void onInit() {
    super.onInit();
    _getSurvey();
  }

  void _getSurvey() {
    final surveyId = Get.arguments[DATA_SURVEY_ID];
    final getSurveyUseCase = Get.find<GetSurveyDetailUseCase>();
    getSurveyUseCase.call(surveyId).then((result) => {
          if (result is Success<Survey>)
            {_survey.value = Optional.of(result.value)}
          else
            {print("Error when fetching survey, handle Error later.")}
        });
  }
}
