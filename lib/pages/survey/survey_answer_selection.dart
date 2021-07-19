import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:survey/pages/ui/multiple_choice_rating.dart';
import 'package:survey/pages/ui/nps_rating_bar.dart';
import 'package:survey/pages/ui/picker_selector.dart';
import 'package:survey/pages/ui/slide_rating_bar.dart';
import 'package:survey/pages/ui/smiley_rating_bar.dart';
import 'package:survey/pages/ui/text_area_rating.dart';
import 'package:survey/pages/ui/text_field_rating.dart';

class SurveyAnswerSelection extends StatelessWidget {
  final String type;
  final Map<String, String> optionIdAndText;
  final int counter;

  SurveyAnswerSelection({this.type, this.optionIdAndText, this.counter = -1});

  @override
  Widget build(BuildContext context) {
    return _processAnswerUi(type, optionIdAndText, counter);
  }
}

Widget _processAnswerUi(
    String type, Map<String, String> optionIdAndText, int counter) {
  switch (type) {
    case RATING_TYPE_STAR:
    case RATING_TYPE_HEART:
    case RATING_TYPE_MONEY:
      return SlideRatingBar.from(type, optionIdAndText.keys.toList());
    case RATING_TYPE_CHOICE:
      return MultipleChoiceRating(idAndChoice: optionIdAndText);
    case RATING_TYPE_DROPDOWN:
      return PickerSelector(idAndChoice: optionIdAndText);
    case RATING_TYPE_SLIDER:
    case RATING_TYPE_NPS:
      return NpsRatingBar(
          ids: optionIdAndText.keys.toList(),
          minTitle: optionIdAndText.values.toList().first,
          maxTitle: optionIdAndText.values.toList().last);
    case RATING_TYPE_SMILEY:
      return SmileyRatingBar(optionIdAndText.keys.toList());
    case RATING_TYPE_TEXT_AREA:
      return TextAreaRating(optionIdAndText.values.toList().first);
    case RATING_TYPE_TEXT_FIELD:
      return TextFieldRating(hints: optionIdAndText.values.toList());
    default:
      return SizedBox.shrink();
  }
}
