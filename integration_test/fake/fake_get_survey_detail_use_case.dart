import 'package:mockito/mockito.dart';
import 'package:survey/models/survey.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/get_survey_detail_use_case.dart';

class FakeGetSurveyDetailUseCase extends Fake
    implements GetSurveyDetailUseCase {
  @override
  Future<Result<Survey>> call(String id) async {
    return Success(
      Survey(
        cursor: "id",
        id: "123",
        title: "Title 1",
        description: "Pretty much",
        coverImageUrl:
            "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_",
        questions: [
          SurveyQuestion(
            id: "question 1",
            text: "Question 1 - Intro",
            coverImageUrl:
                "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_",
            displayType: "intro",
            isMandatory: false,
            answers: [],
          ),
          SurveyQuestion(
            id: "question 2",
            text: "Question 2 - Star",
            coverImageUrl:
                "https://dhdbhh0jsld0o.cloudfront.net/m/b41c84934fa8e4c34269_",
            displayType: "star",
            isMandatory: false,
            answers: [
              SurveyAnswer(id: "4cbc3e5", text: "1", score: 0),
              SurveyAnswer(id: "6e6221", text: "2", score: 25),
              SurveyAnswer(id: "037574", text: "3", score: 50),
              SurveyAnswer(id: "f09f1a", text: "4", score: 75),
              SurveyAnswer(id: "bafadb", text: "5", score: 100)
            ],
          ),
          SurveyQuestion(
            id: "question 3",
            text: "Question 3 - Heart",
            coverImageUrl:
                "https://dhdbhh0jsld0o.cloudfront.net/m/cf6002aa29fb33d9d21b_",
            displayType: "heart",
            isMandatory: false,
            answers: [
              SurveyAnswer(id: "c670", text: "1", score: 0),
              SurveyAnswer(id: "1234", text: "2", score: 25),
              SurveyAnswer(id: "4233", text: "3", score: 50),
              SurveyAnswer(id: "a107", text: "4", score: 75),
              SurveyAnswer(id: "46c6", text: "5", score: 100)
            ],
          ),
          SurveyQuestion(
            id: "question 4",
            text: "Question 4 - Emoji",
            coverImageUrl:
                "https://dhdbhh0jsld0o.cloudfront.net/m/b41c84934fa8e4c34269_",
            displayType: "smiley",
            isMandatory: false,
            answers: [
              SurveyAnswer(id: "c670", text: "1", score: 0),
              SurveyAnswer(id: "1234", text: "2", score: 25),
              SurveyAnswer(id: "4233", text: "3", score: 50),
              SurveyAnswer(id: "a107", text: "4", score: 75),
              SurveyAnswer(id: "46c6", text: "5", score: 100)
            ],
          ),
          SurveyQuestion(
            id: "question 5",
            text: "Question 5 - Choice",
            coverImageUrl:
                "https://dhdbhh0jsld0o.cloudfront.net/m/b41c84934fa8e4c34269_",
            displayType: "choice",
            isMandatory: false,
            answers: [
              SurveyAnswer(id: "002d", text: "CheapAdvisor", score: null),
              SurveyAnswer(id: "bdf9", text: "Your mom", score: null),
              SurveyAnswer(id: "4ac9", text: "Sugar baby", score: null),
              SurveyAnswer(id: "20c9", text: "Toilet", score: null),
              SurveyAnswer(id: "2051", text: "Other", score: null)
            ],
          ),
          SurveyQuestion(
            id: "question 6",
            text: "Question 6 - NPS",
            coverImageUrl:
                "https://dhdbhh0jsld0o.cloudfront.net/m/b41c84934fa8e4c34269_",
            displayType: "nps",
            isMandatory: false,
            answers: [
              SurveyAnswer(id: "3ffc", text: "0", score: 0),
              SurveyAnswer(id: "d24c", text: "1", score: 1),
              SurveyAnswer(id: "0c5c", text: "2", score: 2),
              SurveyAnswer(id: "6b5c", text: "3", score: 3),
              SurveyAnswer(id: "669c", text: "4", score: 4),
              SurveyAnswer(id: "e90c", text: "5", score: 5),
              SurveyAnswer(id: "ecec", text: "6", score: 6),
              SurveyAnswer(id: "1adc", text: "7", score: 7),
              SurveyAnswer(id: "54dc", text: "8", score: 8),
              SurveyAnswer(id: "e68c", text: "9", score: 9),
              SurveyAnswer(id: "3a0c", text: "10", score: 10)
            ],
          ),
          SurveyQuestion(
            id: "question 7",
            text: "Question 7 - Text area",
            coverImageUrl:
                "https://dhdbhh0jsld0o.cloudfront.net/m/b41c84934fa8e4c34269_",
            displayType: "textarea",
            isMandatory: false,
            answers: [SurveyAnswer(id: "2a49", text: "null", score: null)],
          ),
          SurveyQuestion(
            id: "question 8",
            text: "Question 8 - Text field",
            coverImageUrl:
                "https://dhdbhh0jsld0o.cloudfront.net/m/b41c84934fa8e4c34269_",
            displayType: "textfield",
            isMandatory: false,
            answers: [
              SurveyAnswer(id: "491d", text: "Name", score: null),
              SurveyAnswer(id: "6db6", text: "Mobile", score: null),
              SurveyAnswer(id: "575d", text: "Email", score: null)
            ],
          ),
          SurveyQuestion(
            id: "question 9",
            text: "Question 9 - Outro",
            coverImageUrl:
                "https://dhdbhh0jsld0o.cloudfront.net/m/cf6002aa29fb33d9d21b_",
            displayType: "outro",
            isMandatory: false,
            answers: [],
          ),
        ],
      ),
    );
  }
}
