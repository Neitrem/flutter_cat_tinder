import 'dart:convert';

import 'package:cinder/domain/splash/services/splash_service.dart';
import 'package:cinder/features/splash_screen/splash_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenInitialState());

  int counter = 0;

  final SplashService _service = SplashService();

  Future<void> load() async {
    emit(
      SplashScreenLoadingState(),
    );
    await checkInternet();
  }

  Future<void> checkSavedData() async {
    try {
      final Map<String, dynamic>? savedData = await _service.getSavedData();
      await Future.delayed(
        const Duration(seconds: 4),
      );
      emit(
        SplashScreenDataState(
          login: savedData != null ? savedData["login"] : null,
          password: savedData != null ? savedData["password"] : null,
        ),
      );
    } catch (e) {
      emit(
        SplashScreenErrorState(
          error: "Something exactly wrong in saved data!",
          fromFunction: checkSavedData,
        ),
      );
    }
  }

  Future<void> checkInternet() async {
    try {

      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        print('YAY! Free cute dog pics!');
        await checkSavedData();
      } else {
        emit(
          SplashScreenErrorState(
            error: "No internet :(",
            fromFunction: checkInternet,
          ),
        );
      }
    } on Exception catch (e) {
      emit(
          SplashScreenErrorState(
            error: e.toString(),
            fromFunction: checkInternet,
          ),
        );
    }
  }

  Future<Map<String, dynamic>?> getSavedData() async {
    return await _service.getSavedData();
  }


  Future<void> loadImage(BuildContext context) async {
    try {
      final manifestJson =
          await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
      final images = (json
          .decode(manifestJson)
          .keys
          .where((String key) => key.startsWith('assets/'))).toList();

      for (String imgPath in images) {
        await precacheImage(AssetImage(imgPath), context);
      }

      await load();
      print('Image loaded and cached successfully!');
    } catch (e) {
      print('Failed to load and cache the image: $e');
    }
  }
}
