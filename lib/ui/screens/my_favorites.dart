import 'package:flutter/material.dart';
import 'package:flutter_application/models/sport_venue.dart';
import 'package:flutter_application/repository/favorites_repository.dart';
import 'package:flutter_application/views/sport_venue_map_view.dart'; // Assurez-vous que le chemin est correct

class MyFavorites extends StatefulWidget {
  const MyFavorites({super.key});

  @override
  _MyFavoritesState createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  final FavoritesRepository _favoritesRepository = FavoritesRepository();
  List<SportVenue> favorites = [];
  int _currentIndex = 0; 

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
        title: Text(_currentIndex == 0 ? "Mes favoris" : "Carte des favoris"),
      ),
      body: _currentIndex == 0 ? _buildListView() : SportVenueMapView(favoriteVenues: favorites),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Liste',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Carte',
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return Container(
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
              : Container(); 
        },
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
