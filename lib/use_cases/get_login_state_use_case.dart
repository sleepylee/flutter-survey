import 'package:survey/repositories/user_repository.dart';
import 'package:survey/use_cases/base_use_case.dart';

class GetLoginStateUseCase extends NoParamsUseCase<bool> {
  final UserRepository _userRepository;

  const GetLoginStateUseCase(this._userRepository);

  @override
  Future<Result<bool>> call() async {
    final isLoggedIn = await _userRepository.isLoggedIn();
    return Success(isLoggedIn);
  }
}
