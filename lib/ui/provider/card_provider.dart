import 'package:cinder/domain/cats/models/cat_model.dart';
import 'package:flutter/material.dart';

enum CardStatus { like, dislike, superLike }

class CardProvider extends ChangeNotifier {
  CardProvider({
    required this.cats,
    required this.popCat,
    required this.likeCat,
    required this.context,
  });

  Function() popCat;
  Function({required String url}) likeCat;
  BuildContext context;
  List<CatModel> cats;

  Offset _position = Offset.zero;
  bool _isDragging = true;
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
    _isDragging = false;
    _angle = 20.0;
    _position += Offset(2 * _screenSize.width, 0);

    likeCat(url: cats.last.url);

    _nextCard();

    notifyListeners();
  }

  void dislike() {
    _isDragging = false;
    _angle = -20;
    _position -= Offset(2 * _screenSize.width, 0);
    _nextCard();

    notifyListeners();
  }

  void resetPosition() {
    _isDragging = true;
    _position = Offset.zero;
    _angle = 0.0;

    notifyListeners();
  }

  Future _nextCard() async {
    await Future.delayed(const Duration(milliseconds: 800));
    popCat();
    resetPosition();
  }
}
