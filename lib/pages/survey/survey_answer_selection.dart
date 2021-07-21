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
  final Function(Map<String, String>) onRatingListener;

  SurveyAnswerSelection(
      {this.type,
      this.optionIdAndText,
      this.counter = -1,
      @required this.onRatingListener});

  @override
  Widget build(BuildContext context) {
    return _processAnswerUi(type, optionIdAndText, counter, onRatingListener);
  }
}

Widget _processAnswerUi(String type, Map<String, String> optionIdAndText,
    int counter, Function(Map<String, String>) onRatingListener) {
  switch (type) {
    case RATING_TYPE_STAR:
    case RATING_TYPE_HEART:
    case RATING_TYPE_MONEY:
      return SlideRatingBar.from(
          type, optionIdAndText.keys.toList(), onRatingListener);
    case RATING_TYPE_CHOICE:
      return MultipleChoiceRating(
          idAndChoice: optionIdAndText, onRatingListener: onRatingListener);
    case RATING_TYPE_DROPDOWN:
      return PickerSelector(
          idAndChoice: optionIdAndText, onRatingListener: onRatingListener);
    case RATING_TYPE_SLIDER:
    case RATING_TYPE_NPS:
      return NpsRatingBar(
          ids: optionIdAndText.keys.toList(),
          minTitle: optionIdAndText.values.toList().first,
          maxTitle: optionIdAndText.values.toList().last,
          onRatingListener: onRatingListener);
    case RATING_TYPE_SMILEY:
      return SmileyRatingBar(optionIdAndText.keys.toList(), onRatingListener);
    case RATING_TYPE_TEXT_AREA:
      return TextAreaRating(optionIdAndText, onRatingListener);
    case RATING_TYPE_TEXT_FIELD:
      return TextFieldRating(
          idAndHints: optionIdAndText, onRatingListener: onRatingListener);
    default:
      return SizedBox.shrink();
  }
}
