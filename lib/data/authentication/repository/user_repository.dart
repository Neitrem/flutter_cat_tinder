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
    List<Map<String, dynamic>> maps = await dbHelper.get(dto);

    for (Map<String, dynamic> map in maps) {
      if (map['login'] as String == dto.login) {
        if (map['password'] as String == dto.login) {
          return DBResponse(
              response: Response.success,
              responseDetails: responceDetailsSuccess,
              data: UserDTO.fromJson(map));
        } else {
          return DBResponse(
              response: Response.failure,
              responseDetails: responceDetailsFailureInvalidPassword,
              data: UserDTO.fromJson(map));
        }
      }
    }

    return DBResponse(
        response: Response.failure,
        responseDetails: responceDetailsFailureNoUser,
        data: null);
  }

  Future<DBResponse> register(UserDTO dto) async {
    try {
      final int insertResult = await dbHelper.insert(dto);
      return DBResponse(
        response: Response.success,
        responseDetails: responceDetailsSuccess,
        data: UserDTO(
          id: insertResult - 1,
          login: dto.login,
          password: dto.password,
        ),
      );
    } catch (e) {
      print(e);
      return DBResponse(
        response: Response.failure,
        responseDetails: responceDetailsFailureErrorDuringRegister,
        data: null,
      );
    }
  }
}

class DBResponse {
  final Response response;
  final String responseDetails;
  final UserDTO? data;

  DBResponse(
      {required this.response,
      required this.responseDetails,
      required this.data});
}

enum Response { success, failure }

const String responceDetailsSuccess = "";
const String responceDetailsFailureNoUser = "No user with this login";
const String responceDetailsFailureInvalidPassword = "Invalid password";
const String responceDetailsFailureErrorDuringRegister = "Somrthing goes wrong";
