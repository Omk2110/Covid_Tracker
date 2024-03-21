import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:tgd_covid_tracker/datasorce.dart';
import 'package:tgd_covid_tracker/home_page.dart';
import 'package:tgd_covid_tracker/splash_screen.dart';

void main() {
  runApp(EasyDynamicThemeWidget(
    child: MyApp(),
  ));
}

var lightThemeData = new ThemeData(
  primaryColor: primaryBlack,
  fontFamily: 'Circular',
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
);

var darkThemeData = ThemeData(
  primaryColor: primaryBlack,
  fontFamily: 'Circular',
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.blueGrey[900],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      home: const SplashScreen(),
    );
  }
}
