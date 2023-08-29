import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/constants/api_constants.dart';
import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/data/data_source/data_source.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/model/weather.dart';

import '../../helper/json_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(httpClient: mockHttpClient);
  });

  group('fetch current weather', () {
    test('should return weather model when response code is 200', () async {
      when(
        mockHttpClient.get(Uri.parse(Url.currentWeatherByName('egypt'))),
      ).thenAnswer((realInvocation) async => http.Response(
          readJson('helper/dummy/dummy_data_response.json'), 200));

      final result =
          await weatherRemoteDataSourceImpl.fetchCurrentWeather('egypt');

      expect(result, isA<WeatherModel>());
    });

    test('should not return weather model when response code is 404', () async {
      when(
        mockHttpClient.get(Uri.parse(Url.currentWeatherByName('egypt'))),
      ).thenAnswer((realInvocation) async => http.Response('not found', 404));

      final result = weatherRemoteDataSourceImpl.fetchCurrentWeather('egypt');
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
