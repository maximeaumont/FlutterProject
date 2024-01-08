import 'dart:convert';

import 'package:flutter_application/models/sport_venue.dart';
import 'package:http/http.dart';

class SportVenueRepository {
  Future<List<SportVenue>> fetchSportVenues(String query) async {
    final Response response = await get(Uri.parse(
        'https://data.angers.fr/api/explore/v2.1/catalog/datasets/equipements-sportifs-angers/records?select=res_fid%2C%20nom_instal%2C%20activite%2C%20mail&where=activite%3D%27$query%27&limit=4'));
    if (response.statusCode == 200) {
      final List<SportVenue> sportvenues =
          []; // Liste que la méthode va renvoyer
      print(response.body);

      // Transformation du JSON (String) en Map<String, dynamic>
      final Map<String, dynamic> json = jsonDecode(response.body);
      if (json.containsKey("results")) {
        // Récupération des "features"
        final List<dynamic> results = json['results'];
        // Transformation de chaque "feature" en objet de type "Address"
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
