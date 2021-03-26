import 'package:json_annotation/json_annotation.dart';

part 'auth_token.g.dart';

@JsonSerializable()
class AuthToken {
  @JsonKey(name: 'access_token')
  String accessToken;
  @JsonKey(name: 'token_type')
  String tokenType;
  @JsonKey(name: 'expires_in')
  double expiresIn;
  @JsonKey(name: 'refresh_token')
  String refreshToken;

  AuthToken(
      {this.accessToken, this.tokenType, this.expiresIn, this.refreshToken});

  factory AuthToken.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenFromJson(json);

  Map<String, dynamic> toJson() => _$AuthTokenToJson(this);
}

@JsonSerializable()
class InnerResponseData {
  int id;
  String type;
  @JsonKey(name: 'attributes')
  AuthToken authToken;

  InnerResponseData({this.id, this.type, this.authToken});

  factory InnerResponseData.fromJson(Map<String, dynamic> json) =>
      _$InnerResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$InnerResponseDataToJson(this);
}

@JsonSerializable()
class AuthTokenResponseData {
  InnerResponseData data;

  AuthTokenResponseData({this.data});

  factory AuthTokenResponseData.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuthTokenResponseDataToJson(this);
}
