import 'package:survey/exception/network_exceptions.dart';
import 'package:survey/models/user.dart';
import 'package:survey/repositories/user_repository.dart';
import 'package:survey/use_cases/base_use_case.dart';

class GetProfileUseCase extends NoParamsUseCase<User> {
  final UserRepository _userRepository;

  const GetProfileUseCase(this._userRepository);

  @override
  Future<Result<User>> call() async {
    try {
      final result = await _userRepository.getProfile();
      return Success(result);
    } on NetworkExceptions catch (exception) {
      return Failed(UseCaseException(exception, null));
    }
  }
}
