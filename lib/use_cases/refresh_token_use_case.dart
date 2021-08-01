import 'dart:async';

import 'package:survey/exception/network_exceptions.dart';
import 'package:survey/models/auth_token.dart';
import 'package:survey/repositories/oauth_repository.dart';
import 'package:survey/use_cases/base_use_case.dart';

class RefreshTokenUseCase extends UseCase<AuthToken, String> {
  final OAuthRepository _repository;

  const RefreshTokenUseCase(this._repository);

  @override
  Future<Result<AuthToken>> call(String refreshToken) {
    return _repository
        .refreshToken(refreshToken)
        .then<Result<AuthToken>>((value) => Success(value))
        .onError((err, stackTrace) => Failed(
            UseCaseException(NetworkExceptions.fromDioException(err), err)));
  }
}
