import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/navigator/const.dart';

class SurveyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: work on the UI:
    return Scaffold(
        body: Center(
      child: Text(
          "Will fetch the survey detail id: ${Get.arguments[DATA_SURVEY_ID]}"),
    ));
  }
}
