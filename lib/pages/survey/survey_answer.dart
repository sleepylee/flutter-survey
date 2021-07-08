import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

const int DEFAULT_RATE_COUNT = 5;

class SurveyAnswer extends StatelessWidget {
  final AnswerType type;
  final int questionIndex;
  final int counter;

  SurveyAnswer(
      {this.type, this.questionIndex = 0, this.counter = DEFAULT_RATE_COUNT});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AnswerType.star:
        return _starRatingBar(counter);
      case AnswerType.heart:
        return _heartRatingBar(counter);
      case AnswerType.like:
        return _likeRatingBar(counter);
      case AnswerType.smiley:
      case AnswerType.choice:
      case AnswerType.nps:
      case AnswerType.textArea:
      case AnswerType.textField:
      case AnswerType.noInput:
      default:
        return SizedBox.shrink();
    }
  }
}

enum AnswerType {
  star,
  heart,
  like,
  smiley,
  choice,
  nps,
  textArea,
  textField,
  noInput,
}

Widget _starRatingBar(int counter) {
  return RatingBar.builder(
    initialRating: 3,
    minRating: 1,
    unratedColor: Colors.amber.withOpacity(0.4),
    direction: Axis.horizontal,
    itemCount: counter,
    itemPadding: EdgeInsets.symmetric(horizontal: 5.0),
    itemBuilder: (context, _) => Text("⭐️"),
    onRatingUpdate: (rating) {
      // TODO: update choice to ViewModel
      print(rating);
    },
  );
}

Widget _heartRatingBar(int counter) {
  return RatingBar.builder(
    initialRating: 3,
    minRating: 1,
    unratedColor: Colors.redAccent.withOpacity(0.4),
    direction: Axis.horizontal,
    itemCount: counter,
    itemPadding: EdgeInsets.symmetric(horizontal: 5.0),
    itemBuilder: (context, _) => Text("❤️"),
    onRatingUpdate: (rating) {
      // TODO: update choice to ViewModel
      print(rating);
    },
  );
}

Widget _likeRatingBar(int counter) {
  return RatingBar.builder(
    initialRating: 3,
    minRating: 1,
    unratedColor: Colors.deepOrange.shade50.withOpacity(0.4),
    direction: Axis.horizontal,
    itemCount: counter,
    itemPadding: EdgeInsets.symmetric(horizontal: 5.0),
    itemBuilder: (context, _) => Text("👍🏻"),
    onRatingUpdate: (rating) {
      // TODO: update choice to ViewModel
      print(rating);
    },
  );
}
