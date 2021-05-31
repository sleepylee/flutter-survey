import 'package:json_annotation/json_annotation.dart';

part 'auth_token_response.g.dart';

@JsonSerializable()
class AuthTokenResponse {
  @JsonKey(name: 'access_token')
  String accessToken;
  @JsonKey(name: 'token_type')
  String tokenType;
  @JsonKey(name: 'expires_in')
  double expiresIn;
  @JsonKey(name: 'refresh_token')
  String refreshToken;

  AuthTokenResponse(
      {this.accessToken, this.tokenType, this.expiresIn, this.refreshToken});

  factory AuthTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenFromJson(json);

  Map<String, dynamic> toJson() => _$AuthTokenToJson(this);
}

@JsonSerializable()
class InnerResponseData {
  int id;
  String type;
  @JsonKey(name: 'attributes')
  AuthTokenResponse authToken;

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