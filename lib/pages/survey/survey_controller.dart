import 'package:get/get.dart';
import 'package:survey/navigator/const.dart';
import 'package:survey/use_cases/get_survey_detail_use_case.dart';

class SurveyController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    final surveyId = Get.arguments[DATA_SURVEY_ID];
    // TODO: remove this when integrate
    final getSurveyUseCase = Get.find<GetSurveyDetailUseCase>();
    getSurveyUseCase.call(surveyId).then((value) => print("Value: $value"));
  }
}
