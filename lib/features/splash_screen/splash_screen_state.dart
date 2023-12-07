class SplashScreenState {}

final class SplashScreenBuildState extends SplashScreenState {}

final class SplashScreenListenState extends SplashScreenState {}

final class SplashScreenInitialState extends SplashScreenBuildState {}

final class SplashScreenLoadingState extends SplashScreenBuildState {}

final class SplashScreenErrorState extends SplashScreenBuildState {
  final String error;
  final Function fromFunction;

  SplashScreenErrorState({required this.error, required this.fromFunction});
}

final class SplashScreenRedirectState extends SplashScreenListenState {
  final String? login;
  final String? password;

  SplashScreenRedirectState({this.login, this.password});
}


