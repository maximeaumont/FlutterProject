import 'package:flutter/material.dart';
import 'package:flutter_application/models/sport_venue.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Lieux sportifs à Angers"),
        ),
        body: Container(
            color:
                Color.fromARGB(255, 173, 14, 41), // Couleur de fond de l'écran
            child: Center(
                child: ListView.separated(
                    itemCount: _sportVenues.length, // à remplacer,
                    itemBuilder: (context, index) {
                      final sportVenue = _sportVenues[index];
                      return ListTile(
                        leading: const Icon(Icons.place),
                        title: Text(sportVenue.name),
                        subtitle: Text(
                            'Localisation : ${sportVenue.geoPosition}, Nombre de places : ${sportVenue.numberOfPlaces}'),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider()))));
  }
}
