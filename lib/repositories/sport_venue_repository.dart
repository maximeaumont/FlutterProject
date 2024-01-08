import 'dart:convert';

import 'package:flutter_application/models/sport_venue.dart';
import 'package:http/http.dart';

class SportVenueRepository {
  Future<List<SportVenue>> fetchSportVenues(String query) async {
    String activite = query.toUpperCase();
    final Response response = await get(Uri.parse(
        'https://data.angers.fr//api/explore/v2.1/catalog/datasets/equipements-sportifs-angers/records?where=activite%20LIKE%20%27%25$activite%25%27&limit=20'));
    if (response.statusCode == 200) {
      final List<SportVenue> sportvenues = [];
      final Map<String, dynamic> json = jsonDecode(response.body);
      if (json.containsKey("results")) {
        final List<dynamic> results = json['results'];
        for (Map<String, dynamic> result in results) {
          final SportVenue sportvenue = SportVenue.fromGeoJson(result);
          sportvenues.add(sportvenue);
        }
      }
      return sportvenues;
    } else {
      throw Exception('Failed to load sport venues');
    }
  }
}
