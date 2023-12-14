import 'package:cinder/features/authentication/authentication_screen.dart';
import 'package:cinder/features/splash_screen/splash_screen_cubit.dart';
import 'package:cinder/features/splash_screen/splash_screen_state.dart';
import 'package:cinder/ui/pages/error_page.dart';
import 'package:cinder/ui/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreenScreen extends StatelessWidget {
  const SplashScreenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SplashScreenCubit(
          context: context,
        )..load(),
        child: BlocConsumer<SplashScreenCubit, SplashScreenState>(
          listener: (context, state) {
            if (state is SplashScreenRedirectState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AuthenticationScreen(
                    login: state.login,
                    password: state.password,
                  ),
                ),
              );
            }
          },
          buildWhen: (previous, current) => current is SplashScreenBuildState,
          builder: (context, state) {
            if (state is SplashScreenLoadingState) {
              return SplashScreenPage();
            } else if (state is SplashScreenErrorState) {
              return ErrorPage(
                fromFunction: state.fromFunction,
                errorText: state.error,
              );
            }
            return const Placeholder(
              color: Colors.transparent,
            );
          },
        ),
      ),
    );
  }
}
