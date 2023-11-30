import 'package:cinder/data/cats/repository/cat_repository.dart';
import 'package:cinder/features/authentication/authentication_screen.dart';
import 'package:cinder/features/cat/cat_main_screen.dart';
import 'package:cinder/ui/styles/styles.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<void> main() async {
  await dotenv.load(fileName: ".env");
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
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
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
        ),
        // home: const AunthenticationScreen()
        home: const CatMain(),
    );
  }
}


