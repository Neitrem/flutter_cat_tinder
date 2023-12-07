import 'package:cinder/data/cats/repository/cat_repository.dart';
import 'package:cinder/features/splash_screen/splash_screen_screen.dart';
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        // home: CatMainScreen(user: UserModel(id: 1, login: "", password: ""),)
        home: const SplashScreenScreen(),
        // home: const CatFavoriteScreen(userId: 1),
    );
  }
}


