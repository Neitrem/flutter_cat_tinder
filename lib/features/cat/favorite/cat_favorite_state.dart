import 'package:cinder/domain/cats/models/favorite_model.dart';

class CatFavoriteState {}

final class CatFavoriteBuildState extends CatFavoriteState {}

final class CatFavoriteListenState extends CatFavoriteState {}

final class CatFavoriteInitial extends CatFavoriteBuildState {}

final class CatFavoriteLoading extends CatFavoriteBuildState {}

final class CatFavoriteError extends CatFavoriteListenState {
  final String error;
  final Function fromFunction;
  Map<Symbol, dynamic>? namedArguments;

  CatFavoriteError({
    required this.error,
    required this.fromFunction,
    this.namedArguments,
  });
}

final class CatFavoriteData extends CatFavoriteBuildState {
  final List<FavoriteModel> favorites;

  CatFavoriteData({required this.favorites});
}