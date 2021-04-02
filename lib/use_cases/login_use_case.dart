import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:survey/exception/network_exceptions.dart';
import 'package:survey/models/auth_token.dart';
import 'package:survey/preferences/shared_preferences.dart';
import 'package:survey/repositories/oauth_repository.dart';
import 'package:survey/use_cases/base_use_case.dart';

class LoginCredential {
  @required
  final String email;
  @required
  final String password;

  LoginCredential({this.email, this.password});
}

class LoginUseCase extends UseCase<void, LoginCredential> {
  final OAuthRepository _repository;
  final SharedPreferencesStorage _sharedPreferencesStorage;

  const LoginUseCase(this._repository, this._sharedPreferencesStorage);

  @override
  Future<Result<void>> call(LoginCredential credential) {
    return _repository
        .login((credential.email), credential.password)
        .then((value) => _persistTokenData(value))
        .onError((err, stackTrace) => Failed(
            UseCaseException(NetworkExceptions.fromDioException(err), err)));
  }

  Result<dynamic> _persistTokenData(AuthToken data) {
    _sharedPreferencesStorage.saveTokenType(data.tokenType);
    _sharedPreferencesStorage.saveAccessToken(data.accessToken);
    _sharedPreferencesStorage.saveAccessToken(data.refreshToken);
    return Success(null);
  }
}
