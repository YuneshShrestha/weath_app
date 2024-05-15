import 'package:flutter/material.dart';
import 'package:flutter_weather_app/view/pages/help_screen.dart';
import 'package:flutter_weather_app/view/pages/home_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.yellow,
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: HelpScreen.routeName,
        routes: {
          HelpScreen.routeName: (context) => const HelpScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
        });
  }
}
