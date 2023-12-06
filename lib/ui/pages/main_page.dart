import 'package:cinder/domain/cats/models/cat_model.dart';
import 'package:cinder/features/cat/main/cat_main_cubit.dart';
import 'package:cinder/ui/components/cat_card.dart';
import 'package:cinder/ui/components/logo.dart';
import 'package:cinder/ui/provider/card_provider.dart';
import 'package:cinder/ui/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.cats});
  final List<CatModel>? cats;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const LogoText(),
        // leading: IconButton(
        //   onPressed: () => {},
        //   icon: const Icon(Icons.settings),
        // ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Center(
              child: buildCards(),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleWrappedGradientIconButton(
                  size: 120,
                  gradient: dislikeColorGragient,
                  icon: Icons.close,
                  toDo: () {
                    final provider = Provider.of<CardProvider>(
                      context,
                      listen: false,
                    );
                    if (provider.isDragging) {
                      provider.dislike();
                    } else {
                      () {};
                    }
                  },
                ),
                CircleWrappedGradientIconButton(
                  size: 70,
                  gradient: favoriteColorGragient,
                  icon: Icons.star,
                  toDo: context.read<CatMainCubit>().toFavorite,
                ),
                CircleWrappedGradientIconButton(
                  size: 120,
                  gradient: likeColorGragient,
                  icon: Icons.favorite,
                  toDo: () {
                    final provider = Provider.of<CardProvider>(
                      context,
                      listen: false,
                    );
                    if (provider.isDragging) {
                      provider.like();
                    } else {
                      () {};
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCards() {
    final provider = Provider.of<CardProvider>(context);
    final cats = provider.cats;

    return Stack(
      children: cats
          .map(
            (cat) => CatCard(
              cat: cat,
              isFront: cats.last == cat,
            ),
          )
          .toList(),
    );
  }
}

class CircleWrappedGradientIconButton extends StatelessWidget {
  final double size;
  final Gradient gradient;
  final IconData icon;
  final Function() toDo;

  const CircleWrappedGradientIconButton({
    super.key,
    required this.size,
    required this.gradient,
    required this.icon,
    required this.toDo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size / 2),
          ),
        ),
        onPressed: toDo,
        child: GradientIcon(
          icon,
          size * 0.7,
          gradient,
        ),
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  const GradientIcon(this.icon, this.size, this.gradient, {super.key});

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
