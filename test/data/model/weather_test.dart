import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/data/model/weather.dart';
import 'package:weather_app/domain/entity/entity.dart';

import '../../helper/json_reader.dart';

void main() {
  const testModel = WeatherModel(
    main: 'Clear',
    description: 'clear sky',
    icon: '01d',
    name: 'Egypt',
    temp: 298.64,
    pressure: 1011,
    humidity: 66,
  );

  test('should be a subclass of weather entity', () async {
    expect(testModel, isA<WeatherEntity>());
  });

  test('shoud be return valide data', () async {
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helper/dummy/dummy_data_response.json'));

    final result = WeatherModel.fromJson(jsonMap);

    expect(result, equals(testModel));
  });

  test('should be returned a json map containing a proper data', () async {
    final result = testModel.toJson();

    final resultTest = {
      'weather': [
        {
          'main': 'Clear',
          'description': 'clear sky',
          'icon': '01d',
        }
      ],
      'main': {
        'temp': 298.64,
        'pressure': 1011,
        'humidity': 66,
      },
      'name': 'Egypt',
    };

    expect(result, equals(resultTest));
  });
}
