import 'package:flutter/material.dart';
import 'package:flutter_application/models/sport_venue.dart';
import 'package:flutter_application/repositories/sport_venue_repository.dart';

class SearchSportVenue extends StatefulWidget {
  const SearchSportVenue({super.key});

  @override
  State<SearchSportVenue> createState() => _SearchSportVenueState();
}

class _SearchSportVenueState extends State<SearchSportVenue> {
  final TextEditingController _controller = TextEditingController();
  List<SportVenue> _sportvenues = [];

  // final List<SportVenue> _sportVenues = const [
  //   SportVenue(0, 'Gymnase Albert José', 'Basket', 280,
  //       'gymnase_albert_jose@mail.fr', 'Nord Est Angers'),
  //   SportVenue(1, 'Terrain athlétisme Lac de Maine', 'Athlétisme', 420,
  //       'athletisme_ldm@mail.fr', 'A côté du Lac de Maine'),
  //   SportVenue(2, 'Terrain de boules Gare du Nord', 'Pétanque', 80,
  //       'petanque_gn@mail.fr', 'Derrière la gare')
  // ];

  void _onSearchChanged(String value) {
    final sportVenueRepository = SportVenueRepository();
    sportVenueRepository.fetchSportVenues(value).then((value) {
      setState(() {
        _sportvenues = value;
      });
    });
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
            TextField(
                controller: _controller,
                onEditingComplete: () => _onSearchChanged(_controller.text)),
            Expanded(
              child: ListView.separated(
                itemCount: _sportvenues.length,
                itemBuilder: (context, index) {
                  final sportVenue = _sportvenues[index];
                  return ListTile(
                    leading: const Icon(Icons.place),
                    title: Text(sportVenue.name ?? 'Nom non disponible'),
                    subtitle: Text(
                      'Localisation : ${sportVenue.geoPosition ?? 'Coordonnées non disponibles'}, Nombre de places : ${sportVenue.numberOfPlaces}',
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
