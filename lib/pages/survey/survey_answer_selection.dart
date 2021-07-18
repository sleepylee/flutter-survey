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
  final List<String> optionsText;
  final int counter;

  SurveyAnswerSelection({this.type, this.optionsText, this.counter = -1});

  @override
  Widget build(BuildContext context) {
    return _processAnswerUi(type, optionsText, counter);
  }
}

Widget _processAnswerUi(String type, List<String> optionsText, int counter) {
  switch (type) {
    case RATING_TYPE_STAR:
    case RATING_TYPE_HEART:
    case RATING_TYPE_MONEY:
      return SlideRatingBar.from(type, counter);
    case RATING_TYPE_CHOICE:
      return MultipleChoiceRating(choices: optionsText);
    case RATING_TYPE_DROPDOWN:
      return PickerSelector(optionsText: optionsText);
    case RATING_TYPE_SLIDER:
    case RATING_TYPE_NPS:
      return NpsRatingBar(
          counter: counter,
          minTitle: optionsText.first,
          maxTitle: optionsText.last);
    case RATING_TYPE_SMILEY:
      return SmileyRatingBar(counter);
    case RATING_TYPE_TEXT_AREA:
      return TextAreaRating(optionsText.first);
    case RATING_TYPE_TEXT_FIELD:
      return TextFieldRating(hints: optionsText);
    default:
      return SizedBox.shrink();
  }
}
