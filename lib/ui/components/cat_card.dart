import 'package:cinder/domain/cats/models/cat_model.dart';
import 'package:cinder/ui/components/card_gesture_detector.dart';
import 'package:cinder/ui/pages/card_detail_page.dart';
import 'package:cinder/ui/provider/card_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatCard extends StatefulWidget {
  const CatCard({super.key, required this.cat, required this.isFront});

  final CatModel cat;
  final bool isFront;

  @override
  State<CatCard> createState() => _CatCardState();
}

class _CatCardState extends State<CatCard> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final size = MediaQuery.of(context).size;

        final provider = Provider.of<CardProvider>(context, listen: false);
        provider.setScreenSize(size);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.isFront
        ? FrontCard(
            cat: widget.cat,
          )
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

class FrontCard extends StatelessWidget {
  final CatModel cat;
  const FrontCard({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return CardGestureDetector(
      onTap: _openDetail,
      child: Hero(
        tag: "front-card",
        child: Stack(
          children: <Widget>[
            CardBase(
              cat: cat,
            ),
            const StatusWidget(),
          ],
        ),
      ),
    );
  }

  _openDetail(context) {
    final route = MaterialPageRoute(
      builder: (context) => CardDetailPage(
        cat: cat,
      ),
    );
    Navigator.push(context, route);
  }
}

class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      final provider = Provider.of<CardProvider>(context);
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 450.0,
        child: Center(
          child: Icon(
            switch (provider.status) {
              CardStatus.like => Icons.favorite,
              CardStatus.dislike => Icons.close,
              CardStatus.centre => null,
            },
            size: 180,
            color: Colors.white,
          ),
        ),
      );
    } catch (e) {
      return const Placeholder(
        color: Colors.transparent,
      );
    }
  }
}
