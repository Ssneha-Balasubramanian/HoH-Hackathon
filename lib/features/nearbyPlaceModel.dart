import 'dart:convert';

NearbyPlaces nearbyPlacesFromJson(String str) => NearbyPlaces.fromJson(json.decode(str));

String nearbyPlacesToJson(NearbyPlaces data) => json.encode(data.toJson());

class NearbyPlaces {
  NearbyPlaces({
    required this.type,
    required this.features,
  });

  String type;
  List<Feature> features;

  factory NearbyPlaces.fromJson(Map<String, dynamic> json) => NearbyPlaces(
    type: json["type"],
    features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "features": List<dynamic>.from(features.map((x) => x.toJson())),
  };
}

class Feature {
  Feature({
    required this.type,
    required this.properties,
    required this.geometry,
  });

  String type;
  Properties properties;
  Geometry geometry;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    type: json["type"],
    properties: Properties.fromJson(json["properties"]),
    geometry: Geometry.fromJson(json["geometry"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "properties": properties.toJson(),
    "geometry": geometry.toJson(),
  };
}

class Geometry {
  Geometry({
    required this.type,
    required this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    type: json["type"],
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
  };
}

class Properties {
  Properties({
    required this.name,
    required this.street,
    required this.suburb,
    required this.district,
    required this.city,
    required this.county,
    required this.state,
    required this.postcode,
    required this.country,
    required this.countryCode,
    required this.lon,
    required this.lat,
    required this.formatted,
    required this.addressLine1,
    required this.addressLine2,
    required this.categories,
    required this.details,
    required this.datasource,
    required this.distance,
    required this.placeId,
    required this.neighbourhood,
  });

  String? name;
  String? street;
  String? suburb;
  String? district;
  String? city;
  String? county;
  String? state;
  String? postcode;
  String? country;
  String? countryCode;
  double? lon;
  double? lat;
  String? formatted;
  String? addressLine1;
  String? addressLine2;
  List<String> categories;
  List<dynamic> details;
  Datasource datasource;
  int? distance;
  String? placeId;
  String? neighbourhood;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    name: json["name"] == null ? null : json["name"],
    street: json["street"],
    suburb: json["suburb"],
    district: json["district"],
    city: json["city"],
    county: json["county"],
    state: json["state"],
    postcode: json["postcode"],
    country: json["country"],
    countryCode: json["country_code"],
    lon: json["lon"].toDouble(),
    lat: json["lat"].toDouble(),
    formatted: json["formatted"],
    addressLine1: json["address_line1"],
    addressLine2: json["address_line2"],
    categories: List<String>.from(json["categories"].map((x) => x)),
    details: List<dynamic>.from(json["details"].map((x) => x)),
    datasource: Datasource.fromJson(json["datasource"]),
    distance: json["distance"],
    placeId: json["place_id"],
    neighbourhood: json["neighbourhood"] == null ? null : json["neighbourhood"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "street": street,
    "suburb": suburb,
    "district": district,
    "city": city,
    "county": county,
    "state": state,
    "postcode": postcode,
    "country": country,
    "country_code": countryCode,
    "lon": lon,
    "lat": lat,
    "formatted": formatted,
    "address_line1": addressLine1,
    "address_line2": addressLine2,
    "categories": List<dynamic>.from(categories.map((x) => x)),
    "details": List<dynamic>.from(details.map((x) => x)),
    "datasource": datasource.toJson(),
    "distance": distance,
    "place_id": placeId,
    "neighbourhood": neighbourhood == null ? null : neighbourhood,
  };
}

class Datasource {
  Datasource({
    required this.sourcename,
    required this.attribution,
    required this.license,
    required this.url,
  });

  String? sourcename;
  String? attribution;
  String? license;
  String? url;

  factory Datasource.fromJson(Map<String, dynamic> json) => Datasource(
    sourcename: json["sourcename"],
    attribution: json["attribution"],
    license: json["license"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "sourcename": sourcename,
    "attribution": attribution,
    "license": license,
    "url": url,
  };
}