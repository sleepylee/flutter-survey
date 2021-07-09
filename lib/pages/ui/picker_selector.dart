import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const double ITEM_SIZE = 50.0;

const String RATING_TYPE_CHOICE = "choice";
const String RATING_TYPE_DROPDOWN = "dropdown";

class PickerSelector extends StatelessWidget {
  final List<String> optionsText;

  PickerSelector({@required this.optionsText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150,
        child: CupertinoPicker(
          itemExtent: ITEM_SIZE,
          selectionOverlay: CustomPaint(painter: TwoHorizontalLinesPainter()),
          children: _getOptionWidgets(context, optionsText),
          onSelectedItemChanged: (index) {
            // TODO: update this behavior to ViewModel
            print("Selected: $index");
          },
        ),
      ),
    );
  }
}

List<Widget> _getOptionWidgets(BuildContext context, List<String> options) {
  final optionStyle = Theme.of(context)
      .textTheme
      .subtitle1
      .copyWith(color: Colors.white, fontSize: 20);

  return options
      .map((item) => Center(child: Text(item, style: optionStyle)))
      .toList();
}

// Drawing only the 2 horizontal line of a rectangle
class TwoHorizontalLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
      Offset(80.0, 0.0),
      Offset(320, 0.0),
      Paint()..color = Colors.white,
    );

    canvas.drawLine(
      Offset(80.0, ITEM_SIZE),
      Offset(320, ITEM_SIZE),
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(TwoHorizontalLinesPainter oldDelegate) {
    return false;
  }
}
