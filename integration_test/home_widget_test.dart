import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:survey/main.dart';
import 'package:survey/managers/user_manager.dart';
import 'package:survey/use_cases/get_login_state_use_case.dart';
import 'package:survey/use_cases/get_survey_detail_use_case.dart';
import 'package:survey/use_cases/get_surveys_use_case.dart';

import 'fake/fake_get_login_state.dart';
import 'fake/fake_get_survey_detail_use_case.dart';
import 'fake/fake_survey_use_case.dart';
import 'fake/fake_user_manager.dart';

main() {
  Get.testMode = true;

  group('Validate logged in scenario in Home screen', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
    Get.put<GetLoginStateUseCase>(FakeGetLoginStateUseCase());
    Get.put<UserManager>(FakeUserManager());
    Get.put<GetSurveysUseCase>(FakeGetSurveysUseCase());
    Get.put<GetSurveyDetailUseCase>(FakeGetSurveyDetailUseCase());

    testWidgets('When enter Home, it displays Survey carousel', (tester) async {
      await tester.pumpWidget(SurveyApp());
      await tester.pumpAndSettle();

      await binding.watchPerformance(() async {
        final pageView = find.byType(PageView);

        expect(find.text('Today'), findsOneWidget);
        expect(find.text('Title 1'), findsOneWidget);
        expect(find.byType(FloatingActionButton), findsOneWidget);

        // Move to the 2nd survey
        await tester.fling(pageView, Offset(-200, 0), 2000);
        await tester.pumpAndSettle();

        expect(find.text('Title 2'), findsOneWidget);
        expect(find.byType(FloatingActionButton), findsOneWidget);

        // Move back to the 1st survey
        await tester.fling(pageView, Offset(200, 0), 2000);
        await tester.pumpAndSettle();

        expect(find.text('Title 1'), findsOneWidget);
        expect(find.byType(FloatingActionButton), findsOneWidget);
      }, reportKey: 'scrolling_summary');
    });

    testWidgets('When choosing a survey, it displays detail', (tester) async {
      await tester.pumpWidget(SurveyApp());
      await tester.pumpAndSettle();

      final floatingButton = find.byType(FloatingActionButton);
      await tester.tap(floatingButton);
      await tester.pumpAndSettle();

      expect(find.text('Title 1'), findsOneWidget);
      expect(find.text('Start Survey'), findsOneWidget);
    });
  });
}
