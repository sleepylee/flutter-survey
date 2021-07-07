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

  SurveyResponse({this.id, this.title, this.coverImageUrl, this.description});

  factory SurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyResponseToJson(this);
}
