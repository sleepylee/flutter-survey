import 'package:json_annotation/json_annotation.dart';

part 'create_response_mutation_input.g.dart';

@JsonSerializable()
class CreateResponseMutationInput {
  CreateResponseMutationInput(this.response);

  SurveySubmission response;

  factory CreateResponseMutationInput.fromJson(Map<String, dynamic> json) =>
      _$CreateResponseMutationInputFromJson(json);

  Map<String, dynamic> toJson() => _$CreateResponseMutationInputToJson(this);
}

@JsonSerializable()
class SurveySubmission {
  String surveyId;
  List<SurveyQuestionSubmission> questions;

  SurveySubmission(this.surveyId, this.questions);

  factory SurveySubmission.fromJson(Map<String, dynamic> json) =>
      _$SurveySubmissionFromJson(json);

  Map<String, dynamic> toJson() => _$SurveySubmissionToJson(this);
}

@JsonSerializable()
class SurveyQuestionSubmission {
  String id;
  List<SurveyAnswerSubmission> answers;

  SurveyQuestionSubmission(this.id, this.answers);

  factory SurveyQuestionSubmission.fromJson(Map<String, dynamic> json) =>
      _$SurveyQuestionSubmissionFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyQuestionSubmissionToJson(this);
}

@JsonSerializable()
class SurveyAnswerSubmission {
  String id;
  String answer;

  SurveyAnswerSubmission(this.id, this.answer);

  factory SurveyAnswerSubmission.fromJson(Map<String, dynamic> json) =>
      _$SurveyAnswerSubmissionFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyAnswerSubmissionToJson(this);
}
