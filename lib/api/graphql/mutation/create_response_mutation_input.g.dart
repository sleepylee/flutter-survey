// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_response_mutation_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateResponseMutationInput _$CreateResponseMutationInputFromJson(
    Map<String, dynamic> json) {
  return CreateResponseMutationInput(
    json['response'] == null
        ? null
        : SurveySubmission.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateResponseMutationInputToJson(
        CreateResponseMutationInput instance) =>
    <String, dynamic>{
      'response': instance.response,
    };

SurveySubmission _$SurveySubmissionFromJson(Map<String, dynamic> json) {
  return SurveySubmission(
    json['surveyId'] as String,
    (json['questions'] as List)
        ?.map((e) => e == null
            ? null
            : SurveyQuestionSubmission.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SurveySubmissionToJson(SurveySubmission instance) =>
    <String, dynamic>{
      'surveyId': instance.surveyId,
      'questions': instance.questions,
    };

SurveyQuestionSubmission _$SurveyQuestionSubmissionFromJson(
    Map<String, dynamic> json) {
  return SurveyQuestionSubmission(
    json['id'] as String,
    (json['answers'] as List)
        ?.map((e) => e == null
            ? null
            : SurveyAnswerSubmission.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SurveyQuestionSubmissionToJson(
        SurveyQuestionSubmission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'answers': instance.answers,
    };

SurveyAnswerSubmission _$SurveyAnswerSubmissionFromJson(
    Map<String, dynamic> json) {
  return SurveyAnswerSubmission(
    json['id'] as String,
    json['answer'] as String,
  );
}

Map<String, dynamic> _$SurveyAnswerSubmissionToJson(
        SurveyAnswerSubmission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'answer': instance.answer,
    };
