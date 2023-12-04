class SplashScreenState {}

final class SplashScreenBuildState extends SplashScreenState {}

final class SplashScreenListenState extends SplashScreenState {}

final class SplashScreenInitialState extends SplashScreenBuildState {}

final class SplashScreenLoadingState extends SplashScreenBuildState {}

final class SplashScreenErrorState extends SplashScreenListenState {
  final String error;
  final Function fromFunction;

  SplashScreenErrorState({required this.error, required this.fromFunction});
}

final class SplashScreenDataState extends SplashScreenBuildState {
  final String? login;
  final String? password;

  SplashScreenDataState({this.login, this.password});
}


