class SportVenue {
  final int id;
  final String name;
  final String activity;
  final int numberOfPlaces;
  final String mail;
  final String geoPosition;
  bool isFavorite;

  SportVenue(this.id, this.name, this.activity, this.numberOfPlaces,
      this.mail, this.geoPosition, {this.isFavorite = false});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'activity': activity,
      'numberOfPlaces': numberOfPlaces,
      'mail': mail,
      'geoPosition': geoPosition,
      'isFavorite': isFavorite,
    };
  }

  factory SportVenue.fromJson(Map<String, dynamic> json) {
    return SportVenue(
      json['id'],
      json['name'],
      json['activity'],
      json['numberOfPlaces'],
      json['mail'],
      json['geoPosition'],
      isFavorite: json['isFavorite'],
    );
  }
}
