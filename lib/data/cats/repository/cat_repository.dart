import 'package:cinder/config/env.dart';
import 'package:cinder/data/cats/models/cat_dto.dart';
import 'package:cinder/data/cats/models/favorite_dto.dart';
import 'package:cinder/db/database_helper.dart';
import 'package:dio/dio.dart';

class CatRepository {
  // ignore: constant_identifier_names
  static const _BASE_URL = 'https://api.thecatapi.com/v1/images';

  final dbHelper = DatabaseHelper.instance;

  final AppEnv env = appEnv;

  final Dio _dio = Dio(
    BaseOptions(baseUrl: _BASE_URL),
  );

  Future<List<CatDTO>?> getCats({int amount = 5}) async {
    final response = await _dio.get(
      '/search',
      options: Options(
        headers: {
          "x-api-key": env.catApiKey,
        },
      ),
      queryParameters: {'has_breeds': 1, 'limit': amount, 'order': "RANDOM"},
    );
    final data = response.data as List<dynamic>;

    final first = data.isNotEmpty ? data.first : null;

    if (first == null) {
      return null;
    }

    if (first is Map<String, dynamic>) {
      return (data.cast<Map<String, dynamic>>())
          .map((e) => CatDTO.fromJson(e))
          .toList();
    }

    return null;
  }

  Future<void> addFavorite(FavoriteDTO dto) async {
    try {
      if (!await dbHelper.isAlreadyInFavorite(dto)) {
        await dbHelper.insert(dto);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<FavoriteDTO>> getFavorites({required int userId}) async {
    final List<Map<String, dynamic>> urls = await dbHelper.get(
      table: "favorite",
    );

    List<FavoriteDTO> list = [];

    for (Map<String, dynamic> map in urls) {
      if (map["user_id"] == userId) {
        list.add(
          FavoriteDTO.fromDB(map),
        );
      }
    }
    print(list);
    print(list.reversed);
    return list.reversed.toList();
  }
}
