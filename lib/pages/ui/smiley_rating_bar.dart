import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String RATING_TYPE_SMILEY = "smiley";
const int DEFAULT_SELECTED_RATE = 2;
const _smileys = {
  "worst": "😡",
  "worse": "😕",
  "neutral": "😐",
  "better": "🙂",
  "best": "😄",
};

class SmileyRatingBar extends StatefulWidget {
  final List<String> ids;
  final Function(Map<String, String>) onRatingListener;

  SmileyRatingBar(this.ids, this.onRatingListener);

  @override
  _SmileyRatingBarState createState() => _SmileyRatingBarState();
}

class _SmileyRatingBarState extends State<SmileyRatingBar> {
  int _selectedRate = DEFAULT_SELECTED_RATE;

  void _onRateSelected(int rate) {
    widget.onRatingListener.call({widget.ids[rate]: ""});
    setState(() {
      _selectedRate = rate;
    });
  }

  @override
  void initState() {
    widget.onRatingListener.call({widget.ids[DEFAULT_SELECTED_RATE]: ""});
    super.initState();
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
            itemCount: widget.ids.length,
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
