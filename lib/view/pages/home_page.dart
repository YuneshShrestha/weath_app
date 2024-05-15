import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_weather_app/controller/save_and_get_location.dart';
import 'package:flutter_weather_app/controller/weather_controller.dart';
import 'package:flutter_weather_app/view/widgets/temperature_view_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WeatherController weatherController;
  late TextEditingController searchController;

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
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return '${position.latitude},${position.longitude}';
  }

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    Get.put(WeatherController(
      http.Client(),
    ));
    weatherController = Get.find<WeatherController>();

    Future.microtask(() async {
      var location = await SaveAndGetLocation.getLocation();
      if (location.trim().isNotEmpty) {
        if (mounted) {
          weatherController.getWeather(location);
        }
      } else {
        String myPosition = await getCurrentLocation();
        SaveAndGetLocation.saveLocation(myPosition);
        if (mounted) {
          weatherController.getWeather(myPosition);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 32.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50.0,
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
                    SizedBox(
                      height: 50.0,
                      child: Obx(() {
                        return IconButton(
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
                                  getData(searchController.text,
                                      searchController, weatherController);
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
      ),
    );
  }
}
