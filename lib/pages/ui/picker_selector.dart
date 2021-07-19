import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:survey/pages/survey/survey_controller.dart';

const double ITEM_SIZE = 50.0;

const String RATING_TYPE_CHOICE = "choice";
const String RATING_TYPE_DROPDOWN = "dropdown";

class PickerSelector extends StatelessWidget {
  final Map<String, String> idAndChoice;

  PickerSelector({@required this.idAndChoice});

  @override
  Widget build(BuildContext context) {
    final surveyController = Get.find<SurveyController>();
    surveyController.onAnswerSelected({idAndChoice.keys.first: ""});
    return Center(
      child: SizedBox(
        height: 150,
        child: CupertinoPicker(
          itemExtent: ITEM_SIZE,
          selectionOverlay: CustomPaint(painter: TwoHorizontalLinesPainter()),
          children: _getOptionWidgets(context, idAndChoice.values.toList()),
          onSelectedItemChanged: (index) {
            surveyController
                .onAnswerSelected({idAndChoice.keys.toList()[index]: ""});
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
