import 'package:cinder/data/authentication/models/user_dto.dart';

class UserModel {
  final int id;
  final String login;
  final String password;
  final List<String> favorites;

  UserModel({
    required this.id,
    required this.login,
    required this.password,
    required this.favorites
  });

  factory UserModel.fromDTO(UserDTO dto) {
    return UserModel(
      id: dto.id,
      login: dto.login,
      password: dto.password,
      favorites: dto.favorites
    );
  }
}