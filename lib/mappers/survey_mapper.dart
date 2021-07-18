import 'package:survey/api/graphql/response/survey_response.dart';
import 'package:survey/models/survey.dart';

extension SurveyNodeMapper on SurveyNodeResponse {
  Survey toSurvey() {
    return Survey(
        cursor: this.cursor,
        id: this.node.id,
        title: this.node.title,
        description: this.node.description,
        coverImageUrl: this.node.coverImageUrl,
        questions: this.node.surveyQuestionResponses.toSurveyQuestions());
  }
}

extension SurveyResponseMapper on SurveyResponse {
  Survey toSurvey() {
    return Survey(
        id: this.id,
        title: this.title,
        description: this.description,
        coverImageUrl: this.coverImageUrl,
        questions: this.surveyQuestionResponses.toSurveyQuestions());
  }
}

extension QuestionResponseMapper on List<SurveyQuestionResponse> {
  List<SurveyQuestion> toSurveyQuestions() {
    return map((question) => SurveyQuestion(
          id: question.id,
          coverImageUrl: question.coverImageUrl,
          displayType: question.displayType,
          text: question.text,
          isMandatory: question.isMandatory,
          answers: question.surveyAnswerResponses.toSurveyAnswers(),
        )).toList();
  }
}

extension AnswerResponseMapper on List<SurveyAnswerResponse> {
  List<SurveyAnswer> toSurveyAnswers() {
    return map((answer) => SurveyAnswer(
          id: answer.id,
          text: answer.text,
          score: answer.score,
        )).toList();
  }
}
