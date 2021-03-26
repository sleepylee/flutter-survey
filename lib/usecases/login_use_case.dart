import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:survey/exception/network_exceptions.dart';
import 'package:survey/models/auth_token.dart';
import 'package:survey/repositories/oauth_repository.dart';
import 'package:survey/usecases/base_use_case.dart';

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
    try {
      final value =
      await _repository.login(credential.email, credential.password);
      return Success(value);
    } catch (e) {
      final apiError = ApiError(NetworkExceptions.getDioException(e), e);
      return Future.value(Failed(apiError));
    }
  }
}
