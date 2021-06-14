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
    final token = await _sharedPreferencesStorage.getAccessToken();
    final tokenType = await _sharedPreferencesStorage.getTokenType();
    final tokenExpiration =
        await _sharedPreferencesStorage.getTokenExpiration();
    final hasValidTokenStored = token != null &&
        token.isNotEmpty &&
        tokenExpiration > DateTime.now().millisecondsSinceEpoch;

    if (hasValidTokenStored) {
      // TODO: create an Authenticator instead of calling directly like this
      _graphQLClientProvider.setAuthToken("$tokenType $token");
    }
    return Success(hasValidTokenStored);
  }
}
