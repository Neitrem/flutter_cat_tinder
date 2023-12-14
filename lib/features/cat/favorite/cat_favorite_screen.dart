import 'package:cinder/features/cat/favorite/cat_favorite_cubit.dart';
import 'package:cinder/features/cat/favorite/cat_favorite_state.dart';
import 'package:cinder/ui/components/loading_animation.dart';
import 'package:cinder/ui/components/logo.dart';
import 'package:cinder/ui/pages/error_page.dart';
import 'package:cinder/ui/pages/favorite_page.dart';
import 'package:cinder/ui/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatFavoriteScreen extends StatefulWidget {
  final int userId;

  const CatFavoriteScreen({super.key, required this.userId});

  @override
  State<CatFavoriteScreen> createState() => _CatFavoriteScreenState();
}

class _CatFavoriteScreenState extends State<CatFavoriteScreen> {
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
            color: lightGrey,
          ),
        ),
        centerTitle: true,
        title: const LogoText(),
      ),
      body: BlocProvider(
        create: (context) => CatFavoriteCubit(
          context: context,
          userId: widget.userId,
        )..loadFavoirites(),
        child: BlocConsumer<CatFavoriteCubit, CatFavoriteState>(
          listener: (context, state) => {},
          builder: (context, state) {
            if (state is CatFavoriteLoading) {
              return const Stack(
                children: <Widget>[
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
            return const Placeholder(
              color: Colors.transparent,
            );
          },
        ),
      ),
    );
  }
}
