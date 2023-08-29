// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class OnCityNameChange extends WeatherEvent {
  final String cityName;
  const OnCityNameChange({
    required this.cityName,
  });
}
