class AuthToken {
  String accessToken;
  String refreshToken;
  int expiresIn;
  String tokenType;

  AuthToken(
      {required this.accessToken,
      required this.tokenType,
      required this.expiresIn,
      required this.refreshToken});
}
