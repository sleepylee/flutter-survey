import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:survey/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login test', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('When starting, it display login form correctly',
        (tester) async {
      await tester.pumpWidget(SurveyApp());

      await binding.watchPerformance(() async {},
          reportKey: 'animation_performance_summary');

      final emailField = find.widgetWithText(TextFormField, 'Email');
      final passwordField = find.widgetWithText(TextFormField, 'Password');
      final loginButton = find.widgetWithText(ElevatedButton, 'Login');

      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(loginButton, findsOneWidget);
    });

    testWidgets('When login with empty or invalid fields, it shows errors',
        (tester) async {
      await tester.pumpWidget(SurveyApp());
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle(Duration(milliseconds: 300));
      expect(find.text('Please enter your email'), findsOneWidget);

      await tester.enterText(
          find.widgetWithText(TextFormField, 'Email'), 'invalid_email');
      await tester.pumpAndSettle(Duration(milliseconds: 300));
      expect(find.text('Please enter a valid email'), findsOneWidget);
    });

    testWidgets('When login failed, it shows error notification',
        (tester) async {
      await tester.pumpWidget(SurveyApp());
      await tester.pumpAndSettle();

      await tester.enterText(
          find.widgetWithText(TextFormField, 'Email'), 'flutter@nimblehq.co');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password'), 'wrong');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));

      await tester.pumpAndSettle(Duration(seconds: 2));
      await Future.delayed(Duration(seconds: 1));

      final error =
          find.text('Login failed! Please recheck your email or password');
      expect(error, findsOneWidget);
    });

    testWidgets('When login successfully, it shows Home screen',
        (tester) async {
      await tester.pumpWidget(SurveyApp());
      await tester.pumpAndSettle();

      await tester.enterText(
          find.widgetWithText(TextFormField, 'Email'), 'flutter@nimblehq.co');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password'), '12345678');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));

      await tester.pumpAndSettle(Duration(seconds: 2));
      await Future.delayed(Duration(seconds: 2));

      // Found the title in Home screen
      final homeToday = find.text('Today');
      expect(homeToday, findsOneWidget);
    });
  });
}
