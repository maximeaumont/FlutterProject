import 'package:flutter_application/ui/screens/home.dart';
import 'package:flutter_application/ui/screens/my_favorites.dart';
import 'package:flutter_application/ui/screens/search_sport_venue.dart';

class AppRouter {
  static const String homePage = '/home';
  static const String myFavorites = '/my_favorites';
  static const String searchSportVenue = '/search_sport_venue';

  static final routes = {
    homePage: (context) => const Home(),
    searchSportVenue: (context) => const SearchSportVenue(),
    myFavorites: (context) => const MyFavorites(),
  };
}
