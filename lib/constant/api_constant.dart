import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  // static const String apiKey = 'API_KEY';
  static String apiKey = dotenv.env['OPENWEATHER_API_KEY'] ?? '';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String geoBaseUrl = 'https://api.openweathermap.org/geo/1.0';
  static const String currentWeatherUrl = '$baseUrl/weather';
  static const String forecastUrl = '$baseUrl/forecast';
  static const String geoDirectUrl = '$geoBaseUrl/direct';
  static const String airPollutionUrl = '$baseUrl/air_pollution';
}
