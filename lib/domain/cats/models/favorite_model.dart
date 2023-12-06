import 'package:cinder/data/cats/models/favorite_dto.dart';

class FavoriteModel {
  final String url;
  final int userId;

  FavoriteModel({
    required this.url,
    required this.userId,
  });

  factory FavoriteModel.fromDTO(FavoriteDTO dto) {
    return FavoriteModel(
      url: dto.url,
      userId: dto.userId,
    );
  }
}
