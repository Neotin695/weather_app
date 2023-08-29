import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/entity/entity.dart';
import 'package:weather_app/domain/usecases/fetch_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late FetchCurrentWeatherUseCase fetchCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    fetchCurrentWeatherUseCase =
        FetchCurrentWeatherUseCase(mockWeatherRepository);
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

  const testCityName = 'egypt';

  test(
    'should fetch current weather details from the repository',
    () async {
      when(
        mockWeatherRepository.fetchCurrentWeather(testCityName),
      ).thenAnswer((_) async => const Right(testWeatherMock));

      final result = await fetchCurrentWeatherUseCase.execute(testCityName);

      expect(result, const Right(testWeatherMock));
    },
  );
}
