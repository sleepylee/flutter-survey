import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String RATING_TYPE_SMILEY = "smiley";
const _smileys = {
  "worst": "😡",
  "worse": "😕",
  "neutral": "😐",
  "better": "🙂",
  "best": "😄",
};

class SmileyRatingBar extends StatefulWidget {
  final int counter;

  SmileyRatingBar(this.counter);

  @override
  _SmileyRatingBarState createState() => _SmileyRatingBarState();
}

class _SmileyRatingBarState extends State<SmileyRatingBar> {
  int _selectedRate = 2;

  void _onRateSelected(int rate) {
    setState(() {
      _selectedRate = rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: 56,
        width: double.infinity,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.counter,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    _onRateSelected(index);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: _getSmiley(index, _selectedRate),
                  ));
            }),
      ),
    );
  }

  Widget _getSmiley(int index, int selectedIndex) {
    final enabledStyle =
        Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 30);
    final disabledStyle =
        enabledStyle.copyWith(color: Colors.white.withOpacity(0.4));
    final correctStyle = index == selectedIndex ? enabledStyle : disabledStyle;
    switch (index) {
      case 0:
        return Text(_smileys["worst"], style: correctStyle);
      case 1:
        return Text(_smileys["worse"], style: correctStyle);
      case 2:
        return Text(_smileys["neutral"], style: correctStyle);
      case 3:
        return Text(_smileys["better"], style: correctStyle);
      case 4:
        return Text(_smileys["best"], style: correctStyle);
      default:
        return Text(_smileys["neutral"], style: correctStyle);
    }
  }
}
