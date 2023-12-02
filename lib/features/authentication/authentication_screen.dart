import 'package:cinder/features/authentication/authentication_cubit.dart';
import 'package:cinder/features/authentication/authentication_state.dart';
import 'package:cinder/features/cat/cat_main_screen.dart';
import 'package:cinder/ui/pages/authenticate_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationError) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('error'),
                  content: Text(state.error),
                );
              },
            );
          }
        },
        buildWhen: (previous, current) =>  current is AuthenticationBuildState,
        builder: (context, state) {
          if (state is AuthenticationInitial) {
            print("dsds");
            return AuthenticatePage();
          } else if (state is AuthenticationData) {
            return const CatMain();
          }
          return const Text("data");
        },
      ),
    );
  }
}