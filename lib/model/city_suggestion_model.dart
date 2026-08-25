import 'dart:convert';

List<CitySuggestionModel> citySuggestionModelFromJson(String str) =>
    List<CitySuggestionModel>.from(
      json.decode(str).map((x) => CitySuggestionModel.fromJson(x)),
    );

String citySuggestionModelToJson(List<CitySuggestionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CitySuggestionModel {
  final String? name;
  final num? lat;
  final num? lon;
  final String? country;
  final String? state;

  CitySuggestionModel({
    this.name,
    this.lat,
    this.lon,
    this.country,
    this.state,
  });

  factory CitySuggestionModel.fromJson(Map<String, dynamic> json) {
    return CitySuggestionModel(
      name: json['name'] as String?,
      lat: json['lat'] as num?,
      lon: json['lon'] as num?,
      country: json['country'] as String?,
      state: json['state'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lat': lat,
      'lon': lon,
      'country': country,
      'state': state,
    };
  }
}
