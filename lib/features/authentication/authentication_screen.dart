import 'package:cinder/features/authentication/authentication_cubit.dart';
import 'package:cinder/features/authentication/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AunthenticationScreen extends StatelessWidget {
  const AunthenticationScreen({super.key});

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
        builder: (context, state) {
          if (state is AuthenticationInitial) {
            context.read<AuthenticationCubit>().register("login", "password");
          }
          return const Text("data");
        },
      ),
    );
  }
}