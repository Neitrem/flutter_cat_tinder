import 'package:cinder/domain/cats/models/favorite_model.dart';
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0, right: 10.0, left: 10.0),
      child: ListView.separated(
        itemCount: widget.favorites.length,
        itemBuilder: (context, index) {
          return Container(
            height: 130.0,
            padding: const EdgeInsets.all(5.0),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: white,
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: lightGrey.withOpacity(0.3),
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
    );
  }
}
