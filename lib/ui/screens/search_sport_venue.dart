import 'package:flutter/material.dart';
import 'package:flutter_application/blocs/favorite_bloc.dart';
import 'package:flutter_application/blocs/favorite_event.dart';
import 'package:flutter_application/blocs/favorite_state.dart';
import 'package:flutter_application/models/sport_venue.dart';
import 'package:flutter_application/repositories/sport_venue_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchSportVenue extends StatefulWidget {
  const SearchSportVenue({super.key});

  @override
  _SearchSportVenueState createState() => _SearchSportVenueState();
}

class _SearchSportVenueState extends State<SearchSportVenue>
    with TickerProviderStateMixin {
  final SportVenueRepository _sportVenueRepository = SportVenueRepository();
  List<SportVenue> _sportVenues = [];
  List<String> listOfChoices = [
    'Choisissez un sport',
    'Football',
    'Badminton',
    'Judo',
    'Basket-ball',
    'Tennis',
    'Aviron',
    'Course',
    'Handball',
    'Natation',
    'Boxe',
    'Musculation'
  ];
  String selectedSport = 'Choisissez un sport';
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(LoadFavorites());

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation =
        Tween<double>(begin: 2.0, end: 1.0).animate(_animationController!);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  void _onSearchChanged(String? value) async {
    if (value != null && value != 'Choisissez un sport') {
      _animationController?.forward();
      final venues = await _sportVenueRepository.fetchSportVenues(value);
      setState(() {
        _sportVenues = venues.map((e) => e.toSportVenue()).toList();
      });
    }
  }

  void toggleFavorite(SportVenue venue) {
    final isCurrentlyFavorite = venue.isFavorite;
    final newVenue = SportVenue(
      venue.id,
      venue.name,
      venue.activity,
      venue.numberOfPlaces,
      venue.mail,
      venue.geoPosition,
      venue.coordinates,
      isFavorite: !isCurrentlyFavorite,
    );

    if (isCurrentlyFavorite) {
      context.read<FavoriteBloc>().add(RemoveFavorite(newVenue));
    } else {
      context.read<FavoriteBloc>().add(AddFavorite(newVenue));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lieux sportifs à Angers"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _animation!,
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: DropdownButton<String>(
                value: selectedSport,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20,
                ),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSport = newValue!;
                    _onSearchChanged(selectedSport);
                  });
                },
                items: listOfChoices
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, state) {
                if (state is FavoritesLoaded) {
                  Future.delayed(Duration.zero, () {
                    if (mounted) {
                      _updateSportVenuesWithFavorites(state.favorites);
                    }
                  });
                }
                return ListView.builder(
                  itemCount: _sportVenues.length,
                  itemBuilder: (context, index) {
                    final sportVenue = _sportVenues[index];
                    return _buildSportVenueItem(sportVenue);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _updateSportVenuesWithFavorites(List<SportVenue> favorites) {
    setState(() {
      for (var venue in _sportVenues) {
        venue.isFavorite = favorites.any((fav) => fav.id == venue.id);
      }
    });
  }

  Widget _buildSportVenueItem(SportVenue sportVenue) {
    return FadeTransition(
      opacity: _animation!,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.deepPurple,
            child: Text(sportVenue.name[0]),
          ),
          title: Text(sportVenue.name),
          trailing: IconButton(
            icon: Icon(
              sportVenue.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () => toggleFavorite(sportVenue),
          ),
        ),
      ),
    );
  }
}
