import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/core.dart';
import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/data/model/weather.dart';
import 'package:weather_app/data/repository/repository.dart';
import 'package:weather_app/domain/entity/entity.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource remoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    remoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl =
        WeatherRepositoryImpl(weatherRemoteDataSource: remoteDataSource);
  });

  const testModel = WeatherModel(
    main: 'Clear',
    description: 'clear sky',
    icon: '01d',
    name: 'Egypt',
    temp: 298.64,
    pressure: 1011,
    humidity: 66,
  );
  const testEntity = WeatherEntity(
    main: 'Clear',
    description: 'clear sky',
    icon: '01d',
    name: 'Egypt',
    temp: 298.64,
    pressure: 1011,
    humidity: 66,
  );

  const String cityName = 'egypt';

  group('fetch Current weather', () {
    test(
        'should return current weather when a call to date source is successfully',
        () async {
      when(remoteDataSource.fetchCurrentWeather(cityName))
          .thenAnswer((realInvocation) async => testModel);

      final reuslt = await weatherRepositoryImpl.fetchCurrentWeather(cityName);

      expect(reuslt, equals(const Right(testEntity)));
    });
    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(remoteDataSource.fetchCurrentWeather(cityName))
            .thenThrow(ServerException());

        // act
        final result =
            await weatherRepositoryImpl.fetchCurrentWeather(cityName);

        // assert
        expect(
            result,
            equals(
                const Left(ServerFailure(message: 'An error has occurred'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(remoteDataSource.fetchCurrentWeather(cityName)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result =
            await weatherRepositoryImpl.fetchCurrentWeather(cityName);

        // assert
        expect(
            result,
            equals(const Left(ConnectionFailure(
                message: 'Failed to connect to the network'))));
      },
    );
  }); 
}
