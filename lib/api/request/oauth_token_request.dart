import 'package:json_annotation/json_annotation.dart';

import 'api_const.dart';

part 'oauth_token_request.g.dart';

@JsonSerializable()
class OAuthTokenRequest {
  @JsonKey(name: 'grant_type')
  String grantType;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'password')
  String password;
  @JsonKey(name: 'client_id')
  String clientId;
  @JsonKey(name: 'client_secret')
  String clientSecret;

  OAuthTokenRequest(
      {this.grantType = GRANT_TYPE_PASSWORD,
      this.email,
      this.password,
      this.clientId,
      this.clientSecret});

  factory OAuthTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$OAuthTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OAuthTokenRequestToJson(this);
}
