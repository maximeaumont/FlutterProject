import 'package:flutter/material.dart';
import 'package:flutter_application/components/input/autocomplete_input.dart';
import 'package:flutter_application/models/sport_venue.dart';
import 'package:http/http.dart' as http;

class SearchSportVenue extends StatelessWidget {
  const SearchSportVenue({super.key});

  final List<SportVenue> _sportVenues = const [
    SportVenue(0, 'Gymnase Albert José', 'Basket', 280,
        'gymnase_albert_jose@mail.fr', 'Nord Est Angers'),
    SportVenue(1, 'Terrain athlétisme Lac de Maine', 'Athlétisme', 420,
        'athletisme_ldm@mail.fr', 'A côté du Lac de Maine'),
    SportVenue(2, 'Terrain de boules Gare du Nord', 'Pétanque', 80,
        'petanque_gn@mail.fr', 'Derrière la gare')
  ];

  Future<http.Response> fetchData() {
    return http.get(Uri.parse(
        'https://data.angers.fr/api/explore/v2.1/catalog/datasets/equipements-sportifs-angers/records?select=res_fid%2C%20nom_instal%2C%20activite%2C%20mail&where=activite%3D%27TENNIS%27&limit=4'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lieux sportifs à Angers"),
      ),
      body: Container(
        color: Color.fromARGB(255, 187, 179, 180),
        child: Column(
          children: [
            const AutocompleteInput(),
            Expanded(
              child: ListView.separated(
                itemCount: _sportVenues.length,
                itemBuilder: (context, index) {
                  final sportVenue = _sportVenues[index];
                  return ListTile(
                    leading: const Icon(Icons.place),
                    title: Text(sportVenue.name),
                    subtitle: Text(
                      'Localisation : ${sportVenue.geoPosition}, Nombre de places : ${sportVenue.numberOfPlaces}',
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  final response = await fetchData();
                  print(response.body);
                },
                child: Text('Appuie sur le boutton')),
          ],
        ),
      ),
    );
  }
}
