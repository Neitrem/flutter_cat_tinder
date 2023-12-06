import 'package:cinder/data/cats/models/favorite_dto.dart';
import 'package:cinder/data/cats/repository/cat_repository.dart';
import 'package:cinder/domain/cats/models/cat_model.dart';
import 'package:cinder/domain/cats/models/favorite_model.dart';

class CatService {
  final _repository = CatRepository();

  Future<List<CatModel>> getCats({int amount = 5}) async {
    final catData = await _repository.getCats(amount: amount);
    if (catData == null) return [];
    return catData.map((e) => CatModel.fromDTO(e)).toList();
  }

  Future<void> addToFavorite({required String url, required int userId}) async {
    await _repository.addFavorite(
      FavoriteDTO.fromModel(
        FavoriteModel(
          url: url,
          userId: userId,
        ),
      ),
    );
  }

  Future<List<FavoriteModel>> getFavorites({required int userId}) async {
    return (await _repository.getFavorites(userId: userId))
        .map((dto) => FavoriteModel.fromDTO(dto))
        .toList();
  }
}
