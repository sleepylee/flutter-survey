import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:survey/pages/login_page.dart';
import 'package:survey/themes.dart';

import 'flavors.dart';

void main() {
  runApp(SurveyApp());
}

class SurveyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: F.title,
      theme: appTheme,
      home: LoginPage(),
      // TODO: change to Splash later
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('vi', ''),
        const Locale('th', ''),
      ],
    );
  }
}
