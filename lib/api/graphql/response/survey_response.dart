import 'package:json_annotation/json_annotation.dart';

part 'survey_response.g.dart';

@JsonSerializable()
class SurveysResponse {
  List<SurveyResponse> edges;

  SurveysResponse({this.edges});

  factory SurveysResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveysResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SurveysResponseToJson(this);
}

@JsonSerializable()
class SurveyResponse {
  String cursor;
  NodeResponse node;

  SurveyResponse({this.cursor, this.node});

  factory SurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyResponseToJson(this);
}

@JsonSerializable()
class NodeResponse {
  String id;
  String title;
  String coverImageUrl;
  String description;

  NodeResponse({this.id, this.title, this.coverImageUrl, this.description});

  factory NodeResponse.fromJson(Map<String, dynamic> json) =>
      _$NodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NodeResponseToJson(this);
}
