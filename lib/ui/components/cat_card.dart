import 'package:cinder/domain/models/cat_model.dart';
import 'package:cinder/ui/components/card_gesture_detector.dart';
import 'package:cinder/ui/provider/card_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatCard extends StatefulWidget {
  const CatCard({
    super.key,
    required this.cat,
    required this.isFront
  });

  final CatModel cat;
  final bool isFront;

  @override
  State<CatCard> createState() => _CatCardState();
}

class _CatCardState extends State<CatCard> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;

      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isFront
    ? CardGestureDetector(child: CardBase(cat: widget.cat,),)
    : CardBase(cat: widget.cat);
  }
}

class CardBase extends StatelessWidget {
  const CardBase({
    super.key,
    required this.cat,
  });

  final CatModel cat;

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Image.network(cat.url).image,
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 450.0,
    );
  }
}