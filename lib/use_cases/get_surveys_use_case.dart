import 'package:survey/models/survey.dart';
import 'package:survey/repositories/survey_repository.dart';
import 'package:survey/use_cases/base_use_case.dart';

class GetSurveysUseCase extends UseCase<List<Survey>, GetSurveysInput> {
  final SurveyRepositoryImpl _surveyRepository;

  const GetSurveysUseCase(this._surveyRepository);

  @override
  Future<Result<List<Survey>>> call(GetSurveysInput input) async {
    try {
      final result = await _surveyRepository.getSurveys(
          input.cursor, input.forceNetworkData);
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception, null));
    }
  }
}

class GetSurveysInput {
  final String cursor;
  final bool forceNetworkData;

  GetSurveysInput({this.cursor, this.forceNetworkData = false});
}
