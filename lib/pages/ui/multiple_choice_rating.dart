import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MultipleChoiceRating extends StatefulWidget {
  final List<String> choices;

  const MultipleChoiceRating({Key key, this.choices}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultipleChoiceRatingState();
}

class _MultipleChoiceRatingState extends State<MultipleChoiceRating> {
  final _selectedIndex = <int>[];

  bool _isSelected(int index) {
    return _selectedIndex.contains(index);
  }

  void _onItemSelected(int index) {
    setState(() {
      _isSelected(index)
          ? _selectedIndex.remove(index)
          : _selectedIndex.add(index);
    });
  }

  bool _shouldDrawDivider(int index) {
    return index == widget.choices.length - 1 ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      alignment: Alignment.center,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.choices.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _onItemSelected(index);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 75),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.choices[index],
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 25,
                            fontWeight: _isSelected(index)
                                ? FontWeight.w800
                                : FontWeight.w400,
                            color: _isSelected(index)
                                ? Colors.white
                                : Colors.white54),
                      ),
                      Icon(Icons.check_circle,
                          size: 25,
                          color: _isSelected(index)
                              ? Colors.white
                              : Colors.white12),
                    ],
                  ),
                  _shouldDrawDivider(index)
                      ? const Divider(
                          color: Colors.white,
                          height: 30,
                          thickness: 1,
                        )
                      : SizedBox.shrink()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
