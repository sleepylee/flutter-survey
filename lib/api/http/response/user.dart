import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

// TODO: improve all of this if possible, using json:api adapter
@JsonSerializable()
class User {
  String email;
  @JsonKey(name: 'avatar_url')
  String avatarUrl;

  User({this.email, this.avatarUrl});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class InnerResponseData {
  String id;
  String type;
  @JsonKey(name: 'attributes')
  User user;

  InnerResponseData({this.id, this.type, this.user});

  factory InnerResponseData.fromJson(Map<String, dynamic> json) =>
      _$InnerResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$InnerResponseDataToJson(this);
}

@JsonSerializable()
class UserResponseData {
  InnerResponseData data;

  UserResponseData({this.data});

  factory UserResponseData.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseDataToJson(this);
}
