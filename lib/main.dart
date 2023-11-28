import 'package:cinder/data/cats/repository/cat_repository.dart';
import 'package:cinder/features/cat/cat_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<void> main() async {
  await dotenv.load(fileName: ".env");
  print('API_KEY ${dotenv.get('API_KEY')}'); 
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  MyApp({super.key});

  final CatRepository rep = CatRepository();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const CatMain()
    );
  }
}


