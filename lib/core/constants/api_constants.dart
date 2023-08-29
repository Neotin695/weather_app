class Url {
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5';
  static const String apiKey = '5b1de24ee38e14c127c50864c1b1fe6f';

  static String currentWeatherByName(String cityName) => '$baseUrl/weather?q=$cityName&appid=$apiKey';
  static String weatherIcon(String iconId) => 'https://openweathermap.org/img/wn/$iconId@2x.png';
}
