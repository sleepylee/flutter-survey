import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:survey/api/graphql/graphql_client_provider.dart';
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
  final GraphQLClientProvider _graphQLClientProvider;

  const LoginUseCase(this._repository, this._sharedPreferencesStorage,
      this._graphQLClientProvider);

  @override
  Future<Result<void>> call(LoginCredential credential) async {
    try {
      final result =
          await _repository.login((credential.email), credential.password);
      return _persistTokenData(result);
    } catch (exception) {
      return Failed(UseCaseException(exception, null));
    }
  }

  Result<dynamic> _persistTokenData(AuthToken data) {
    _sharedPreferencesStorage.saveTokenType(data.tokenType);
    _sharedPreferencesStorage.saveAccessToken(data.accessToken);
    _sharedPreferencesStorage.saveRefreshToken(data.refreshToken);

    _sharedPreferencesStorage.saveTokenExpiration(
        data.expiresIn * 1000 + DateTime.now().millisecondsSinceEpoch);

    _graphQLClientProvider.tokenIsReadyToUse();
    return Success(null);
  }
}
