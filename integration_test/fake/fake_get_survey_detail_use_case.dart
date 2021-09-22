import 'package:mockito/mockito.dart';
import 'package:survey/models/survey.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/get_survey_detail_use_case.dart';

class FakeGetSurveyDetailUseCase extends Fake
    implements GetSurveyDetailUseCase {
  @override
  Future<Result<Survey>> call(String id) async => Success(
        Survey(
          cursor: "id",
          id: "123",
          title: "Title 1",
          description: "Pretty much",
          coverImageUrl:
              "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_",
        ),
      );
}
