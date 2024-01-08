class SportVenue {
  String? id;
  String? name;
  String? activity;
  String? numberOfPlaces;
  String? mail;
  String? geoPosition;

  SportVenue(this.id, this.name, this.activity, this.numberOfPlaces, this.mail,
      this.geoPosition);

  factory SportVenue.fromGeoJson(Map<String, dynamic> json) {
    final id = json['res_fid'];
    final name = json['nom_instal'];
    final activity = json['activite'];
    final numberOfPlaces = json['nb_place'];
    final mail = json['mail'];
    // final geoPosition = json['geo_point_2d'];
    final geoPosition = 'Pas de localisation';
    return SportVenue(id, name, activity, numberOfPlaces, mail, geoPosition);
  }
}
