import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String RATING_TYPE_NPS = "nps";
const int DEFAULT_SELECTED_RATE = 4;

class NpsRatingBar extends StatefulWidget {
  final List<String> ids;
  final String minTitle;
  final String maxTitle;
  final Function(Map<String, String>) onRatingListener;

  NpsRatingBar(
      {Key key,
      this.ids,
      this.minTitle,
      this.maxTitle,
      @required this.onRatingListener})
      : super(key: key);

  @override
  _NpsRatingBarState createState() => _NpsRatingBarState();
}

class _NpsRatingBarState extends State<NpsRatingBar> {
  int _selectedRate = DEFAULT_SELECTED_RATE;

  void _onRateSelected(int rate) {
    setState(() {
      _selectedRate = rate;
      widget.onRatingListener.call({widget.ids[rate]: ""});
    });
  }

  @override
  void didChangeDependencies() {
    widget.onRatingListener.call({widget.ids[DEFAULT_SELECTED_RATE]: ""});
    super.didChangeDependencies();
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
              itemCount: widget.ids.length,
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
                      borderRadius: _roundedBorder(index, widget.ids.length),
                    ),
                    child: Text(
                      index.toString(),
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
                            _selectedRate >= widget.ids.length / 2)
                        ? Colors.white30
                        : Colors.white,
                  ),
                ),
                Text(widget.maxTitle,
                    style: style.copyWith(
                      color: (_selectedRate != null &&
                              _selectedRate >= widget.ids.length / 2)
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
