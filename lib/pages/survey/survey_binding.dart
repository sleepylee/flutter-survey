import 'package:get/get.dart';
import 'package:survey/repositories/survey_repository.dart';
import 'package:survey/use_cases/create_response_use_case.dart';
import 'package:survey/use_cases/get_survey_detail_use_case.dart';

class SurveyBinding implements Bindings {
  @override
  void dependencies() {
    final surveyRepository = Get.find<SurveyRepository>();
    Get.lazyPut(() => GetSurveyDetailUseCase(surveyRepository));
    Get.lazyPut(() => CreateSurveyResponseUseCase(surveyRepository));
  }
}
