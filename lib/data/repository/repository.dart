// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/data/data_source/data_source.dart';
import 'package:weather_app/domain/entity/entity.dart';
import 'package:weather_app/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  WeatherRepositoryImpl({
    required this.weatherRemoteDataSource,
  });

  @override
  Future<Either<Failure, WeatherEntity>> fetchCurrentWeather(
      String cityName) async {
    try {
      final result =
          await weatherRemoteDataSource.fetchCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(message: 'An error has occurred'));
    } on SocketException {
      return const Left(
          ConnectionFailure(message: 'Failed to connect to the network'));
    }

    /*   try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } */
  }
}
