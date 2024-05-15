import 'package:flutter/material.dart';

class TemperatureViewWidget extends StatelessWidget {
  const TemperatureViewWidget(
      {super.key,
      required this.temperature,
      required this.weather,
      required this.weatherIcon});
  final String temperature;
  final String weather;
  final String weatherIcon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.yellow.withOpacity(0.5),
                      Colors.orangeAccent.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    width: 1.5,
                    color: Colors.yellowAccent.withOpacity(0.2),
                  ),
                ),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      weatherIcon,
                      width: 64.0,
                      height: 64.0,
                    ),
                   // Weather icon
                   const SizedBox(height: 16.0),
                    Text(temperature,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 48.0)), // Temperature
                   const SizedBox(height: 16.0),
                    Text(weather,
                        style:const TextStyle(
                            color: Colors.white,
                            fontSize: 24.0)), // Weather text
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
