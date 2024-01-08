import 'package:flutter_application/models/sport_venue.dart';

abstract class FavoriteState {}

class FavoritesLoading extends FavoriteState {}

class FavoritesLoaded extends FavoriteState {
  final List<SportVenue> favorites;

  FavoritesLoaded(this.favorites);
}

class FavoritesError extends FavoriteState {}
