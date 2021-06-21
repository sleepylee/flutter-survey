import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Indicators extends StatelessWidget {
  const Indicators({this.currentPage});

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: _getIndicators(currentPage),
    );
  }

  List<Widget> _getIndicators(int currentPage) {
    final result = <Widget>[];
    for (int i = 0; i < 3; i++) {
      result.add(Container(
        width: 7.0,
        height: 7.0,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (currentPage % 3 == i) ? Colors.white : Colors.white24,
        ),
      ));
    }
    return result;
  }
}
