import 'package:flutter/material.dart';
import 'package:flutter_weather_app/controller/weather_controller.dart';
import 'package:flutter_weather_app/view/widgets/temperature_view_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   late WeatherController weatherController;

  void getData(String value, TextEditingController searchController,
      WeatherController weatherController) {
    if (value.isNotEmpty) {
      weatherController.getWeather(searchController.text);
    } else {
      Get.snackbar('Error', 'Please enter a city name');
    }
  }

 Future<String> getCurrentLocation() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  return '${position.latitude},${position.longitude}';
}

  @override
void initState() {
  super.initState();
  Get.put(WeatherController());
  weatherController = Get.find<WeatherController>();

  Future.microtask(() async {
    String myPosition = await getCurrentLocation();
    weatherController.getWeather(myPosition);
  });
}

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 34,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 7,
                    child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search by city name, lat/long, etc.',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            bottomLeft: Radius.circular(16.0),
                          )),
                        ),
                        onSubmitted: (value) {
                          getData(value, searchController, weatherController);
                        }),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Obx(() {
                      return IconButton(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.4,
                        ),
                        color: Colors.white,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0),
                            ),
                          ),
                        ),
                        onPressed: weatherController.isLoading.value
                            ? null
                            : () {
                                getData(searchController.text, searchController,
                                    weatherController);
                              },
                        icon: weatherController.isLoading.value
                            ? const CircularProgressIndicator()
                            : const Icon(Icons.search),
                      );
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            Obx(
              () => TemperatureViewWidget(
                temperature: '${weatherController.temperature}',
                weather: weatherController.weather.value,
                weatherIcon: 'https:${weatherController.weatherIcon.value}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
