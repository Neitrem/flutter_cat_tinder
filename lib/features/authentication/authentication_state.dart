import 'package:cinder/domain/authentication/models/user_model.dart';

class AuthenticationState {}

final class AuthenticationBuildState extends AuthenticationState {}

final class AuthenticationListenState extends AuthenticationState {}

final class AuthenticationInitial extends AuthenticationBuildState {
  final String? login;
  final String? password;
  bool error;

  AuthenticationInitial({
    this.login,
    this.password,
    this.error = false,
  });
}

final class AuthenticationLoading extends AuthenticationBuildState {}

final class AuthenticationError extends AuthenticationBuildState {
  final String error;
  final Function fromFunction;
  final Map<Symbol, dynamic>? namedArguments;

  AuthenticationError({
    required this.error,
    required this.fromFunction,
    this.namedArguments,
  });
}

final class AuthenticationRedirect extends AuthenticationListenState {
  final UserModel user;

  AuthenticationRedirect({required this.user});
}
