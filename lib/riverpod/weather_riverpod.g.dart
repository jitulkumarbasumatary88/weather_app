// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_riverpod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$citySuggestionsHash() => r'fc37ae4944d1baef1ff44ad7e06f9d3eb740f905';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [citySuggestions].
@ProviderFor(citySuggestions)
const citySuggestionsProvider = CitySuggestionsFamily();

/// See also [citySuggestions].
class CitySuggestionsFamily extends Family<AsyncValue<List<CitySuggestionModel>>> {
  /// See also [citySuggestions].
  const CitySuggestionsFamily();

  /// See also [citySuggestions].
  CitySuggestionsProvider call(
    String query,
  ) {
    return CitySuggestionsProvider(
      query,
    );
  }

  @override
  CitySuggestionsProvider getProviderOverride(
    covariant CitySuggestionsProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'citySuggestionsProvider';
}

/// See also [citySuggestions].
class CitySuggestionsProvider
    extends AutoDisposeFutureProvider<List<CitySuggestionModel>> {
  /// See also [citySuggestions].
  CitySuggestionsProvider(
    String query,
  ) : this._internal(
          (ref) => citySuggestions(
            ref as CitySuggestionsRef,
            query,
          ),
          from: citySuggestionsProvider,
          name: r'citySuggestionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$citySuggestionsHash,
          dependencies: CitySuggestionsFamily._dependencies,
          allTransitiveDependencies:
              CitySuggestionsFamily._allTransitiveDependencies,
          query: query,
        );

  CitySuggestionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<CitySuggestionModel>> Function(CitySuggestionsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CitySuggestionsProvider._internal(
        (ref) => create(ref as CitySuggestionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CitySuggestionModel>> createElement() {
    return _CitySuggestionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CitySuggestionsProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _ItemHash.combine(0, runtimeType.hashCode);
    hash = _ItemHash.combine(hash, query.hashCode);

    return _ItemHash.finish(hash);
  }
}

mixin CitySuggestionsRef
    on AutoDisposeFutureProviderRef<List<CitySuggestionModel>> {
  /// The class property that was used to create this provider.
  String get query;
}

class _CitySuggestionsProviderElement
    extends AutoDisposeFutureProviderElement<List<CitySuggestionModel>>
    with CitySuggestionsRef {
  _CitySuggestionsProviderElement(super.provider);

  @override
  String get query => (provider as CitySuggestionsProvider).query;
}

typedef _ItemHash = _SystemHash;

String _$weatherNotifierHash() => r'269a842b01eb115fec3258c730e62057d1eb252f';

/// See also [WeatherNotifier].
@ProviderFor(WeatherNotifier)
final weatherNotifierProvider =
    AsyncNotifierProvider<WeatherNotifier, WeatherModel?>.internal(
  WeatherNotifier.new,
  name: r'weatherNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weatherNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WeatherNotifier = AsyncNotifier<WeatherModel?>;
String _$forecastNotifierHash() => r'29fcbb44e0573be04eeaa26bafe0e9e4f509e530';

/// See also [ForecastNotifier].
@ProviderFor(ForecastNotifier)
final forecastNotifierProvider =
    AsyncNotifierProvider<ForecastNotifier, ForecastModel?>.internal(
  ForecastNotifier.new,
  name: r'forecastNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$forecastNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ForecastNotifier = AsyncNotifier<ForecastModel?>;
String _$aqiNotifierHash() => r'9963e6ae7668612140bb0639e248b6c0032e54fb';

/// See also [AqiNotifier].
@ProviderFor(AqiNotifier)
final aqiNotifierProvider =
    AutoDisposeAsyncNotifierProvider<AqiNotifier, AqiModel>.internal(
  AqiNotifier.new,
  name: r'aqiNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$aqiNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AqiNotifier = AutoDisposeAsyncNotifier<AqiModel>;
String _$savedCitiesNotifierHash() =>
    r'83fa1144fbbd9da95d63f7dcfe8b33534b17bc09';

/// See also [SavedCitiesNotifier].
@ProviderFor(SavedCitiesNotifier)
final savedCitiesNotifierProvider = AutoDisposeAsyncNotifierProvider<
    SavedCitiesNotifier, List<String>>.internal(
  SavedCitiesNotifier.new,
  name: r'savedCitiesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$savedCitiesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SavedCitiesNotifier = AutoDisposeAsyncNotifier<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
