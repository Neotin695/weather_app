import 'package:dartz/dartz.dart';
import 'package:weather_app/domain/entity/entity.dart';
import 'package:weather_app/domain/repository/weather_repository.dart';

import '../../core/core.dart';

class FetchCurrentWeatherUseCase {
  final WeatherRepository _repository;

  FetchCurrentWeatherUseCase(this._repository);

  Future<Either<Failure, WeatherEntity>> execute(String cityName) async {
    return _repository.fetchCurrentWeather(cityName);
  }
}
