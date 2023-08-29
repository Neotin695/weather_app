import 'package:get_it/get_it.dart';
import 'package:weather_app/domain/usecases/fetch_current_weather.dart';
import 'package:weather_app/presentation/bloc/bloc/weather_bloc.dart';
import 'data/data_source/data_source.dart';
import 'data/repository/repository.dart';
import 'domain/repository/weather_repository.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void setupLocator() {

  // bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => FetchCurrentWeatherUseCase(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      weatherRemoteDataSource: locator()
    ),
  );

  // data source
  locator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(
      httpClient: locator(),
    ),
  );
  
  // external
  locator.registerLazySingleton(() => http.Client());

  
  
}