import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:survey/exception/network_exceptions.dart';
import 'package:survey/models/auth_token.dart';
import 'package:survey/repositories/oauth_repository.dart';
import 'package:survey/use_cases/base_use_case.dart';

class LoginCredential {
  @required
  final String email;
  @required
  final String password;

  LoginCredential(this.email, this.password);
}

class LoginUseCase extends UseCase<AuthToken, LoginCredential> {
  final OAuthRepository _repository;

  const LoginUseCase(this._repository);

  @override
  Future<Result<AuthToken>> call(LoginCredential credential) async {
    return _repository
        .login((credential.email), credential.password)
        .then<Result<AuthToken>>((value) => Success(value))
        .onError((err, stackTrace) => Failed(
            UseCaseException(NetworkExceptions.fromDioException(err), err)));
  }
}
