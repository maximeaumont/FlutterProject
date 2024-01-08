import 'package:latlong2/latlong.dart';

class SportVenue {
  String? id;
  String? name;
  String? activity;
  String? numberOfPlaces;
  String? mail;
  String? coordinates;
  bool isFavorite;

  SportVenue(
    this.id,
    this.name,
    this.activity,
    this.numberOfPlaces,
    this.mail,
    this.coordinates,
    {this.isFavorite = false},
  );
  
// méthode de MAXIMEméthode de MAXIMEméthode de MAXIMEméthode de MAXIMEméthode de MAXIMEméthode de MAXIME
//   Map<String, dynamic> toJson() { 
//   return {
//     'id': id,
//     'name': name,
//     'activity': activity,
//     'numberOfPlaces': numberOfPlaces,
//     'mail': mail,
//     'geoPosition': geoPosition,
//     'coordinates': {'latitude': coordinates.latitude, 'longitude': coordinates.longitude}, 
//     'isFavorite': isFavorite,
//   };
//   }

  factory SportVenue.fromGeoJson(Map<String, dynamic> json) {
    final id = json['res_fid'];
    final name = json['nom_instal'];
    final activity = json['activite'];
    final numberOfPlaces = json['nb_place'];
    final mail = json['mail'];
    
    final coordinatesJson = json['geo_point_2d'] as Map<String, dynamic>? ?? {};
    final LatLng coordinates = LatLng(
      coordinatesJson['lat'] ?? 0.0, 
      coordinatesJson['lon'] ?? 0.0,
    return SportVenue(id, name, activity, numberOfPlaces, mail, coordinates);
  }
}
