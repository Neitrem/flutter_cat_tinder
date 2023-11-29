import 'package:cinder/data/authentication/repository/user_repository.dart';
import 'package:cinder/domain/authentication/models/user_model.dart';

class UserService {
  final UserRepository _repository = UserRepository();

  // Future<UserModel?> login(String login, String password) async {
  //   final userDto = await _repository.login(login, password);

  //   if (userDto == null) {
  //     return null;
  //   }

  //   return UserModel.fromDTO(userDto);
  // }

  void register(String login, String password) async {
    final s = await _repository.register(login, password);
    print(s.toString());
  }
}