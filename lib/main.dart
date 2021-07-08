import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:survey/api/graphql/graphql_client_provider.dart';
import 'package:survey/api/http/api_client_provider.dart';
import 'package:survey/navigator/navigator.dart';
import 'package:survey/pages/home/home_binding.dart';
import 'package:survey/pages/home/home_page.dart';
import 'package:survey/pages/login/login_binding.dart';
import 'package:survey/pages/login/login_page.dart';
import 'package:survey/pages/splash/splash_binding.dart';
import 'package:survey/pages/splash/splash_page.dart';
import 'package:survey/pages/survey/survey_binding.dart';
import 'package:survey/pages/survey/survey_page.dart';
import 'package:survey/pages/survey/survey_question_page.dart';
import 'package:survey/preferences/shared_preferences.dart';
import 'package:survey/themes.dart';

import 'api/http/api_client.dart';
import 'flavors.dart';

void main() {
  runApp(SurveyApp());
}

class SurveyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<SurveyApp> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      child: GetMaterialApp(
        title: F.title,
        theme: appTheme,
        getPages: [
          GetPage(
              name: "/", page: () => SplashPage(), binding: SplashBinding()),
          GetPage(
              name: "/login", page: () => LoginPage(), binding: LoginBinding()),
          GetPage(
              name: "/home", page: () => HomePage(), binding: HomeBinding()),
          GetPage(
              name: "/survey",
              page: () => SurveyPage(),
              binding: SurveyBinding()),
          GetPage(
              name: "/survey-question",
              page: () => SurveyQuestionPage(),
              binding: SurveyBinding()),
        ],
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
      ),
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void initState() {
    _initAppDependencies();
    super.initState();
  }

  void _initAppDependencies() {
    Get.put<SharedPreferencesStorage>(LocalSharedPreferencesStorage());
    Get.put<ApiClient>(ApiClientProvider().httpClient());
    Get.put<GraphQLClientProvider>(GraphQLClientProvider());
    Get.put<AppNavigator>(AppNavigatorImpl());
  }
}
