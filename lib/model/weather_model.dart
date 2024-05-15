import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  const WeatherModel({
    required this.location,
    required this.current,
  });

  final Location? location;
  final Current? current;

  const WeatherModel.empty()
      : location = const Location.empty(),
        current = const Current.empty();

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      current:
          json["current"] == null ? null : Current.fromJson(json["current"]),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [location, current];
}

class Current extends Equatable {
  const Current({
    required this.tempC,
    required this.condition,
  });

  final double? tempC;

  final Condition? condition;

  const Current.empty()
      : tempC = 0.0,
        condition = const Condition.empty();

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      tempC: parseIntOrNullToDouble(json["temp_c"]),
      condition: json["condition"] == null
          ? null
          : Condition.fromJson(json["condition"]),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [tempC, condition];
}

double parseIntOrNullToDouble(dynamic value) {
  if (value is int) {
    return value.toDouble();
  } else if (value is String) {
    return double.parse(value);
  } else if (value == null) {
    return 0.0;
  } else {
    return value;
  }
}

class Condition extends Equatable {
  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  final String? text;
  final String? icon;
  final int? code;
  const Condition.empty()
      : text = 'Sunny',
        icon = '//cdn.weatherapi.com/weather/64x64/day/116.png',
        code = 0;
  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json["text"].toString(),
      icon: json["icon"].toString(),
      code: json["code"],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [text, icon, code];
}

class Location extends Equatable {
  Location({
    required this.name,
    required this.country,
  });

  final String? name;

  final String? country;
  const Location.empty()
      : name = 'Dharan',
        country = 'Nepal';
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json["name"],
      country: json["country"],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name, country];
}
