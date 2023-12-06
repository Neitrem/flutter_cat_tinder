import 'package:cinder/domain/cats/models/favorite_model.dart';
import 'package:cinder/domain/cats/services/cat_service.dart';
import 'package:cinder/features/cat/favorite/cat_favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatFavoriteCubit extends Cubit<CatFavoriteState> {
  final int userId;
  final BuildContext context;

  List<FavoriteModel> favorites = [];

  CatFavoriteCubit({
    required this.context,
    required this.userId,
  }) : super(CatFavoriteInitial());

  final CatService _service = CatService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> loadFavoirites() async {
    try {
      emit(
        CatFavoriteLoading(),
      );
      favorites = await _service.getFavorites(
        userId: userId,
      );
      emit(
        CatFavoriteData(
          favorites: favorites,
        ),
      );
      loadImages(favorites.map((e) => e.url).toList());
    } catch (e) {
      emit(
        CatFavoriteError(
          error: e.toString(),
          fromFunction: loadFavoirites,
        ),
      );
    }
  }

  Future<void> loadImages(List<String> urls) async {
    try {
      _isLoading = true;
      if (context.mounted) {
        urls.map(
          (url) async => await precacheImage(
            NetworkImage(url),
            context,
          ),
        );
      }
      _isLoading = false;
      print('Images loaded and cached successfully!');
    } catch (e) {
      print('Failed to load and cache images: $e');
    }
  }
}
