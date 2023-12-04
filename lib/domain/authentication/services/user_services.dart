import 'package:cinder/data/authentication/models/user_dto.dart';
import 'package:cinder/data/authentication/repository/user_repository.dart';
import 'package:cinder/domain/authentication/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final UserRepository _repository = UserRepository();

  Future<ServiceResponse> login(UserModel model) async {
    final DBResponse response = await _repository.login(
      UserDTO.fromModel(model),
    );
    return ServiceResponse.fromDBResponce(response);
  }

  Future<ServiceResponse> register(UserModel model) async {
    final DBResponse response = await _repository.register(
      UserDTO.fromModel(model),
    );
    return ServiceResponse.fromDBResponce(response);
  }

  Future<void> saveLoginData(String login, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('login', login);
      await prefs.setString('password', password);
    } catch (e) {
      print(e);
    }
  }
}

class ServiceResponse {
  final Response response;
  final UserModel? data;

  ServiceResponse({
    required this.response,
    required this.data,
  });

  factory ServiceResponse.fromDBResponce(DBResponse response) {
    return ServiceResponse(
      response: response.response,
      data: response.data == null ? null : UserModel.fromDTO(response.data!),
    );
  }
}
