import 'package:cinder/data/authentication/models/user_dto.dart';
import 'package:cinder/db/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<bool> _isAuthorised() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final isUserExist = prefs.get('user') == null ? false : true;

    return isUserExist;
  }

  Future<UserDTO?> getUser() async {
    final isAuth = await _isAuthorised();

    switch (isAuth) {
      case true:
        return null;
      case false:
        return null;
    }
  }

  Future<DBResponse> login(UserDTO dto) async {
    List<Map<String, dynamic>> maps = await dbHelper.get(
      table: dto.table,
    );

    for (Map<String, dynamic> map in maps) {
      if (map['login'] as String == dto.login) {
        if (map['password'] as String == dto.password) {
          return DBResponse(
            response: Response.success,
            data: UserDTO.fromJson(map),
          );
        } else {
          return DBResponse(
            response: Response.failureWrongPass,
            data: UserDTO.fromJson(map),
          );
        }
      }
    }

    return DBResponse(
      response: Response.failureNoUser,
      data: null,
    );
  }

  Future<DBResponse> register(UserDTO dto) async {
    try {
      if (await dbHelper.userExist(dto)) {
        return DBResponse(
          response: Response.failureUserAlreadyExist,
          data: null,
        );
      } else {
        final int insertResult = await dbHelper.insert(dto);
        return DBResponse(
          response: Response.success,
          data: UserDTO(
            id: insertResult - 1,
            login: dto.login,
            password: dto.password,
          ),
        );
      }
    } catch (e) {
      return DBResponse(
        response: Response.failureServiceError,
        data: null,
      );
    }
  }
}

class DBResponse {
  final Response response;
  final UserDTO? data;

  DBResponse({
    required this.response,
    required this.data,
  });
}

enum Response {
  success,
  failureWrongPass,
  failureNoUser,
  failureServiceError,
  failureUserAlreadyExist
}
