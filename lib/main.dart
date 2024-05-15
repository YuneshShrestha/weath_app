import 'package:flutter/material.dart';
import 'package:flutter_weather_app/controller/check_if_skip.dart';
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
    return FutureBuilder<bool>(
      future: CheckIfSkip.isSkip(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return GetMaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.yellow,
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.yellow,
              ),
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: (snapshot.data == true)
                ? HomeScreen.routeName
                : HelpScreen.routeName,
            routes: {
              HelpScreen.routeName: (context) => const HelpScreen(),
              HomeScreen.routeName: (context) => const HomeScreen(),
            },
          );
        }
      },
    );
  }
}
