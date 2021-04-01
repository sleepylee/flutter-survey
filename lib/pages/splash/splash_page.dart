import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:survey/navigator/navigator.dart';

class SplashPage extends StatelessWidget {
  final AppNavigator _appNavigator = Get.find();

  @override
  Widget build(BuildContext context) {
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.idle) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => _appNavigator.popAndNavigateToLogin());
    }
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Hello - Test splash - will rework later',
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
