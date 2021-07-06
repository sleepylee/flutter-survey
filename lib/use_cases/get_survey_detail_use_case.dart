import 'package:survey/models/survey.dart';
import 'package:survey/repositories/survey_repository.dart';
import 'package:survey/use_cases/base_use_case.dart';

class GetSurveyDetailUseCase extends UseCase<Survey, String> {
  final SurveyRepositoryImpl _surveyRepository;

  const GetSurveyDetailUseCase(this._surveyRepository);

  @override
  Future<Result<Survey>> call(String id) async {
    try {
      final survey = await _surveyRepository.getSurveyById(id);
      return Success(survey);
    } catch (exception) {
      return Failed(UseCaseException(exception, null));
    }
  }
}
