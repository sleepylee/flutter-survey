class AuthToken {
  var accessToken;
  var refreshToken;
  var tokenType;
  var expiresIn;

  AuthToken(
      {this.accessToken, this.tokenType, this.expiresIn, this.refreshToken});
}
