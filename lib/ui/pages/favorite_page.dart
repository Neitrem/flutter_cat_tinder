import 'package:cinder/domain/cats/models/favorite_model.dart';
import 'package:cinder/ui/components/logo.dart';
import 'package:cinder/ui/styles/colors.dart';
import 'package:cinder/ui/styles/styles.dart';
import 'package:flutter/material.dart';

class CatFavoritePage extends StatefulWidget {
  final List<FavoriteModel> favorites;

  const CatFavoritePage({
    super.key,
    required this.favorites,
  });

  @override
  State<CatFavoritePage> createState() => _CatFavoritePageState();
}

class _CatFavoritePageState extends State<CatFavoritePage> {
  void _close() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _close,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 35,
            color: secondaryColor,
          ),
        ),
        centerTitle: true,
        title: const LogoText(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0, right: 10.0, left: 10.0),
        child: ListView.separated(
          itemCount: widget.favorites.length,
          itemBuilder: (context, index) {
            return Container(
              height: 130.0,
              padding: const EdgeInsets.all(5.0),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: white,
                borderRadius: borderRadius,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(1, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: Image.network(
                        widget.favorites[index].url,
                      ).image,
                      backgroundColor: lightGrey,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 10.0,
          ),
        ),
      ),
    );
  }
}
