import 'package:cinder/domain/models/cat_model.dart';
import 'package:cinder/domain/services/cat_service.dart';
import 'package:cinder/features/cat/cat_main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatCubit extends Cubit<CatMainState> {
  List<CatModel> cats = [];
  CatCubit() : super(CatMainInitial());

  final CatService _service = CatService();

  Future<void> getCats() async {
    try {
      emit(CatMainLoading());
      cats = await _service.getCats();
      emit(
        CatMainData(cats: cats),
      );
    } catch (e) {
      emit(
        CatMainError(
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> loadMoreCats() async {
    try {
      
      final newCats = await _service.getCats(amount: 3);
      for (CatModel newCat in newCats) {
        cats.insert(0, newCat);
      }
      emit(
        CatMainData(cats: cats)
      );
    } catch (e) {
      emit(
        CatMainError(
          error: e.toString(),
        )
      );
    }
  }

  void popCat() {
    cats.removeAt(cats.length);
  }
}
