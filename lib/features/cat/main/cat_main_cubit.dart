import 'package:cinder/domain/authentication/models/user_model.dart';
import 'package:cinder/domain/cats/models/cat_model.dart';
import 'package:cinder/domain/cats/services/cat_service.dart';
import 'package:cinder/features/cat/main/cat_main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatMainCubit extends Cubit<CatMainState> {
  List<CatModel> cats = [];

  final BuildContext context;
  final UserModel user;
  CatMainCubit({
    required this.context,
    required this.user,
  }) : super(CatMainInitial());

  final List<CatModel> _catBuffer = [];

  final CatService _service = CatService();

  Future<void> preparing() async {
    try {
      emit(
        CatMainLoading(),
      );
      for (int i = 0; i < 5; i++) {
        await loadCatInBuffer();
        popFromBuffer();
      }
      emit(
        CatMainData(
          cats: cats,
        ),
      );
      for (int i = 0; i < 10; i++) {
        loadCatInBuffer();
      }
    } on Exception catch (e) {
      emit(
        CatMainError(
          error: e.toString(),
          fromFunction: preparing,
          namedArguments: {#context: context},
        ),
      );
    }
  }

  void popFromBuffer() {
    cats.insert(0, _catBuffer.removeLast());
  }

  void pop() {
    cats.removeLast();
    popFromBuffer();

    loadCatInBuffer();
  }

  void addToFavorite({required String url}) {
    _service.addToFavorite(
      url: url,
      userId: user.id,
    );
  }

  Future<void> loadCatInBuffer() async {
    try {
      await _service.getCats(amount: 1).then((data) async {
        if (context.mounted) {
          await loadImage(
            data[0].url,
          ).then((_) {
            _catBuffer.insert(0, data[0]);
          });
        }
      });
    } catch (e) {
      emit(
        CatMainError(
          error: e.toString(),
          fromFunction: loadCatInBuffer,
          namedArguments: {#context: context},
        ),
      );
    }
  }

  Future<void> loadImage(String url) async {
    try {
      if (context.mounted) await precacheImage(NetworkImage(url), context);

      print('Image loaded and cached successfully!');
    } catch (e) {
      print('Failed to load and cache the image: $e');
    }
  }

  void toFavorite() {
    emit(
      CatMainRedirect(
        userId: user.id
      ),
    );
  }
}
