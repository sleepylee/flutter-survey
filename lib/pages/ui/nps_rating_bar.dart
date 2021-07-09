import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String RATING_TYPE_NPS = "nps";

class NpsRatingBar extends StatefulWidget {
  final int counter;
  final String minTitle;
  final String maxTitle;

  NpsRatingBar({Key key, this.counter, this.minTitle, this.maxTitle})
      : super(key: key);

  @override
  _NpsRatingBarState createState() => _NpsRatingBarState();
}

class _NpsRatingBarState extends State<NpsRatingBar> {
  int _selectedRate = 4;

  void _onRateSelected(int rate) {
    setState(() {
      _selectedRate = rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.subtitle1;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
                  child: Container(
                    alignment: Alignment.center,
                    width: 34,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: (_selectedRate != null && _selectedRate >= index)
                            ? Colors.white
                            : Colors.white30,
                        width: 1,
                      ),
                      borderRadius: _roundedBorder(index, widget.counter),
                    ),
                    child: Text(
                      (index + 1).toString(),
                      style: style.copyWith(
                        color: (_selectedRate != null && _selectedRate >= index)
                            ? Colors.white
                            : Colors.white30,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.minTitle,
                  style: style.copyWith(
                    color: (_selectedRate != null &&
                            _selectedRate >= widget.counter / 2)
                        ? Colors.white30
                        : Colors.white,
                  ),
                ),
                Text(widget.maxTitle,
                    style: style.copyWith(
                      color: (_selectedRate != null &&
                              _selectedRate >= widget.counter / 2)
                          ? Colors.white
                          : Colors.white30,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BorderRadius _roundedBorder(int index, int total) {
    if (index == 0) {
      return BorderRadius.only(
          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
    }
    if (index == total - 1) {
      return BorderRadius.only(
          topRight: Radius.circular(10), bottomRight: Radius.circular(10));
    }
    return null;
  }
}
