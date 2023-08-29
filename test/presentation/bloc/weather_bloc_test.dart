import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/core.dart';
import 'package:weather_app/domain/entity/entity.dart';
import 'package:weather_app/presentation/bloc/bloc/weather_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockFetchCurrentWeatherUseCase mockFetchCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockFetchCurrentWeatherUseCase = MockFetchCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockFetchCurrentWeatherUseCase);
  });

  const testWeatherMock = WeatherEntity(
    main: 'clouds',
    description: 'weather to cloud today',
    icon: 'test',
    name: 'egypt',
    temp: 300,
    pressure: 123,
    humidity: 12323,
  );

  group('weather bloc ', () {
    test('initial state of bloc ', () async {
      expect(weatherBloc.state, WeatherInitial());
    });

    blocTest<WeatherBloc, WeatherState>(
      'emits WeatherLoading when onCityNameChange is added.',
      build: () {
        when(mockFetchCurrentWeatherUseCase.execute('egypt'))
            .thenAnswer((realInvocation) async => const Right(testWeatherMock));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityNameChange(cityName: 'egypt')),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WeatherLoading(),
        const WeatherSuccess(testWeatherMock),
      ],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits Weather Failure when onCityNameChange is added.',
      build: () {
        when(mockFetchCurrentWeatherUseCase.execute('egypt')).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure(message: 'error')));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityNameChange(cityName: 'egypt')),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WeatherLoading(),
        const WeatherFailure('error'),
      ],
    );
    blocTest<WeatherBloc, WeatherState>(
      'emits Weather Success when onCityNameChange is added.',
      build: () {
        when(mockFetchCurrentWeatherUseCase.execute('egypt'))
            .thenAnswer((realInvocation) async => const Right(testWeatherMock));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityNameChange(cityName: 'egypt')),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WeatherLoading(),
        const WeatherSuccess(testWeatherMock),
      ],
    );
  });
}
