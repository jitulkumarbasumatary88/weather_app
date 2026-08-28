import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/constant/api_constant.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/model/forecast_model.dart';
import 'package:weather_app/model/city_suggestion_model.dart';
import 'package:weather_app/model/aqi_model.dart';

class ApiIntegrate {
  //////////////////// Weather ////////////////////
  Future<WeatherModel> fetchCurrentWeather(String cityName) async {
    final url =
        '${ApiConstants.currentWeatherUrl}?q=$cityName&units=metric&appid=${ApiConstants.apiKey}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        throw 'City not found! Please check spelling.';
      } else {
        throw 'Server Error: ${response.statusCode}';
      }
    } catch (e) {
      if (e is String) rethrow;
      throw 'No Internet Connection. Please try again!';
    }
  }

  //////////////////// Forecast ////////////////////
  Future<ForecastModel> fetchForecast(String cityName) async {
    final url =
        '${ApiConstants.forecastUrl}?q=$cityName&units=metric&appid=${ApiConstants.apiKey}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return ForecastModel.fromJson(jsonDecode(response.body));
      } else {
        throw 'Failed to load forecast data.';
      }
    } catch (e) {
      if (e is String) rethrow;
      throw 'No Internet Connection. Please try again!';
    }
  }

  //////////////////// Aqi ////////////////////
  Future<AqiModel> fetchAqi(double lat, double lon) async {
    final url =
        '${ApiConstants.airPollutionUrl}?lat=$lat&lon=$lon&appid=${ApiConstants.apiKey}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return AqiModel.fromJson(jsonDecode(response.body));
      } else {
        throw 'Failed to load AQI data.';
      }
    } catch (e) {
      if (e is String) rethrow;
      throw 'No Internet Connection. Please try again!';
    }
  }

  //////////////////// Search Suggestion ////////////////////
  Future<List<CitySuggestionModel>> fetchCitySuggestions(String query) async {
    if (query.trim().isEmpty) return [];
    final url =
        '${ApiConstants.geoDirectUrl}?q=$query&limit=5&appid=${ApiConstants.apiKey}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return citySuggestionModelFromJson(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
