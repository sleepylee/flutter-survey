import 'package:survey/models/survey.dart';
import 'package:survey/repositories/survey_repository.dart';
import 'package:survey/use_cases/base_use_case.dart';

class GetSurveysUseCase extends UseCase<List<Survey>, String> {
  final SurveyRepositoryImpl _surveyRepository;

  const GetSurveysUseCase(this._surveyRepository);

  @override
  Future<Result<List<Survey>>> call(String cursor) async {
    try {
      final result = await _surveyRepository.getSurveys(cursor);
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception, null));
    }
  }
}
