import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/entity/entity.dart';
import 'package:weather_app/domain/usecases/fetch_current_weather.dart';
import 'package:rxdart/rxdart.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this.fetchCurrentWeatherUseCase) : super(WeatherInitial()) {
    on<OnCityNameChange>(_onCityNameChange,
        transformer: debounce(const Duration(milliseconds: 500)));
  }

  final FetchCurrentWeatherUseCase fetchCurrentWeatherUseCase;

  FutureOr<void> _onCityNameChange(OnCityNameChange event, emit) async {
    emit(WeatherLoading());
    await fetchCurrentWeatherUseCase.execute(event.cityName).then(
      (value) {
        value.fold(
          (l) => emit(WeatherFailure(l.message)),
          (r) => emit(WeatherSuccess(r)),
        );
      },
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
