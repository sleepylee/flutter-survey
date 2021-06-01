// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    email: json['email'] as String,
    avatarUrl: json['avatar_url'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'avatar_url': instance.avatarUrl,
    };

InnerResponseData _$InnerResponseDataFromJson(Map<String, dynamic> json) {
  return InnerResponseData(
    id: json['id'] as String,
    type: json['type'] as String,
    user: json['attributes'] == null
        ? null
        : User.fromJson(json['attributes'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InnerResponseDataToJson(InnerResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': instance.user,
    };

UserResponseData _$UserResponseDataFromJson(Map<String, dynamic> json) {
  return UserResponseData(
    data: json['data'] == null
        ? null
        : InnerResponseData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserResponseDataToJson(UserResponseData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
