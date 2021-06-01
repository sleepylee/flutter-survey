import 'package:survey/preferences/shared_preferences.dart';
import 'package:survey/use_cases/base_use_case.dart';

class GetLoginStateUseCase extends NoParamsUseCase<bool> {
  final SharedPreferencesStorage _sharedPreferencesStorage;

  const GetLoginStateUseCase(this._sharedPreferencesStorage);

  @override
  Future<Result<bool>> call() {
    return _sharedPreferencesStorage.getAccessToken().then((token) {
      return Success(token != null && token.isNotEmpty);
    });
  }
}
