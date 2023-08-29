import 'package:weather_app/domain/entity/entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.main,
    required super.description,
    required super.icon,
    required super.name,
    required super.temp,
    required super.pressure,
    required super.humidity,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        main: json['weather'][0]['main'],
        description: json['weather'][0]['description'],
        icon: json['weather'][0]['icon'],
        name: json['name'],
        temp: json['main']['temp'],
        pressure: json['main']['pressure'],
        humidity: json['main']['humidity']);
  }

  Map<String, dynamic> toJson() {
    return {
      'weather': [
        {
          'main': main,
          'description': description,
          'icon': icon,
        }
      ],
      'main': {
        'temp': temp,
        'pressure': pressure,
        'humidity': humidity,
      },
      'name': name,
    };
  }

  WeatherEntity toEntity() => WeatherEntity(
      main: main,
      description: description,
      icon: icon,
      name: name,
      temp: temp,
      pressure: pressure,
      humidity: humidity);
}
