import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/page/search/search_page.dart';
import '../../custom_reuse/custom_three_layer/custom_background_gradient.dart';
import '../../custom_reuse/custom_three_layer/custom_blur_glass_effect.dart';
import '../../custom_reuse/custom_three_layer/custom_design_shape.dart';
import '../../riverpod/weather_riverpod.dart';
import 'home_page_in_part/current_weather.dart';
import 'home_page_in_part/graph_weather.dart';
import 'home_page_in_part/grid_weather.dart';
import 'home_page_in_part/hourly_weather.dart';
import 'home_page_in_part/sun_rise_or_set_weather.dart';
import 'home_page_in_part/weekly_weather.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherNotifierProvider);

    // Current weather data se condition aur icon code nikalna
    final currentWeather = weatherState.value;
    final condition = currentWeather?.weather?[0].main;
    final iconCode = currentWeather?.weather?[0].icon;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarContrastEnforced: false,
        systemStatusBarContrastEnforced: false,
      ),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                CustomBackgroundGradient(
                  condition: condition,
                  iconCode: iconCode,
                ),

                CustomDesignShape(condition: condition, iconCode: iconCode),

                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Builder(
                      builder: (context) {
                        //////////////////// Bay Blade ////////////////////
                        if (weatherState.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }

                        //////////////////// Error Notification ////////////////////
                        if (weatherState.hasError) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: CustomBlurGlassEffect(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.cloud_off_rounded,
                                      size: 50,
                                      color: Colors.redAccent,
                                    ),

                                    const SizedBox(height: 12),

                                    Text(
                                      weatherState.error.toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }

                        //////////////////// No Data Notification ////////////////////
                        if (weatherState.value == null) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: CustomBlurGlassEffect(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      Icons.search_rounded,
                                      size: 50,
                                      color: Colors.amber,
                                    ),

                                    SizedBox(height: 15),

                                    Text(
                                      'Search for a city to view the weather',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return RefreshIndicator(
                            // Spinner color
                            color: Colors.white,
                            // Dark theme matching background
                            backgroundColor: const Color(0xFF1E293B),
                            onRefresh: () async {
                              final current = weatherState.value;
                              final country = current?.sys?.country;

                              // Agar country available hai toh "City, Country" bhejega, varna sirf "City"
                              final query = current != null
                                  ? (country != null && country.isNotEmpty
                                        ? '${current.name}, $country'
                                        : current.name)
                                  : null;

                              if (query != null) {
                                // Dono APIs (Current + Forecast) exact usi city & country ke sath refresh hongi
                                await Future.wait([
                                  ref
                                      .read(weatherNotifierProvider.notifier)
                                      .searchWeather(query),
                                  ref
                                      .read(forecastNotifierProvider.notifier)
                                      .searchForecast(query),
                                ]);
                              }
                            },
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              child: constraints.maxWidth > 600
                                  //////////////////// Big Screen View ////////////////////
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: const [
                                              CurrentWeather(),
                                              SizedBox(height: 10),
                                              HourlyWeather(),
                                              SizedBox(height: 10),
                                              GraphWeather(),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            children: const [
                                              WeeklyWeather(),
                                              SizedBox(height: 10),
                                              GridWeather(),
                                              SizedBox(height: 10),
                                              SunRiseOrSetWeather(),
                                              SizedBox(height: 60),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  //////////////////// Small Screen View ////////////////////
                                  : Column(
                                      children: const [
                                        CurrentWeather(),
                                        SizedBox(height: 10),
                                        HourlyWeather(),
                                        SizedBox(height: 10),
                                        GraphWeather(),
                                        SizedBox(height: 10),
                                        WeeklyWeather(),
                                        SizedBox(height: 10),
                                        GridWeather(),
                                        SizedBox(height: 10),
                                        SunRiseOrSetWeather(),
                                        SizedBox(height: 58),
                                      ],
                                    ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),

                //////////////////// Bottom Button ////////////////////
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          enableDrag: false,
                          useSafeArea: true,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const SearchPage(),
                        );
                      },
                      child: const CustomBlurGlassEffect(
                        width: 100,
                        padding: EdgeInsets.zero,
                        child: Icon(
                          Icons.arrow_drop_up_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
