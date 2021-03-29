// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthToken _$AuthTokenFromJson(Map<String, dynamic> json) {
  return AuthToken(
    accessToken: json['access_token'] as String,
    tokenType: json['token_type'] as String,
    expiresIn: (json['expires_in'] as num)?.toDouble(),
    refreshToken: json['refresh_token'] as String,
  );
}

Map<String, dynamic> _$AuthTokenToJson(AuthToken instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'refresh_token': instance.refreshToken,
    };

InnerResponseData _$InnerResponseDataFromJson(Map<String, dynamic> json) {
  return InnerResponseData(
    id: json['id'] as int,
    type: json['type'] as String,
    authToken: json['attributes'] == null
        ? null
        : AuthToken.fromJson(json['attributes'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InnerResponseDataToJson(InnerResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': instance.authToken,
    };

AuthTokenResponseData _$AuthTokenResponseDataFromJson(
    Map<String, dynamic> json) {
  return AuthTokenResponseData(
    data: json['data'] == null
        ? null
        : InnerResponseData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AuthTokenResponseDataToJson(
        AuthTokenResponseData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
