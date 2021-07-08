import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

const int DEFAULT_RATE_COUNT = 5;
const String RATING_TYPE_HEART = "heart";
const String RATING_TYPE_SLIDER = "slider";
const String RATING_TYPE_MONEY = "money";
const String RATING_TYPE_STAR = "star";

class SlideRatingBar extends StatelessWidget {
  final RatingType type;

  SlideRatingBar({this.type});

  factory SlideRatingBar.from(String type, int counter) {
    final actualCounter = counter == -1 ? DEFAULT_RATE_COUNT : counter;
    switch (type) {
      case RATING_TYPE_HEART:
        return SlideRatingBar(type: HeartRatingType(counter: actualCounter));
      case RATING_TYPE_SLIDER:
        return SlideRatingBar(type: SliderRatingType(counter: actualCounter));
      case RATING_TYPE_MONEY:
        return SlideRatingBar(type: MoneyRatingType(counter: actualCounter));
      case RATING_TYPE_STAR:
      default:
        return SlideRatingBar(type: StarRatingType(counter: actualCounter));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      unratedColor: type.unratedColor,
      direction: Axis.horizontal,
      itemCount: type.counter,
      itemPadding: EdgeInsets.symmetric(horizontal: 5.0),
      itemBuilder: (context, _) => type.icon,
      onRatingUpdate: (rating) {
        // TODO: update choice to ViewModel
        print(rating);
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
