import 'package:cinder/domain/authentication/services/user_services.dart';
import 'package:cinder/features/authentication/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());
  
  final UserService _service = UserService();

  void register(String login, String password) {
    _service.register(login, password);
  }
}