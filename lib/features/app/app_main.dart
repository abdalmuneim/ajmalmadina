import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/routes/app_pages.dart';
import 'package:butcity/core/resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        locale: const Locale('ar'),
        translationsKeys: AppTranslation.translations,
        fallbackLocale: const Locale('ar'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', ''),
        ],
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme());
  }
}
