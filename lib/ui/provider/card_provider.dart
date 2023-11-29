import 'package:cinder/domain/cats/models/cat_model.dart';
import 'package:flutter/material.dart';

enum CardStatus {like, dislike, superLike}

class CardProvider extends ChangeNotifier {

  CardProvider({
    required this.cats,
    required this.loadMoreCats
  });

  Function() loadMoreCats;
  List<CatModel> cats;
  Offset _position = Offset.zero;
  bool _isDragging = false;
  Size _screenSize = Size.zero;
  double _angle = 0.0;

  bool get isDragging => _isDragging;
  Offset get position => _position;
  double get angle => _angle;

  void setScreenSize(Size screenSize) => _screenSize = screenSize;

  void startPosition(DragStartDetails details) {
    _isDragging = true;

    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;

    final x = position.dx;
    _angle = 45 * x / _screenSize.width;

    notifyListeners();
  }

  void endPosition() {
    _isDragging = false;
    notifyListeners();

    final status = getStatus();

    switch (status) {
      case CardStatus.like:
        like();
      break;
      case CardStatus.dislike:
        dislike();
      break;
      default:
        resetPosition();
    }
  }

  CardStatus? getStatus() {
    final x = position.dx;
    
    const delta = 100.0;

    if (x >= delta) {
      return CardStatus.like;
    } else if (x <= -delta) {
      return CardStatus.dislike;
    } else {
      return null;
    }
  }

  void like() {
    _angle = 20.0;
    _position += Offset(2 * _screenSize.width, 0);
    _nextCard();

    notifyListeners();
  }

  void dislike() {
    _angle = -20;
    _position -= Offset(2 * _screenSize.width, 0);
    _nextCard();

    notifyListeners();
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0.0;

    notifyListeners();
  }

  Future _nextCard() async {
    if (cats.length == 3) {
      loadMoreCats();
    }

    await Future.delayed(const Duration(milliseconds: 700));
    cats.removeLast();
    resetPosition();
  }
}