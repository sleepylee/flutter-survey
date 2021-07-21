import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'const.dart';

abstract class AppNavigator {
  void popAndNavigateToLogin();

  void popAndNavigateToHome();

  void navigateToSurvey(String id);

  void navigateToSurveyQuestion();

  void navigateBackToHomeOnCompletion();
}

class AppNavigatorImpl implements AppNavigator {
  @override
  void popAndNavigateToLogin() {
    Get.offAndToNamed('/login');
  }

  @override
  void popAndNavigateToHome() {
    Get.offAndToNamed('/home');
  }

  @override
  void navigateToSurvey(String id) {
    Get.toNamed('/survey', arguments: {DATA_SURVEY_ID: id});
  }

  @override
  void navigateToSurveyQuestion() {
    Get.toNamed('/survey-question');
  }

  @override
  void navigateBackToHomeOnCompletion() {
    Get.until(ModalRoute.withName('/home'));
  }
}
