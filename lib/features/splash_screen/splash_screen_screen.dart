import 'dart:convert';

import 'package:cinder/features/authentication/authentication_screen.dart';
import 'package:cinder/features/splash_screen/splash_screen_cubit.dart';
import 'package:cinder/features/splash_screen/splash_screen_state.dart';
import 'package:cinder/ui/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreenScreen extends StatelessWidget {
  const SplashScreenScreen({super.key});

  Future<void> loadImage(String imagePath, BuildContext context) async {
    try {
      final manifestJson = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
      final images = (json.decode(manifestJson).keys.where((String key) => key.startsWith('assets/'))).toList();

      for (String imgPath)

      await precacheImage(AssetImage(imagePath), context);

      context.read<SplashScreenCubit>().checkInternetStatus();
      print('Image loaded and cached successfully!');
    } catch (e) {
      print('Failed to load and cache the image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashScreenCubit(),
      child: BlocConsumer<SplashScreenCubit, SplashScreenState>(
        listener: (context, state) {
          if (state is SplashScreenErrorState) {
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
          if (state is SplashScreenInitialState) {
            loadImage("assets/CinderLogoVoid.png", context);
          } else if (state is SplashScreenLoadingState) {
            return SplashScreenPage();
          } else if (state is SplashScreenDataState) {
            
            return const AuthenticationScreen();
          }
          return const Scaffold();
        },
      ),
    );
  }
}
