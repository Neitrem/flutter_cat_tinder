import 'package:cinder/domain/authentication/models/user_model.dart';
import 'package:cinder/features/cat/favorite/cat_favorite_screen.dart';
import 'package:cinder/features/cat/main/cat_main_cubit.dart';
import 'package:cinder/features/cat/main/cat_main_state.dart';
import 'package:cinder/ui/components/loading_animation.dart';
import 'package:cinder/ui/pages/error_page.dart';
import 'package:cinder/ui/pages/main_page.dart';
import 'package:cinder/ui/provider/card_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CatMainScreen extends StatelessWidget {
  final UserModel user;

  const CatMainScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatMainCubit(
        context: context,
        user: user,
      )..preparing(),
      child: BlocConsumer<CatMainCubit, CatMainState>(
        listener: (context, state) {
          if (state is CatMainRedirect) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CatFavoriteScreen(
                  userId: state.userId,
                ),
              ),
            );
          }
        },
        buildWhen: (previous, current) =>
            current is CatMainBuildState || current is CatMainError,
        builder: (context, state) {
          if (state is CatMainLoading) {
            return const Stack(
              children: <Widget>[
                Scaffold(),
                LoadingAnimation(),
              ],
            );
          } else if (state is CatMainData) {
            return ChangeNotifierProvider(
              create: (context) => CardProvider(
                  cats: state.cats,
                  popCat: context.read<CatMainCubit>().pop,
                  likeCat: context.read<CatMainCubit>().addToFavorite,
                  context: context),
              child: MainPage(cats: state.cats),
            );
          } else if (state is CatMainError) {
            return ErrorPage(
              fromFunction: state.fromFunction,
              errorText: state.error,
              namedArguments: state.namedArguments,
            );
          }
          return const Text("Error!!!");
        },
      ),
    );
  }
}
