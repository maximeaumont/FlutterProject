import 'package:flutter/material.dart';
import 'package:flutter_application/models/sport_venue.dart';
import 'package:flutter_application/repository/favorites_repository.dart';
import 'package:latlong2/latlong.dart';

class SearchSportVenue extends StatefulWidget {
  const SearchSportVenue({super.key});

  @override
  _SearchSportVenueState createState() => _SearchSportVenueState();
}

class _SearchSportVenueState extends State<SearchSportVenue> {
  final FavoritesRepository _favoritesRepository = FavoritesRepository();
  final List<SportVenue> _sportVenues = [
    SportVenue(1, 'Gymnase Albert José', 'Basket', 280, 'gymnase_albert_jose@mail.fr', 'Nord Est Angers', LatLng(47.478419, -0.563166)),
    SportVenue(2, 'Terrain athlétisme Lac de Maine', 'Athlétisme', 420, 'athletisme_ldm@mail.fr', 'A côté du Lac de Maine', LatLng(47.459839, -0.588140)),
    SportVenue(3, 'Terrain de boules Gare du Nord', 'Pétanque', 80, 'petanque_gn@mail.fr', 'Derrière la gare', LatLng(47.464478, -0.554486)),
  ];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favorites = await _favoritesRepository.loadFavorites();
    setState(() {
      for (var venue in _sportVenues) {
        venue.isFavorite = favorites.any((fav) => fav.id == venue.id);
      }
    });
  }

  void toggleFavorite(SportVenue venue) async {
    setState(() {
      venue.isFavorite = !venue.isFavorite;
    });
    await _favoritesRepository.saveFavorites(_sportVenues.where((v) => v.isFavorite).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lieux sportifs à Angers"),
      ),
      body: Container(
        color: const Color.fromARGB(255, 173, 14, 41),
        child: ListView.builder(
          itemCount: _sportVenues.length,
          itemBuilder: (context, index) {
            final sportVenue = _sportVenues[index];
            return ListTile(
              leading: const Icon(Icons.place),
              title: Text(sportVenue.name),
              subtitle: Text('Localisation : ${sportVenue.geoPosition}, Nombre de places : ${sportVenue.numberOfPlaces}'),
              trailing: IconButton(
                icon: Icon(sportVenue.isFavorite ? Icons.favorite : Icons.favorite_border),
                color: Colors.red,
                onPressed: () => toggleFavorite(sportVenue),
              ),
            );
          },
        ),
      ),
    );
  }
}
