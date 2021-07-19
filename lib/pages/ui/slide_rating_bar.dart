import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:survey/pages/survey/survey_controller.dart';

const int DEFAULT_RATE_COUNT = 5;
const int DEFAULT_SELECTED_RATE_INDEX = 2;
const String RATING_TYPE_HEART = "heart";
const String RATING_TYPE_SLIDER = "slider";
const String RATING_TYPE_MONEY = "money";
const String RATING_TYPE_STAR = "star";

class SlideRatingBar extends StatefulWidget {
  final RatingType type;
  final List<String> values;

  SlideRatingBar({this.type, this.values});

  factory SlideRatingBar.from(String type, List<String> ids) {
    final actualCounter = ids.length == -1 ? DEFAULT_RATE_COUNT : ids.length;
    switch (type) {
      case RATING_TYPE_HEART:
        return SlideRatingBar(
            type: HeartRatingType(counter: actualCounter), values: ids);
      case RATING_TYPE_SLIDER:
        return SlideRatingBar(
            type: SliderRatingType(counter: actualCounter), values: ids);
      case RATING_TYPE_MONEY:
        return SlideRatingBar(
            type: MoneyRatingType(counter: actualCounter), values: ids);
      case RATING_TYPE_STAR:
      default:
        return SlideRatingBar(
            type: StarRatingType(counter: actualCounter), values: ids);
    }
  }

  @override
  State<SlideRatingBar> createState() => _SlideRatingBarState();
}

class _SlideRatingBarState extends State<SlideRatingBar> {
  final _surveyController = Get.find<SurveyController>();

  @override
  void didChangeDependencies() {
    final defaultSelection = {widget.values[DEFAULT_SELECTED_RATE_INDEX]: ""};
    _surveyController.onAnswerSelected(defaultSelection);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: DEFAULT_SELECTED_RATE_INDEX.toDouble() + 1,
      minRating: 1,
      unratedColor: widget.type.unratedColor,
      direction: Axis.horizontal,
      itemCount: widget.type.counter,
      itemPadding: EdgeInsets.symmetric(horizontal: 5.0),
      itemBuilder: (context, _) => widget.type.icon,
      onRatingUpdate: (rating) {
        _surveyController
            .onAnswerSelected({widget.values[rating.toInt() - 1]: ""});
      },
    );
  }
}

abstract class RatingType {
  final Widget icon;
  final Color unratedColor;
  final int counter;

  RatingType({this.icon, this.unratedColor, this.counter = DEFAULT_RATE_COUNT});
}

class HeartRatingType extends RatingType {
  HeartRatingType({counter})
      : super(
            icon: const Text("❤️"),
            unratedColor: Colors.redAccent.withOpacity(0.4),
            counter: counter);
}

class StarRatingType extends RatingType {
  StarRatingType({counter})
      : super(
            icon: const Text("⭐️"),
            unratedColor: Colors.amber.withOpacity(0.4),
            counter: counter);
}

// TODO: because there is no design, we use this for now
class SliderRatingType extends RatingType {
  SliderRatingType({counter})
      : super(
            icon: const Text("👍🏻"),
            unratedColor: Colors.deepOrange.shade50.withOpacity(0.4),
            counter: counter);
}

// TODO: because there is no design, we use this for now
class MoneyRatingType extends RatingType {
  MoneyRatingType({counter})
      : super(
            icon: const Icon(Icons.attach_money, color: Colors.green),
            unratedColor: Colors.deepOrange.shade50.withOpacity(0.4),
            counter: counter);
}
