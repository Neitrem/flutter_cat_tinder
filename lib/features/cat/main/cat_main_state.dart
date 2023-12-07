import 'package:cinder/domain/cats/models/cat_model.dart';

class CatMainState {}

final class CatMainBuildState extends CatMainState {}

final class CatMainListenState extends CatMainState {}

final class CatMainInitial extends CatMainBuildState {}

final class CatMainLoading extends CatMainBuildState {}

final class CatMainError extends CatMainBuildState {
  final String error;
  final Function fromFunction;
  Map<Symbol, dynamic>? namedArguments;

  CatMainError({
    required this.error,
    required this.fromFunction,
    this.namedArguments,
  });
}

final class CatMainRedirect extends CatMainListenState {
  final int userId;

  CatMainRedirect({
    required this.userId,
  });
}

final class CatMainData extends CatMainBuildState {
  final List<CatModel> cats;

  CatMainData({required this.cats});
}
