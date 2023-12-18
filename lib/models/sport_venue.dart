import 'package:latlong2/latlong.dart';

class SportVenue {
  final int id;
  final String name;
  final String activity;
  final int numberOfPlaces;
  final String mail;
  final String geoPosition;
  final LatLng coordinates;
  bool isFavorite;

  SportVenue(
    this.id,
    this.name,
    this.activity,
    this.numberOfPlaces,
    this.mail,
    this.geoPosition,
    this.coordinates,
    {this.isFavorite = false}
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'activity': activity,
      'numberOfPlaces': numberOfPlaces,
      'mail': mail,
      'geoPosition': geoPosition,
      'coordinates': {'latitude': coordinates.latitude, 'longitude': coordinates.longitude}, 
      'isFavorite': isFavorite,
    };
  }

  factory SportVenue.fromJson(Map<String, dynamic> json) {
    final coordinatesJson = json['coordinates'] as Map<String, dynamic>? ?? {};
    final LatLng coordinates = LatLng(
      coordinatesJson['latitude'] ?? 0.0, 
      coordinatesJson['longitude'] ?? 0.0,
    );

    return SportVenue(
      json['id'],
      json['name'],
      json['activity'],
      json['numberOfPlaces'],
      json['mail'],
      json['geoPosition'],
      coordinates,
      isFavorite: json['isFavorite'],
    );
  }
}
