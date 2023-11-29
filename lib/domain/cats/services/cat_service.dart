import 'package:cinder/data/cats/repository/cat_repository.dart';
import 'package:cinder/domain/cats/models/cat_model.dart';

class CatService {
  final _repository = CatRepository();

  Future<List<CatModel>> getCats({int amount = 5}) async {
    final catData = await _repository.getCats(amount: amount);
    if (catData == null) return [];
    return catData.map((e) => CatModel.fromDTO(e)).toList();
  }
}