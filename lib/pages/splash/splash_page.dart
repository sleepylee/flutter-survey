import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:survey/navigator/navigator.dart';
import 'package:survey/pages/splash/splash_controller.dart';

class SplashPage extends StatelessWidget {
  final AppNavigator _appNavigator = Get.find();
  final splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.idle) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => _loginStatusCheck());
    }
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Hello - Splash screen', textAlign: TextAlign.center),
        ],
      ),
    );
  }

  void _loginStatusCheck() {
    Get.find<SplashController>().isLoggedInUser.stream.listen((isLoggedIn) {
      if (isLoggedIn.isNotEmpty) {
        if (isLoggedIn.value) {
          _appNavigator.popAndNavigateToHome();
        } else {
          _appNavigator.popAndNavigateToLogin();
        }
      }
    });
  }
}
