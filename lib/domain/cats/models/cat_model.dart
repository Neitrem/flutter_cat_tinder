import 'package:cinder/data/cats/models/cat_dto.dart';

class CatModel {
  final String id;
  final String url;
  final int width;
  final int height;
  final List<dynamic> breeds;

  CatModel({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
    required this.breeds
  });

  factory CatModel.fromDTO(CatDTO dto) {
    return CatModel(
      id: dto.id,
      url: dto.url,
      width: dto.width,
      height: dto.height,
      breeds: dto.breeds
    );
  }
}