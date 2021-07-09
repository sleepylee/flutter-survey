import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:survey/pages/ui/nps_rating_bar.dart';
import 'package:survey/pages/ui/picker_selector.dart';
import 'package:survey/pages/ui/slide_rating_bar.dart';

class SurveyAnswer extends StatelessWidget {
  final String type;
  final List<String> optionsText;
  final int questionIndex;
  final int counter;

  SurveyAnswer(
      {this.type, this.optionsText, this.questionIndex = 0, this.counter = -1});

  @override
  Widget build(BuildContext context) {
    return _processAnswerUi(type, optionsText, counter);
  }
}

Widget _processAnswerUi(String type, List<String> optionsText, int counter) {
  switch (type) {
    case RATING_TYPE_STAR:
    case RATING_TYPE_HEART:
    case RATING_TYPE_SLIDER:
    case RATING_TYPE_MONEY:
      return SlideRatingBar.from(type, counter);
    case RATING_TYPE_CHOICE:
    case RATING_TYPE_DROPDOWN:
      return PickerSelector(optionsText: optionsText);
    case RATING_TYPE_NPS:
      return NpsRatingBar(
          counter: counter,
          minTitle: optionsText.first,
          maxTitle: optionsText.last);
    default:
      return SizedBox.shrink();
  }
}
