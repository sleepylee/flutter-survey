import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:survey/main.dart';
import 'package:survey/managers/user_manager.dart';
import 'package:survey/pages/ui/multiple_choice_rating.dart';
import 'package:survey/pages/ui/nps_rating_bar.dart';
import 'package:survey/pages/ui/slide_rating_bar.dart';
import 'package:survey/pages/ui/smiley_rating_bar.dart';
import 'package:survey/pages/ui/text_area_rating.dart';
import 'package:survey/pages/ui/text_field_rating.dart';
import 'package:survey/use_cases/create_response_use_case.dart';
import 'package:survey/use_cases/get_login_state_use_case.dart';
import 'package:survey/use_cases/get_survey_detail_use_case.dart';
import 'package:survey/use_cases/get_surveys_use_case.dart';

import 'fake/fake_create_survey_response_use_case.dart';
import 'fake/fake_get_login_state.dart';
import 'fake/fake_get_survey_detail_use_case.dart';
import 'fake/fake_survey_use_case.dart';
import 'fake/fake_user_manager.dart';

main() {
  Get.testMode = true;

  group('Validate take survey flow', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
    Get.put<GetLoginStateUseCase>(FakeGetLoginStateUseCase());
    Get.put<UserManager>(FakeUserManager());
    Get.put<GetSurveysUseCase>(FakeGetSurveysUseCase());
    Get.put<GetSurveyDetailUseCase>(FakeGetSurveyDetailUseCase());
    Get.put<CreateSurveyResponseUseCase>(FakeCreateSurveyResponseUseCase());

    testWidgets('When take surveys, it displays correct Question type',
        (tester) async {
      await tester.pumpWidget(SurveyApp());
      await tester.pumpAndSettle();

      final floatingButton = find.byType(FloatingActionButton);
      await tester.tap(floatingButton);
      await tester.pumpAndSettle();

      final startSurveyButton = find.text('Start Survey');
      expect(startSurveyButton, findsOneWidget);
      await tester.tap(startSurveyButton);
      await tester.pumpAndSettle();

      // Intro
      final nextQuestionButton = find.byType(FloatingActionButton);
      await tester.tap(nextQuestionButton);
      await tester.pumpAndSettle();

      final ratingBar = find.byType(SlideRatingBar);

      // Star
      expect(ratingBar, findsOneWidget);
      await tester.tap(find.text("⭐️").first);
      await tester.pumpAndSettle();

      await tester.tap(nextQuestionButton);
      await tester.pumpAndSettle();

      // Heart
      expect(ratingBar, findsOneWidget);
      await tester.tap(find.text("❤️").last);
      await tester.pumpAndSettle();

      await tester.tap(nextQuestionButton);
      await tester.pumpAndSettle();

      // Emoji
      final smileyRatingBar = find.byType(SmileyRatingBar);
      expect(smileyRatingBar, findsOneWidget);
      await tester.tap(find.text("😡"));
      await tester.pumpAndSettle();

      await tester.tap(nextQuestionButton);
      await tester.pumpAndSettle();

      // Choice
      final choiceRating = find.byType(MultipleChoiceRating);
      expect(choiceRating, findsOneWidget);
      await tester.tap(find.text("Your mom"));
      await tester.tap(find.text("CheapAdvisor"));
      await tester.pumpAndSettle();

      await tester.tap(nextQuestionButton);
      await tester.pumpAndSettle();

      // NPS
      final npsRatingBar = find.byType(NpsRatingBar);
      expect(npsRatingBar, findsOneWidget);
      await tester.tap(find.text("8"));
      await tester.pumpAndSettle();

      await tester.tap(nextQuestionButton);
      await tester.pumpAndSettle();

      // Text area
      final textareaRating = find.byType(TextAreaRating);
      expect(textareaRating, findsOneWidget);
      await tester.enterText(
          textareaRating, "If you see this, you own me 10\$");
      await tester.pumpAndSettle();

      await tester.tap(nextQuestionButton);
      await tester.pumpAndSettle();

      // Text field
      final textFieldRating = find.byType(TextFieldRating);
      expect(textFieldRating, findsOneWidget);
      await tester.enterText(
          find.widgetWithText(TextField, 'Name'), "John Cena");
      await tester.enterText(
          find.widgetWithText(TextField, 'Mobile'), "000000000");
      await tester.enterText(
          find.widgetWithText(TextField, 'Email'), "youcantseeme@gmail.com");
      await tester.pumpAndSettle();

      await tester.tap(nextQuestionButton);
      await tester.pumpAndSettle();

      // Outro
      final submitButton = find.text('Submit');
      expect(submitButton, findsOneWidget);
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      // Animation and finish
      final thankYouText = find.text('Thank you for taking the survey');
      expect(thankYouText, findsOneWidget);
    });
  });
}
