import 'package:flutter_application/models/sport_venue.dart';
import 'package:latlong2/latlong.dart';

class SportVenueAPI {
  String? id;
  String? name;
  String? activity;
  String? mail;
  double? latitude;
  double? longitude;

  SportVenueAPI(this.id, this.name, this.activity, this.mail, this.latitude, this.longitude);


  factory SportVenueAPI.fromGeoJson(Map<String, dynamic> json) {
    final id = json['res_fid'];
    final name = json['nom_instal'];
    final activity = json['activite'];
    final mail = json['mail'];
    final geoPoint = json['geo_point_2d'] as Map<String, dynamic>? ?? {};
    final latitude = geoPoint['lat'];
    final longitude = geoPoint['lon'];
    return SportVenueAPI(id, name, activity, mail, latitude, longitude);
  }

  SportVenue toSportVenue() {
    final LatLng coordinates = LatLng(latitude ?? 0.0, longitude ?? 0.0);

    return SportVenue(
      int.tryParse(id ?? '0') ?? 0,
      name ?? 'Inconnu',
      activity ?? 'Inconnue',
      0,
      mail ?? 'Inconnu',
      '', 
      coordinates,
      isFavorite: false, 
    );
  }
}
