import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:survey/main.dart';
import 'package:survey/managers/user_manager.dart';
import 'package:survey/use_cases/get_login_state_use_case.dart';
import 'package:survey/use_cases/get_surveys_use_case.dart';

import 'fake/fake_get_login_state.dart';
import 'fake/fake_survey_use_case.dart';
import 'fake/fake_user_manager.dart';

main() {
  Get.testMode = true;

  group('Validate logged in scenario in Home screen', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('When entering Home, it displays data', (tester) async {
      Get.put<GetLoginStateUseCase>(FakeGetLoginStateUseCase());
      Get.put<UserManager>(FakeUserManager());
      Get.put<GetSurveysUseCase>(FakeGetSurveysUseCase());

      await tester.pumpWidget(SurveyApp());

      await binding.watchPerformance(() async {},
          reportKey: 'animation_performance_summary');

      // TODO: continue to write test to validate the behavior at home screen, swiping etc...
      await Future.delayed(Duration(seconds: 4));
    });
  });
}
