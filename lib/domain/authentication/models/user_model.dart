import 'package:cinder/data/authentication/models/user_dto.dart';

class UserModel {
  final int id;
  final String login;
  final String password;

  UserModel({
    required this.id,
    required this.login,
    required this.password,
  });

  factory UserModel.fromDTO(UserDTO dto) {
    return UserModel(
      id: dto.id,
      login: dto.login,
      password: dto.password,
    );
  }
}