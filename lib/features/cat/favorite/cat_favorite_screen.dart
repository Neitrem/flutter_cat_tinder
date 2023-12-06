import 'package:cinder/features/cat/favorite/cat_favorite_cubit.dart';
import 'package:cinder/features/cat/favorite/cat_favorite_state.dart';
import 'package:cinder/ui/components/loading_animation.dart';
import 'package:cinder/ui/pages/error_page.dart';
import 'package:cinder/ui/pages/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatFavoriteScreen extends StatelessWidget {
  final int userId;

  const CatFavoriteScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatFavoriteCubit(
        context: context,
        userId: userId,
      )..loadFavoirites(),
      child: BlocConsumer<CatFavoriteCubit, CatFavoriteState>(
        listener: (context, state) => {},
        builder: (context, state) {
          if (state is CatFavoriteLoading) {
            return const Stack(
              children: <Widget>[
                Scaffold(),
                LoadingAnimation(),
              ],
            );
          } else if (state is CatFavoriteData) {
            return CatFavoritePage(
              favorites: state.favorites,
            );
          } else if (state is CatFavoriteError) {
            return ErrorPage(
              fromFunction: state.fromFunction,
              errorText: state.error,
              namedArguments: state.namedArguments,
            );
          }
          return Placeholder();
        },
      ),
    );
  }
}
