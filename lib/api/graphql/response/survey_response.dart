import 'package:json_annotation/json_annotation.dart';

part 'survey_response.g.dart';

@JsonSerializable()
class SurveysResponse {
  List<SurveyNodeResponse> edges;

  SurveysResponse({this.edges});

  factory SurveysResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveysResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SurveysResponseToJson(this);
}

@JsonSerializable()
class SurveyNodeResponse {
  String cursor;
  SurveyResponse node;

  SurveyNodeResponse({this.cursor, this.node});

  factory SurveyNodeResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyNodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyNodeResponseToJson(this);
}

@JsonSerializable()
class SurveyResponse {
  String id;
  String title;
  String coverImageUrl;
  String description;
  @JsonKey(name: "questions")
  List<SurveyQuestionResponse> surveyQuestionResponses;

  SurveyResponse({
    this.id,
    this.title,
    this.coverImageUrl,
    this.description,
    this.surveyQuestionResponses,
  });

  factory SurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyResponseToJson(this);
}

@JsonSerializable()
class SurveyQuestionResponse {
  String id;
  String text;
  String coverImageUrl;
  String displayType;
  bool isMandatory;
  @JsonKey(name: "answers")
  List<SurveyAnswerResponse> surveyAnswerResponses;

  SurveyQuestionResponse({
    this.id,
    this.text,
    this.coverImageUrl,
    this.displayType,
    this.isMandatory,
    this.surveyAnswerResponses,
  });

  factory SurveyQuestionResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyQuestionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyQuestionResponseToJson(this);
}

@JsonSerializable()
class SurveyAnswerResponse {
  String id;
  String text;
  int score;

  SurveyAnswerResponse({this.id, this.text, this.score});

  factory SurveyAnswerResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyAnswerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyAnswerResponseToJson(this);
}
