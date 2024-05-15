class WeatherModel {
  WeatherModel({
    required this.location,
    required this.current,
  });

  final Location? location;
  final Current? current;

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      current:
          json["current"] == null ? null : Current.fromJson(json["current"]),
    );
  }
}

class Current {
  Current({
    required this.tempC,
    required this.condition,
  });

  final double? tempC;

  final Condition? condition;

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      tempC: parseIntOrNullToDouble(json["temp_c"]),
      condition: json["condition"] == null
          ? null
          : Condition.fromJson(json["condition"]),
    );
  }
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

class Condition {
  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  final String? text;
  final String? icon;
  final int? code;

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json["text"].toString(),
      icon: json["icon"].toString(),
      code: json["code"],
    );
  }
}

class Location {
  Location({
    required this.name,
    required this.country,
  });

  final String? name;

  final String? country;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json["name"],
      country: json["country"],
    );
  }
}
