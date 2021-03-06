import 'package:survey/api/graphql/mutation/create_response_mutation_input.dart';
import 'package:survey/repositories/survey_repository.dart';

import 'base_use_case.dart';

class CreateSurveyResponseUseCase extends UseCase<void, ResponseInput> {
  final SurveyRepository _surveyRepository;

  CreateSurveyResponseUseCase(this._surveyRepository);

  @override
  Future<Result<void>> call(ResponseInput params) async {
    try {
      final input = CreateResponseMutationInput(
        SurveySubmission(
          params.surveyId,
          params.questionsAndAnswers.entries
              .map(
                (entry) => SurveyQuestionSubmission(
                  entry.key, // each question (id)
                  entry.value // all answers
                      .map((answer) =>
                          SurveyAnswerSubmission(answer.id, answer.answer))
                      .toList(),
                ),
              )
              .toList(),
        ),
      );
      await _surveyRepository.createResponse(input);
      return Success(null);
    } catch (exception) {
      return Failed(exception);
    }
  }
}

class ResponseInput {
  final String surveyId;
  Map<String, List<AnswerDetail>> questionsAndAnswers = {};

  ResponseInput(this.surveyId);

  @override
  String toString() {
    return "ResponseInput: SurveyId: $surveyId - $questionsAndAnswers";
  }
}

class AnswerDetail {
  String id;
  String answer;

  AnswerDetail(this.id, this.answer);

  @override
  String toString() {
    return "AnswerDetail: {$id:$answer}";
  }
}
