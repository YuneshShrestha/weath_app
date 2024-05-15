import 'package:shared_preferences/shared_preferences.dart';

class CheckIfSkip {
  static Future<void> skip() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('skip', true);
  }

  static Future<bool> isSkip() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('skip') ?? false;
  }
}
