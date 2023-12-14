import 'package:cinder/features/authentication/authentication_cubit.dart';
import 'package:cinder/features/authentication/authentication_state.dart';
import 'package:cinder/features/cat/main/cat_main_screen.dart';
import 'package:cinder/ui/components/loading_animation.dart';
import 'package:cinder/ui/pages/authenticate_page.dart';
import 'package:cinder/ui/pages/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationScreen extends StatelessWidget {
  final String? login;
  final String? password;

  const AuthenticationScreen({
    super.key,
    this.login,
    this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthenticationCubit(
          dataLogin: login,
          dataPassword: password,
        ),
        child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationRedirect) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CatMainScreen(
                    user: state.user,
                  ),
                ),
              );
            }
          },
          buildWhen: (previous, current) => current is AuthenticationBuildState,
          builder: (context, state) {
            if (state is AuthenticationInitial) {
              return AuthenticatePage();
            } else if (state is AuthenticationLoading) {
              return Stack(
                children: <Widget>[
                  AuthenticatePage(),
                  const LoadingAnimation(),
                ],
              );
            } else if (state is AuthenticationError) {
              return ErrorPage(
                fromFunction: state.fromFunction,
                errorText: state.error,
                namedArguments: state.namedArguments,
              );
            }
            return const Text("data");
          },
        ),
      ),
    );
  }
}
