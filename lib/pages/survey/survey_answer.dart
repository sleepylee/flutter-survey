import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:survey/pages/ui/slide_rating_bar.dart';

class SurveyAnswer extends StatelessWidget {
  final String type;
  final int questionIndex;
  final int counter;

  SurveyAnswer({this.type, this.questionIndex = 0, this.counter = -1});

  @override
  Widget build(BuildContext context) {
    return _processAnswerUi(type, counter);
  }
}

Widget _processAnswerUi(String type, int counter) {
  switch (type) {
    case RATING_TYPE_STAR:
    case RATING_TYPE_HEART:
    case RATING_TYPE_SLIDER:
    case RATING_TYPE_MONEY:
      return SlideRatingBar.from(type, counter);
    default:
      return SizedBox.shrink();
  }
}
