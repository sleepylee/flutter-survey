import 'package:mockito/mockito.dart';
import 'package:survey/models/survey.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/get_surveys_use_case.dart';

class FakeGetSurveysUseCase extends Fake implements GetSurveysUseCase {
  @override
  Future<Result<List<Survey>>> call(GetSurveysInput input) async {
    return Success([
      Survey(
        cursor: "id",
        id: "123",
        title: "Title 1",
        description: "Pretty much",
        coverImageUrl:
            "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_",
      ),
      Survey(
        cursor: "id",
        id: "456",
        title: "Title 2",
        description: "test 2",
        coverImageUrl:
            "https://dhdbhh0jsld0o.cloudfront.net/m/b41c84934fa8e4c34269_",
      ),
    ]);
  }
}
