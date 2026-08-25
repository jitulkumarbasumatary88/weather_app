import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/riverpod/weather_riverpod.dart';
import '../../custom_reuse/custom_three_layer/custom_blur_glass_effect.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

  void _triggerSearch(String cityName) {
    final city = cityName.trim();
    if (city.isNotEmpty) {
      ref.read(weatherNotifierProvider.notifier).searchWeather(city);
      ref.read(forecastNotifierProvider.notifier).searchForecast(city);
      ref.read(savedCitiesNotifierProvider.notifier).addCity(city);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchSuggestion = ref.watch(citySuggestionsProvider(_searchQuery));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return CustomBlurGlassEffect(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            borderRadius: 0,
            border: Border.all(color: Colors.transparent),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Search Your City',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.settings_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Type a city for weather...',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (_searchQuery.trim().isNotEmpty)
                  ConstrainedBox(
                    /////////////////////////
                    constraints: const BoxConstraints(maxHeight: 250),
                    child: CustomBlurGlassEffect(
                      child: searchSuggestion.when(
                        data: (suggestion) {
                          if (suggestion.isEmpty) {
                            return const Center(
                              child: Text(
                                'No matching cities found',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            shrinkWrap: true,
                            itemCount: suggestion.length,
                            itemBuilder: (context, index) {
                              final city = suggestion[index];
                              return ListTile(
                                leading: const Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  '${city.name ?? ''}, ${city.country ?? ''}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_right_rounded,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  ref
                                      .read(
                                        savedCitiesNotifierProvider.notifier,
                                      )
                                      .addCity(city.name ?? '');
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                              );
                            },
                          );
                        },
                        loading: () => Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                        error: (err, _) => Center(child: Text(err.toString())),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                Expanded(
                  child: ref
                      .watch(savedCitiesNotifierProvider)
                      .when(
                        data: (cities) {
                          if (cities.isEmpty) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 40),
                                child: Text(
                                  'No saved cities yet',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            itemCount: cities.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: _buildSaveOrDeleteList(cities[index]),
                              );
                            },
                          );
                        },
                        loading: () => const CustomBlurGlassEffect(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        error: (err, _) => CustomBlurGlassEffect(
                          child: Center(child: Text(err.toString())),
                        ),
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSaveOrDeleteList(String cityName) {
    return CustomBlurGlassEffect(
      child: ListTile(
        leading: const Icon(Icons.location_on_rounded, color: Colors.white),
        title: Text(
          cityName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
          onPressed: () {
            ref.read(savedCitiesNotifierProvider.notifier).deleteCity(cityName);
          },
        ),
        onTap: () {
          _triggerSearch(cityName);
        },
      ),
    );
  }
}
