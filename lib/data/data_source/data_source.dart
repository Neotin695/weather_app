// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/core/error/exception.dart';

import 'package:weather_app/data/model/weather.dart';

import '../../core/constants/api_constants.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> fetchCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client httpClient;
  WeatherRemoteDataSourceImpl({
    required this.httpClient,
  });

  @override
  Future<WeatherModel> fetchCurrentWeather(String cityName) async {
    final response =
        await httpClient.get(Uri.parse(Url.currentWeatherByName(cityName)));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
