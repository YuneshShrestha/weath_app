import 'package:shared_preferences/shared_preferences.dart';

class SaveAndGetLocation {
  static Future<void> saveLocation(String location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('location', location);
  }

  static Future<String> getLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('location') ?? '';
  }
}

