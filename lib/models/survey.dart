import 'package:get/get_utils/get_utils.dart';

class Survey {
  String cursor;
  String id;
  String title;
  String description;
  String coverImageUrl;
  List<SurveyQuestion> questions;

  Survey({this.cursor,
    this.id,
    this.title,
    this.description,
    this.coverImageUrl,
    this.questions});

  String get hdCoverImageUrl => coverImageUrl + "l";
}

class SurveyQuestion {
  String id;
  String text;
  String coverImageUrl;
  String displayType;
  bool isMandatory;
  List<SurveyAnswer> answers;

  SurveyQuestion(
      {this.id,
      this.text,
      this.coverImageUrl,
      this.displayType,
      this.isMandatory,
      this.answers});

  String get hdCoverImageUrl => coverImageUrl + "l";

  bool get doesNotRequireAnswer => GetUtils.isNullOrBlank(answers);
}

class SurveyAnswer {
  String id;
  String text;
  int score;

  SurveyAnswer({this.id, this.text, this.score});
}
