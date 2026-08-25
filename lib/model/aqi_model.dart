import 'dart:convert';

AqiModel aqiModelFromJson(String str) => AqiModel.fromJson(json.decode(str));

String aqiModelToJson(AqiModel data) => json.encode(data.toJson());

class AqiModel {
  // CHANGED: List<List>? ko List<AqiItem>? banaya
  AqiModel({Coord? coord, List<AqiItem>? list}) {
    _coord = coord;
    _list = list;
  }

  AqiModel.fromJson(dynamic json) {
    _coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        // CHANGED: AqiItem.fromJson
        _list?.add(AqiItem.fromJson(v));
      });
    }
  }

  Coord? _coord;

  // CHANGED: List<AqiItem>?
  List<AqiItem>? _list;

  AqiModel copyWith({Coord? coord, List<AqiItem>? list}) =>
      AqiModel(coord: coord ?? _coord, list: list ?? _list);

  Coord? get coord => _coord;

  List<AqiItem>? get list => _list;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_coord != null) {
      map['coord'] = _coord?.toJson();
    }
    if (_list != null) {
      map['list'] = _list?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

// CHANGED: class List -> class AqiItem
AqiItem aqiItemFromJson(String str) => AqiItem.fromJson(json.decode(str));

String aqiItemToJson(AqiItem data) => json.encode(data.toJson());

class AqiItem {
  AqiItem({Main? main, Components? components, num? dt}) {
    _main = main;
    _components = components;
    _dt = dt;
  }

  AqiItem.fromJson(dynamic json) {
    _main = json['main'] != null ? Main.fromJson(json['main']) : null;
    _components = json['components'] != null
        ? Components.fromJson(json['components'])
        : null;
    _dt = json['dt'];
  }

  Main? _main;
  Components? _components;
  num? _dt;

  AqiItem copyWith({Main? main, Components? components, num? dt}) => AqiItem(
    main: main ?? _main,
    components: components ?? _components,
    dt: dt ?? _dt,
  );

  Main? get main => _main;

  Components? get components => _components;

  num? get dt => _dt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_main != null) {
      map['main'] = _main?.toJson();
    }
    if (_components != null) {
      map['components'] = _components?.toJson();
    }
    map['dt'] = _dt;
    return map;
  }
}

Components componentsFromJson(String str) =>
    Components.fromJson(json.decode(str));

String componentsToJson(Components data) => json.encode(data.toJson());

class Components {
  Components({
    num? co,
    num? no,
    num? no2,
    num? o3,
    num? so2,
    num? pm25,
    num? pm10,
    num? nh3,
  }) {
    _co = co;
    _no = no;
    _no2 = no2;
    _o3 = o3;
    _so2 = so2;
    _pm25 = pm25;
    _pm10 = pm10;
    _nh3 = nh3;
  }

  Components.fromJson(dynamic json) {
    _co = json['co'];
    _no = json['no'];
    _no2 = json['no2'];
    _o3 = json['o3'];
    _so2 = json['so2'];
    _pm25 = json['pm2_5'];
    _pm10 = json['pm10'];
    _nh3 = json['nh3'];
  }

  num? _co;
  num? _no;
  num? _no2;
  num? _o3;
  num? _so2;
  num? _pm25;
  num? _pm10;
  num? _nh3;

  Components copyWith({
    num? co,
    num? no,
    num? no2,
    num? o3,
    num? so2,
    num? pm25,
    num? pm10,
    num? nh3,
  }) => Components(
    co: co ?? _co,
    no: no ?? _no,
    no2: no2 ?? _no2,
    o3: o3 ?? _o3,
    so2: so2 ?? _so2,
    pm25: pm25 ?? _pm25,
    pm10: pm10 ?? _pm10,
    nh3: nh3 ?? _nh3,
  );

  num? get co => _co;

  num? get no => _no;

  num? get no2 => _no2;

  num? get o3 => _o3;

  num? get so2 => _so2;

  num? get pm25 => _pm25;

  num? get pm10 => _pm10;

  num? get nh3 => _nh3;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['co'] = _co;
    map['no'] = _no;
    map['no2'] = _no2;
    map['o3'] = _o3;
    map['so2'] = _so2;
    map['pm2_5'] = _pm25;
    map['pm10'] = _pm10;
    map['nh3'] = _nh3;
    return map;
  }
}

Main mainFromJson(String str) => Main.fromJson(json.decode(str));

String mainToJson(Main data) => json.encode(data.toJson());

class Main {
  Main({num? aqi}) {
    _aqi = aqi;
  }

  Main.fromJson(dynamic json) {
    _aqi = json['aqi'];
  }

  num? _aqi;

  Main copyWith({num? aqi}) => Main(aqi: aqi ?? _aqi);

  num? get aqi => _aqi;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aqi'] = _aqi;
    return map;
  }
}

Coord coordFromJson(String str) => Coord.fromJson(json.decode(str));

String coordToJson(Coord data) => json.encode(data.toJson());

class Coord {
  Coord({num? lon, num? lat}) {
    _lon = lon;
    _lat = lat;
  }

  Coord.fromJson(dynamic json) {
    _lon = json['lon'];
    _lat = json['lat'];
  }

  num? _lon;
  num? _lat;

  Coord copyWith({num? lon, num? lat}) =>
      Coord(lon: lon ?? _lon, lat: lat ?? _lat);

  num? get lon => _lon;

  num? get lat => _lat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lon'] = _lon;
    map['lat'] = _lat;
    return map;
  }
}
