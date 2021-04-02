import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:survey/api/api_client_provider.dart';
import 'package:survey/navigator/navigator.dart';
import 'package:survey/pages/home/home_page.dart';
import 'package:survey/pages/login/login_binding.dart';
import 'package:survey/pages/login/login_page.dart';
import 'package:survey/pages/splash/splash_page.dart';
import 'package:survey/preferences/shared_preferences.dart';
import 'package:survey/themes.dart';

import 'api/api_client.dart';
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
    return GetMaterialApp(
      title: F.title,
      theme: appTheme,
      home: SplashPage(),
      getPages: [
        GetPage(
            name: "/login", page: () => LoginPage(), binding: LoginBinding()),
        GetPage(name: "/home", page: () => HomePage()),
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
    Get.put<AppNavigator>(AppNavigatorImpl());
  }
}
