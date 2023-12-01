class SplashScreenState {}

final class SplashScreenBuildState extends SplashScreenState {}

final class SplashScreenListenState extends SplashScreenState {}

final class SplashScreenInitialState extends SplashScreenBuildState {}

final class SplashScreenLoadingState extends SplashScreenBuildState {}

final class SplashScreenErrorState extends SplashScreenListenState {
  final String error;

  SplashScreenErrorState({required this.error});
}

final class SplashScreenDataState extends SplashScreenBuildState {
  Map<String, dynamic>? data;

  SplashScreenDataState({required this.data});
}


