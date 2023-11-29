import 'package:cinder/domain/authentication/models/user_model.dart';

class AuthenticationState {}

final class AuthenticationBuildState extends AuthenticationState {}

final class AuthenticationListenState extends AuthenticationState {}

final class AuthenticationInitial extends AuthenticationBuildState {}

final class AuthenticationLoading extends AuthenticationBuildState {}

final class AuthenticationError extends AuthenticationListenState {
  final String error;

  AuthenticationError({required this.error});
}

final class AuthenticationData extends AuthenticationBuildState {
  final UserModel user;

  AuthenticationData({required this.user});
}