import 'package:cinder/domain/splash/services/splash_service.dart';
import 'package:cinder/features/splash_screen/splash_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenInitialState());

  final SplashService _service = SplashService();



  Future<void> checkInternetStatus() async {
    try {
      emit(
        SplashScreenLoadingState(),
      );
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        print('YAY! Free cute dog pics!');
        await Future.delayed(const Duration(seconds: 4));
        final Map<String, dynamic>? savedData = await getSavedData();
        emit(
          SplashScreenDataState(
            data: savedData,
          ),
        );
      } else {
        print('No internet :(');
      }
    } catch (e) {
      emit(
        SplashScreenErrorState(
          error: e.toString(),
        ),
      );
    }
  }

  Future<Map<String, dynamic>?> getSavedData() async {
    return await _service.getSavedData();
  }
}
