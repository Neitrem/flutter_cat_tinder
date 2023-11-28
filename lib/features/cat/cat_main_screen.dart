import 'package:cinder/features/cat/cat_main_cubit.dart';
import 'package:cinder/features/cat/cat_main_state.dart';
import 'package:cinder/ui/pages/main_page.dart';
import 'package:cinder/ui/provider/card_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CatMain extends StatelessWidget {
  const CatMain({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatCubit()..getCats(),
      child: BlocConsumer<CatCubit, CatMainState>(
        listener: (context, state) {
          if (state is CatMainError) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('error'),
                  content: Text(state.error),
                );
              },
            );
          }
        },
        builder: (context, state) {
          if (state is CatMainLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          } else if (state is CatMainData) {
            return ChangeNotifierProvider(
                create: (context) => CardProvider(
                      cats: state.cats,
                      loadMoreCats: context.read<CatCubit>().loadMoreCats,
                    ),
                child: MainPage(cats: state.cats));
          }
          return const Text("ffdf");
        },
      ),
    );
  }
}
