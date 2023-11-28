import 'package:cinder/domain/models/cat_model.dart';
import 'package:cinder/ui/components/cat_card.dart';
import 'package:cinder/ui/provider/card_provider.dart';
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
        title: const Text("Cinder"),
        leading: IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.settings),
        ),
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
          const Expanded(
            child: Text("wdwdwd"),
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
