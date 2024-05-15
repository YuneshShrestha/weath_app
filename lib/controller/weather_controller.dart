import 'dart:convert';

import 'package:flutter_weather_app/constants/url.dart';
import 'package:flutter_weather_app/model/weather_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  final RxString temperature = '0°C'.obs;
  final RxString weather = 'Sunny'.obs;
  final RxString weatherIcon =
      '//cdn.weatherapi.com/weather/64x64/day/116.png'.obs;
  final RxBool isLoading = false.obs;

  Future<void> getWeather(String param) async {
    isLoading.value = true;
    try {
      var response = await http.get(
        Uri.parse(
          '$kBaseUrl?key=$kApiKey&q=$param',
        ),
      );
      print(response.body);
      if (response.statusCode == 200) {
        WeatherModel weatherModel =
            WeatherModel.fromJson(jsonDecode(response.body));
        temperature.value = '${weatherModel.current!.tempC}°C';
        weather.value = weatherModel.current?.condition!.text ??
            'Failed to load weather data';
        weatherIcon.value = weatherModel.current?.condition!.icon ??
            '//cdn.weatherapi.com/weather/64x64/day/116.png';
      } else {
        weather.value = 'Failed to load weather data';
        Get.snackbar('Error', 'Failed to load weather data');
      }
    } catch (e) {
      weather.value = 'Failed to load weather data';
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
