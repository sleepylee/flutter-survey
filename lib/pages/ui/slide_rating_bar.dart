import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

const int DEFAULT_RATE_COUNT = 5;
const int DEFAULT_SELECTED_RATE_INDEX = 2;
const String RATING_TYPE_HEART = "heart";
const String RATING_TYPE_SLIDER = "slider";
const String RATING_TYPE_MONEY = "money";
const String RATING_TYPE_STAR = "star";

class SlideRatingBar extends StatefulWidget {
  final RatingType type;
  final List<String> ids;
  final void Function(Map<String, String>) onRatingListener;

  SlideRatingBar(
      {@required this.type,
      @required this.ids,
      @required this.onRatingListener});

  factory SlideRatingBar.from(String type, List<String> ids,
      Function(Map<String, String>) onRatingListener) {
    final actualCounter = ids.length == -1 ? DEFAULT_RATE_COUNT : ids.length;
    switch (type) {
      case RATING_TYPE_HEART:
        return SlideRatingBar(
          type: HeartRatingType(counter: actualCounter),
          ids: ids,
          onRatingListener: onRatingListener,
        );
      case RATING_TYPE_SLIDER:
        return SlideRatingBar(
          type: SliderRatingType(counter: actualCounter),
          ids: ids,
          onRatingListener: onRatingListener,
        );
      case RATING_TYPE_MONEY:
        return SlideRatingBar(
          type: MoneyRatingType(counter: actualCounter),
          ids: ids,
          onRatingListener: onRatingListener,
        );
      case RATING_TYPE_STAR:
      default:
        return SlideRatingBar(
          type: StarRatingType(counter: actualCounter),
          ids: ids,
          onRatingListener: onRatingListener,
        );
    }
  }

  @override
  State<SlideRatingBar> createState() => _SlideRatingBarState();
}

class _SlideRatingBarState extends State<SlideRatingBar> {
  @override
  void initState() {
    widget.onRatingListener.call({widget.ids[DEFAULT_SELECTED_RATE_INDEX]: ""});
    super.initState();
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
        widget.onRatingListener.call({widget.ids[rating.toInt() - 1]: ""});
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
