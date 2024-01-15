import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application/models/sport_venue.dart';

class FavoritesRepository {
  Future<void> saveFavorites(List<SportVenue> favorites) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> listJson = favorites.map((venue) => jsonEncode(venue.toJson())).toList();
    await prefs.setStringList('favorites', listJson);
  }

  Future<List<SportVenue>> loadFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? favoritesJson = prefs.getStringList('favorites');
    if (favoritesJson == null) {
      return [];
    }
    return favoritesJson.map((venueJson) => SportVenue.fromJson(jsonDecode(venueJson) as Map<String, dynamic>)).toList();
  }

  Future<void> clearFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('favorites');
  }
}
