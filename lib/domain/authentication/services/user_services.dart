import 'package:cinder/data/authentication/models/user_dto.dart';
import 'package:cinder/data/authentication/repository/user_repository.dart';
import 'package:cinder/domain/authentication/models/user_model.dart';

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
}

class ServiceResponse {
  final Response response;
  final String responseDetails;
  final UserModel? data;

  ServiceResponse({
    required this.response,
    required this.responseDetails,
    required this.data,
  });

  factory ServiceResponse.fromDBResponce(DBResponse response) {
    return ServiceResponse(
      response: response.response,
      responseDetails: response.responseDetails,
      data: UserModel.fromDTO(response.data!),
    );
  }
}
