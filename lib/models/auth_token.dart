class AuthToken {
  String accessToken;
  String refreshToken;
  int expiresIn;
  String tokenType;

  AuthToken(
      {this.accessToken, this.tokenType, this.expiresIn, this.refreshToken});
}
