import 'package:mockito/annotations.dart';
import 'package:weather_app/data/data_source/data_source.dart';
import 'package:weather_app/domain/repository/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/domain/usecases/fetch_current_weather.dart';

@GenerateMocks([WeatherRepository, WeatherRemoteDataSource,FetchCurrentWeatherUseCase],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}
