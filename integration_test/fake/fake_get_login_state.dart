import 'package:mockito/mockito.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/get_login_state_use_case.dart';

class FakeGetLoginStateUseCase extends Fake implements GetLoginStateUseCase {
  @override
  Future<Result<bool>> call() async => Success(true);
}
