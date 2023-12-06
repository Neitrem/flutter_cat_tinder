import 'package:cinder/db/interfaces/db_model_interface.dart';
import 'package:cinder/domain/authentication/models/user_model.dart';

class UserDTO implements IDBModel {
  final int id;
  final String login;
  final String password;
  @override
  String get table => "users";


  UserDTO ({
    required this.id,
    required this.login,
    required this.password
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json["id"],
      login: json["login"],
      password: json["password"]
    );
  }

  factory UserDTO.fromModel(UserModel model) {
    return UserDTO(
      id: model.id,
      login: model.login,
      password: model.password
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'password': password,
    };
  }
}