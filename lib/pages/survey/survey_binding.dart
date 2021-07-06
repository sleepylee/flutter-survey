import 'package:get/get.dart';
import 'package:survey/api/graphql/graphql_client_provider.dart';
import 'package:survey/repositories/survey_repository.dart';
import 'package:survey/use_cases/get_survey_detail_use_case.dart';

class SurveyBinding implements Bindings {
  @override
  void dependencies() {
    final graphQLClientProvider = Get.find<GraphQLClientProvider>();
    final surveyRepository = SurveyRepositoryImpl(graphQLClientProvider.client);
    Get.put(GetSurveyDetailUseCase(surveyRepository));
  }
}
