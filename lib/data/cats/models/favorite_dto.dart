import 'package:cinder/db/interfaces/db_model_interface.dart';
import 'package:cinder/domain/cats/models/favorite_model.dart';

class FavoriteDTO implements IDBModel {
  final String url;
  final int userId;

  FavoriteDTO({
    required this.url,
    required this.userId,
  });

  @override
  String get table => "favorite";

  @override
  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'user_id': userId,
    };
  }

  factory FavoriteDTO.fromModel(FavoriteModel model) {
    return FavoriteDTO(
      url: model.url,
      userId: model.userId,
    );
  }

  factory FavoriteDTO.fromDB(Map<String, dynamic> map) {
    return FavoriteDTO(
      url: map["url"],
      userId: map["user_id"],
    );
  }
}
