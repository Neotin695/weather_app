import 'package:dartz/dartz.dart';
import 'package:weather_app/domain/entity/entity.dart';

import '../../core/core.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> fetchCurrentWeather(String cityName);
}
