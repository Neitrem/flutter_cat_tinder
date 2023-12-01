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

  void register(String login, String password) {
    // _service.register(
    //   UserModel(id: 0, login: login, password: password),
    // );
  }

  void login(String login, String password) {
    // _service.register(
    //   UserModel(id: 0, login: login, password: password),
    // );
  }

  void changePage(PageType pageType) {
    currentPage = pageType;
    emit(
      AuthenticationData(
        user: UserModel(id: 0, login: "", password: ""),
      ),
    );
  }

  // Debug only
  void setData() {
    emit(
      AuthenticationData(
        user: UserModel(id: 0, login: "", password: ""),
      ),
    );
  }
}
