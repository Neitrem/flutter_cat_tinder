import 'package:cinder/domain/cats/models/favorite_model.dart';
import 'package:flutter/material.dart';

class CatFavoritePage extends StatelessWidget {
  final List<FavoriteModel> favorites;

  const CatFavoritePage({
    super.key,
    required this.favorites,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
