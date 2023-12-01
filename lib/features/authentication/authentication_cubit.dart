import 'package:cinder/data/authentication/repository/user_repository.dart';
import 'package:cinder/domain/authentication/models/user_model.dart';
import 'package:cinder/domain/authentication/services/user_services.dart';
import 'package:cinder/features/authentication/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum PageType { login, register }

class AuthenticationCubit extends Cubit<AuthenticationState> {
  PageType currentPage;
  AuthenticationCubit({this.currentPage = PageType.login})
      : super(AuthenticationInitial(login: '', password: ''));

  final UserService _service = UserService();

  Future<void> register(String login, String password) async {
    final ServiceResponse response = await _service.register(
      UserModel(id: 0, login: login, password: password),
    );
    responseAnalis(response);
  }

  Future<void> login(String login, String password) async {
    final ServiceResponse response = await _service.login(
      UserModel(id: 0, login: login, password: password),
    );
    responseAnalis(response);
  }

  void responseAnalis(ServiceResponse response) {
    switch (response.response) {
      case Response.success:
        emit(
          AuthenticationData(user: response.data!),
        );
      break;
      case Response.failure:
    }
  }

  void changePage(PageType pageType) {
    currentPage = pageType;
    emit(
      AuthenticationInitial(login: "", password: "")
    );
  }
}
