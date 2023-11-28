import 'package:cinder/domain/models/cat_model.dart';

class CatMainState {}

final class CatMainBuildState extends CatMainState {}

final class CatMainListenState extends CatMainState {}

final class CatMainInitial extends CatMainBuildState {}

final class CatMainLoading extends CatMainBuildState {}

final class CatMainError extends CatMainListenState {
  final String error;

  CatMainError({required this.error});
}

final class CatMainData extends CatMainBuildState {
  final List<CatModel> cats;

  CatMainData({required this.cats});
}