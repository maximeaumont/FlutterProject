import 'package:flutter_application/blocs/favorite_event.dart';
import 'package:flutter_application/blocs/favorite_state.dart';
import 'package:flutter_application/models/sport_venue.dart';
import 'package:flutter_application/repository/favorites_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoritesRepository favoritesRepository;

  FavoriteBloc({required this.favoritesRepository}) : super(FavoritesLoading()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddFavorite>(_onAddFavorite);
    on<RemoveFavorite>(_onRemoveFavorite);
  }

  Future<void> _onLoadFavorites(LoadFavorites event, Emitter<FavoriteState> emit) async {
    try {
      final favorites = await favoritesRepository.loadFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError());
    }
  }

  Future<void> _onAddFavorite(AddFavorite event, Emitter<FavoriteState> emit) async {
    try {
      List<SportVenue> currentFavorites = [];
      if (state is FavoritesLoaded) {
        currentFavorites = List.from((state as FavoritesLoaded).favorites);
      }
      currentFavorites.add(event.venue);
      await favoritesRepository.saveFavorites(currentFavorites);
      emit(FavoritesLoaded(currentFavorites));
    } catch (e) {
      emit(FavoritesError());
    }
  }

  Future<void> _onRemoveFavorite(RemoveFavorite event, Emitter<FavoriteState> emit) async {
    try {
      List<SportVenue> currentFavorites = [];
      if (state is FavoritesLoaded) {
        currentFavorites = List.from((state as FavoritesLoaded).favorites);
      }
      currentFavorites.remove(event.venue);
      await favoritesRepository.saveFavorites(currentFavorites);
      emit(FavoritesLoaded(currentFavorites));
    } catch (e) {
      emit(FavoritesError());
    }
  }

}
