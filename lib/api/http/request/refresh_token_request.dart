import 'package:json_annotation/json_annotation.dart';

import 'api_const.dart';

part 'refresh_token_request.g.dart';

@JsonSerializable()
class RefreshTokenRequest {
  @JsonKey(name: 'grant_type')
  String grantType;
  @JsonKey(name: 'refresh_token')
  String refreshToken;
  @JsonKey(name: 'client_id')
  String clientId;
  @JsonKey(name: 'client_secret')
  String clientSecret;

  RefreshTokenRequest(
      {this.grantType = GRANT_TYPE_REFRESH_TOKEN,
      this.refreshToken,
      this.clientId,
      this.clientSecret});

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}
