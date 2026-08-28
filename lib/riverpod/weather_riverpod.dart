import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/api/api_integrate.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/model/forecast_model.dart';
import 'package:weather_app/model/aqi_model.dart';
import 'package:weather_app/model/city_suggestion_model.dart';

//////////////////// Generated file ko link karta hai (build_runner code use karne ke liye) ////////////////////
part 'weather_riverpod.g.dart';

//////////////////// Auto provider banayega + data hamesha memory me cache rakhega ////////////////////
@Riverpod(keepAlive: true)
//////////////////// Weather ////////////////////
class WeatherNotifier extends _$WeatherNotifier {
  final ApiIntegrate _apiService = ApiIntegrate();

  @override
  FutureOr<WeatherModel?> build() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('saved_cities_list') ?? [];
    if (savedList.isNotEmpty) {
      return _apiService.fetchCurrentWeather(savedList.last);
    }
    return null;
  }

  Future<void> searchWeather(String cityName) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _apiService.fetchCurrentWeather(cityName),
    );
  }
}

@Riverpod(keepAlive: true)
//////////////////// Forecast ////////////////////
class ForecastNotifier extends _$ForecastNotifier {
  final ApiIntegrate _apiService = ApiIntegrate();

  @override
  FutureOr<ForecastModel?> build() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('saved_cities_list') ?? [];
    if (savedList.isNotEmpty) {
      return _apiService.fetchForecast(savedList.last);
    }
    return null;
  }

  Future<void> searchForecast(String cityName) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _apiService.fetchForecast(cityName));
  }
}

@riverpod
//////////////////// Aqi ////////////////////
class AqiNotifier extends _$AqiNotifier {
  final ApiIntegrate _apiService = ApiIntegrate();

  @override
  FutureOr<AqiModel> build() async {
    return _apiService.fetchAqi(28.6139, 77.2090);
  }

  Future<void> fetchAqiForCity(double lat, double lon) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _apiService.fetchAqi(lat, lon));
  }
}

@riverpod
//////////////////// Search Suggestion ////////////////////
Future<List<CitySuggestionModel>> citySuggestions(
  CitySuggestionsRef ref,
  String query,
) async {
  if (query.trim().isEmpty) {
    return [];
  }
  return ApiIntegrate().fetchCitySuggestions(query);
}

@riverpod
//////////////////// Save or Delete ////////////////////
class SavedCitiesNotifier extends _$SavedCitiesNotifier {
  static const String _key = 'saved_cities_list';

  @override
  FutureOr<List<String>> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  Future<void> addCity(String cityName) async {
    final trimmed = cityName.trim();
    if (trimmed.isEmpty) return;
    final currentList = state.value ?? [];
    if (!currentList.contains(trimmed)) {
      final updatedList = [...currentList, trimmed];
      state = AsyncValue.data(updatedList);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_key, updatedList);
    }
  }

  Future<void> deleteCity(String cityName) async {
    final currentList = state.value ?? [];
    final updatedList = currentList.where((city) => city != cityName).toList();
    state = AsyncValue.data(updatedList);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, updatedList);
  }
}
