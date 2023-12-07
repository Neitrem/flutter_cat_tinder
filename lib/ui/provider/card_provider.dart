import 'package:cinder/domain/cats/models/cat_model.dart';
import 'package:flutter/material.dart';

enum CardStatus { like, dislike, centre }

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
  CardStatus _status = CardStatus.centre;

  bool get isDragging => _isDragging;
  Offset get position => _position;
  double get angle => _angle;
  CardStatus get status => _status;

  void setScreenSize(Size screenSize) => _screenSize = screenSize;

  void startPosition(DragStartDetails details) {
    _isDragging = true;

    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;

    final x = position.dx;
    _angle = 45 * x / _screenSize.width;
    getStatus();
    notifyListeners();
  }

  void endPosition() {
    _isDragging = false;
    notifyListeners();
    switch (_status) {
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

  void getStatus() {
    final x = position.dx;

    const delta = 100.0;

    if (x >= delta) {
      _status = CardStatus.like;
    } else if (x <= -delta) {
      _status = CardStatus.dislike;
    } else {
      _status = CardStatus.centre;
    }
  }

  void like() {
    _isDragging = false;
    _angle = 20.0;
    _position += Offset(2 * _screenSize.width, 0);
    _status = CardStatus.like;
    likeCat(url: cats.last.url);

    _nextCard();

    notifyListeners();
  }

  void dislike() {
    _isDragging = false;
    _angle = -20;
    _position -= Offset(2 * _screenSize.width, 0);
    _status = CardStatus.dislike;

    _nextCard();

    notifyListeners();
  }

  void resetPosition() {
    _isDragging = true;
    _position = Offset.zero;
    _angle = 0.0;
    _status = CardStatus.centre;

    notifyListeners();
  }

  Future _nextCard() async {
    await Future.delayed(const Duration(milliseconds: 800));
    popCat();
    resetPosition();
  }
}
