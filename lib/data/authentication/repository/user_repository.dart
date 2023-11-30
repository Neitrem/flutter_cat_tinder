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

  Future<DBResponce> login(UserDTO dto) async {
    List<Map<String, dynamic>> maps = await dbHelper.get(dto);
    
    for (Map<String, dynamic> map in maps) {
      if (map['login'] as String == dto.login) {
        if (map['password'] as String == dto.login) {
          return DBResponce(
            response: Responce.success,
            responseDetails: responceDetailsSuccess,
            data: UserDTO.fromJson(map)
          );
            
        } else {
          return DBResponce(
            response: Responce.failure,
            responseDetails: responceDetailsFailureInvalidPassword,
            data: UserDTO.fromJson(map)
          );
        }
      }
    }

    return DBResponce(
      response: Responce.failure,
      responseDetails: responceDetailsFailureNoUser,
      data: null
    );
  }

  Future<String?> register(UserDTO dto) async {
    final s = await dbHelper.insert(dto);
    return s.toString();
  }
}

class DBResponce {
  final Responce response;
  final String responseDetails;
  final dynamic data;

  DBResponce({
    required this.response,
    required this.responseDetails,
    required this.data
  });
}

enum Responce {success, failure}

const String responceDetailsSuccess = "";
const String responceDetailsFailureNoUser = "No user with this login";
const String responceDetailsFailureInvalidPassword = "Invalid password";