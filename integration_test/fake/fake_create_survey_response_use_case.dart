import 'package:mockito/mockito.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/create_response_use_case.dart';

class FakeCreateSurveyResponseUseCase extends Fake
    implements CreateSurveyResponseUseCase {
  @override
  Future<Result<void>> call(ResponseInput params) async => Success(null);
}
