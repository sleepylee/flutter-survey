// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveysResponse _$SurveysResponseFromJson(Map<String, dynamic> json) {
  return SurveysResponse(
    edges: (json['edges'] as List)
        ?.map((e) => e == null
            ? null
            : SurveyNodeResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SurveysResponseToJson(SurveysResponse instance) =>
    <String, dynamic>{
      'edges': instance.edges,
    };

SurveyNodeResponse _$SurveyNodeResponseFromJson(Map<String, dynamic> json) {
  return SurveyNodeResponse(
    cursor: json['cursor'] as String,
    node: json['node'] == null
        ? null
        : SurveyResponse.fromJson(json['node'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SurveyNodeResponseToJson(SurveyNodeResponse instance) =>
    <String, dynamic>{
      'cursor': instance.cursor,
      'node': instance.node,
    };

SurveyResponse _$SurveyResponseFromJson(Map<String, dynamic> json) {
  return SurveyResponse(
    id: json['id'] as String,
    title: json['title'] as String,
    coverImageUrl: json['coverImageUrl'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$SurveyResponseToJson(SurveyResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'coverImageUrl': instance.coverImageUrl,
      'description': instance.description,
    };
