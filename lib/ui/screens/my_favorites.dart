import 'package:flutter/material.dart';
import 'package:flutter_application/blocs/favorite_bloc.dart';
import 'package:flutter_application/blocs/favorite_event.dart';
import 'package:flutter_application/blocs/favorite_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/models/sport_venue.dart';
import 'package:flutter_application/views/sport_venue_map_view.dart';

class MyFavorites extends StatefulWidget {
  const MyFavorites({super.key});

  @override
  _MyFavoritesState createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(LoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? "Mes favoris" : "Carte des favoris"),
        backgroundColor: Colors.deepPurple,
      ),
      body: _currentIndex == 0 
        ? BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state is FavoritesLoaded) {
                return _buildListView(state.favorites);
              } else if (state is FavoritesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(child: Text('Erreur de chargement'));
              }
            },
          )
        : BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state is FavoritesLoaded) {
                return SportVenueMapView(favoriteVenues: state.favorites);
              } else {
                return const Center(child: Text('Erreur de chargement'));
              }
            },
          ),
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

  Widget _buildListView(List<SportVenue> favorites) {
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
              onPressed: () {
                context.read<FavoriteBloc>().add(RemoveFavorite(sportVenue));
              },
            ),
          ),
        );
      },
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
