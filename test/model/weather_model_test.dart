import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/model/weather_model.dart';

void main() {
  const tModel = WeatherModel.empty();
  group('weather model test', () {
    test(
      'should be the subclass of [User] entity',
      () {
        // arrange
        // act

        // assert
        expect(tModel, isA<WeatherModel>());
      },
    );
    test('should return paresed model which is same as tModel', () {
      final Map<String, dynamic> json = {
        "location": {
          "name": "Dharan",
          "region": "",
          "country": "Nepal",
          "lat": 26.82,
          "lon": 87.28,
          "tz_id": "Asia/Kathmandu",
          "localtime_epoch": 1715736573,
          "localtime": "2024-05-15 7:14"
        },
        "current": {
          "last_updated_epoch": 1715735700,
          "last_updated": "2024-05-15 07:00",
          "temp_c": 0,
          "temp_f": 32,
          "is_day": 1,
          "condition": {
            "text": "Sunny",
            "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png",
            "code": 0
          },
          "wind_mph": 2.2,
          "wind_kph": 3.6,
          "wind_degree": 56,
          "wind_dir": "ENE",
          "pressure_mb": 1011.0,
          "pressure_in": 29.86,
          "precip_mm": 0.0,
          "precip_in": 0.0,
          "humidity": 47,
          "cloud": 21,
          "feelslike_c": 31.7,
          "feelslike_f": 89.0,
          "vis_km": 10.0,
          "vis_miles": 6.0,
          "uv": 8.0,
          "gust_mph": 2.3,
          "gust_kph": 3.7
        }
      };
      final result = WeatherModel.fromJson(json);
      expect(result, tModel);
    });
  });
}
