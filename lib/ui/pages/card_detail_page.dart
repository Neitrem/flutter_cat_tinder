import 'package:cinder/domain/cats/models/cat_model.dart';
import 'package:cinder/ui/styles/colors.dart';
import 'package:flutter/material.dart';

class CardDetailPage extends StatefulWidget {
  final CatModel cat;
  const CardDetailPage({super.key, required this.cat});

  @override
  State<CardDetailPage> createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  void _close() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              onPressed: _close,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 35,
                color: lightGrey,
              ),
            ),
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Item"),
              background: Hero(
                tag: "front-card",
                child: Image.network(
                  widget.cat.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
