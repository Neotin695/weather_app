// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String main;
  final String description;
  final String icon;
  final String name;
  final double temp;
  final int pressure;
  final int humidity;
  const WeatherEntity({
    required this.main,
    required this.description,
    required this.icon,
    required this.name,
    required this.temp,
    required this.pressure,
    required this.humidity,
  });

  @override
  List<Object> get props {
    return [
      main,
      description,
      icon,
      name,
      temp,
      pressure,
      humidity,
    ];
  }
}
