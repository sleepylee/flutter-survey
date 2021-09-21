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
        title: "How shame are you",
        description: "Pretty much",
        coverImageUrl:
            "https://images.firstpost.com/wp-content/uploads/2020/04/meme02-3805.jpg?impolicy=website&width=800&height=800",
      ),
      Survey(
        cursor: "id",
        id: "123",
        title: "test 2",
        description: "test 2",
        coverImageUrl:
            "https://images.hindustantimes.com/rf/image_size_630x354/HT/p2/2020/05/01/Pictures/_6e744fb4-8bc4-11ea-8bae-d48e751bd032.jpg",
      ),
    ]);
  }
}
