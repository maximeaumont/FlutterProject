import 'package:flutter/material.dart';
import 'package:flutter_application/models/sport_venue.dart';
import 'package:flutter_application/repository/favorites_repository.dart';
import 'package:flutter_application/views/sport_venue_map_view.dart';

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
        backgroundColor: Colors.deepPurple,
      ),
      body: _currentIndex == 0 ? _buildListView() : SportVenueMapView(favoriteVenues: favorites),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
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
  return ListView.builder(
    itemCount: favorites.length,
    itemBuilder: (context, index) {
      final sportVenue = favorites[index];
      return Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.deepPurple,
            child: Text(sportVenue.name[0]), 
          ),
          title: Text(sportVenue.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(sportVenue.geoPosition),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _removeFromFavorites(sportVenue),
          ),
        ),
      );
    },
  );
}

void _removeFromFavorites(SportVenue venue) async {
  setState(() {
    favorites.remove(venue);
    venue.isFavorite = false;
  });
  await _favoritesRepository.saveFavorites(favorites);
}

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
