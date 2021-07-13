import 'package:json_annotation/json_annotation.dart';

part 'survey_response.g.dart';

@JsonSerializable()
class SurveysResponse {
  List<SurveyNodeResponse> edges;

  SurveysResponse({required this.edges});

  factory SurveysResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveysResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SurveysResponseToJson(this);
}

@JsonSerializable()
class SurveyNodeResponse {
  String cursor;
  SurveyResponse node;

  SurveyNodeResponse({required this.cursor, required this.node});

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

  SurveyResponse(
      {required this.id,
      required this.title,
      required this.coverImageUrl,
      required this.description});

  factory SurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyResponseToJson(this);
}
