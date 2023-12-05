import 'package:cinder/data/authentication/repository/user_repository.dart';
import 'package:cinder/domain/authentication/models/user_model.dart';
import 'package:cinder/domain/authentication/services/user_services.dart';
import 'package:cinder/features/authentication/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum PageType { login, register }

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final String? dataLogin;
  final String? dataPassword;

  PageType currentPage;
  String? error;
  late AuthPageData pageData;

  int counter = 0;

  AuthenticationCubit({
    this.currentPage = PageType.login,
    this.dataLogin,
    this.dataPassword,
  }) : super(
          AuthenticationInitial(login: dataPassword, password: dataPassword),
        ) {
    pageData = AuthPageData(
      currentPage: PageType.login,
      mainButtonAction: loginUser,
      mainButtonText: "Enter",
      serviceButtonText: ["New user?", "Sign Up!"],
    );
    if (dataLogin != null && dataPassword != null) {
      loginUser(login: dataLogin!, password: dataPassword!);
    }
  }

  final UserService _service = UserService();

  Future<void> registerUser({required String login, required String password}) async {
    try {
      emit(
        AuthenticationLoading(),
      );
      FocusManager.instance.primaryFocus?.unfocus();
      final ServiceResponse response = await _service.register(
        UserModel(id: 0, login: login, password: password),
      );
      responseAnalis(response);
    } on Exception catch (e) {
      emit(
        AuthenticationError(
          error: e.toString(),
          fromFunction: registerUser,
          namedArguments: {#login: login, #password: password},
        ),
      );
    }
  }

  Future<void> loginUser({required String login, required String password}) async {
    try {
      emit(
        AuthenticationLoading(),
      );
      FocusManager.instance.primaryFocus?.unfocus();
      final ServiceResponse response = await _service.login(
        UserModel(id: 0, login: login, password: password),
      );
      responseAnalis(response);
    } on Exception catch (e) {
      emit(
        AuthenticationError(
          error: e.toString(),
          fromFunction: loginUser,
          namedArguments: {#login: login, #password: password},
        ),
      );
    }
  }

  void responseAnalis(ServiceResponse response) {
    switch (response.response) {
      case Response.success:
        _service.saveLoginData(response.data!.login, response.data!.password);
        emit(
          AuthenticationData(user: response.data!),
        );
        break;
      case Response.failureNoUser:
        error = "No user with this login!";
        emit(
          AuthenticationInitial(),
        );
        break;
      case Response.failureWrongPass:
        error = "Wrong password!";
        emit(
          AuthenticationInitial(),
        );
        break;
      case Response.failureUserAlreadyExist:
        error = "User with this login already exist!";
        emit(
          AuthenticationInitial(),
        ); 
        break;
      case Response.failureServiceError:
        error = "Something wrong with server try later!";
        emit(
          AuthenticationInitial(),
        );
    }
  }

  void changePage() {
    error = null;
    if (pageData.currentPage == PageType.login) {
      pageData.currentPage = PageType.register;
      pageData.mainButtonAction = registerUser;
      pageData.mainButtonText = "Register";
      pageData.serviceButtonText = ["Already have account?", "Log in!"];
    } else {
      pageData.currentPage = PageType.login;
      pageData.mainButtonAction = loginUser;
      pageData.mainButtonText = "Enter";
      pageData.serviceButtonText = ["New user?", "Sign Up!"];
    }
    FocusManager.instance.primaryFocus?.unfocus();
    emit(AuthenticationInitial());
  }
}

enum ErrorType { noUser, wrongPass }

class AuthPageData {
  PageType currentPage;
  Function({required String login, required String password}) mainButtonAction;
  String mainButtonText;
  List<String> serviceButtonText;

  AuthPageData({
    required this.currentPage,
    required this.mainButtonAction,
    required this.mainButtonText,
    required this.serviceButtonText,
  });
}
