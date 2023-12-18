import 'package:flutter/material.dart';
import 'package:flutter_application/models/sport_venue.dart';
import 'package:flutter_application/repository/favorites_repository.dart';

class MyFavorites extends StatefulWidget {
  const MyFavorites({super.key});

  @override
  _MyFavoritesState createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  final FavoritesRepository _favoritesRepository = FavoritesRepository();
  List<SportVenue> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final loadedFavorites = await _favoritesRepository.loadFavorites();
    setState(() {
      favorites = loadedFavorites;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes favoris"),
      ),
      body: Container(
        color: const Color.fromARGB(255, 255, 191, 72),
        child: ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final sportVenue = favorites[index];
            return sportVenue.isFavorite
                ? ListTile(
                    title: Text(sportVenue.name),
                    subtitle: Text(sportVenue.geoPosition),
                  )
                : Container(); // Ne rien afficher si ce n'est pas un favori
          },
        ),
      ),
    );
  }
}
