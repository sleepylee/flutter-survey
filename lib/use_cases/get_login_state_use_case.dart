import 'package:survey/api/graphql/graphql_client_provider.dart';
import 'package:survey/preferences/shared_preferences.dart';
import 'package:survey/use_cases/base_use_case.dart';

class GetLoginStateUseCase extends NoParamsUseCase<bool> {
  final SharedPreferencesStorage _sharedPreferencesStorage;
  final GraphQLClientProvider _graphQLClientProvider;

  const GetLoginStateUseCase(
      this._sharedPreferencesStorage, this._graphQLClientProvider);

  @override
  Future<Result<bool>> call() async {
    final refreshToken = await _sharedPreferencesStorage.getRefreshToken();
    final hasValidTokenStored = refreshToken != null && refreshToken.isNotEmpty;

    if (hasValidTokenStored) {
      _graphQLClientProvider.tokenIsReadyToUse();
    }
    return Success(hasValidTokenStored);
  }
}
