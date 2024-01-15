import 'package:flutter_application/models/sport_venue.dart';

abstract class FavoriteEvent {}

class LoadFavorites extends FavoriteEvent {}

class AddFavorite extends FavoriteEvent {
  final SportVenue venue;

  AddFavorite(this.venue);
}

class RemoveFavorite extends FavoriteEvent {
  final SportVenue venue;

  RemoveFavorite(this.venue);
}
