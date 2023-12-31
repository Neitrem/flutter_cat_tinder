import 'dart:async';
import 'dart:io';
import 'package:cinder/db/interfaces/db_model_interface.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "db.sqlite3";

  // Make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Lazily instantiate the database if unavailable
    _database = await _initDatabase();
    return _database!;
  }

  // Open the database, creating if it doesn't exist
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        login TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      );''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS favorite (
        id INTEGER PRIMARY KEY,
        url TEXT NOT NULL,
        user_id INTEGER NOT NULL,
        FOREIGN KEY(user_id) REFERENCES users(id)
      );
      ''');
  }

  Future<int> insert(IDBModel model) async {
    Database db = await instance.database;
    return await db.insert(
      model.table,
      model.toMap(),
    );
  }

  Future<List<Map<String, dynamic>>> get({required String table}) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<bool> userExist(IDBModel model) async {
    Database db = await instance.database;
    return (await db.query(
      model.table,
      where: "login = ?",
      whereArgs: [
        model.toMap()['login'],
      ],
    ))
        .isNotEmpty;
  }

  Future<bool> isAlreadyInFavorite(IDBModel model) async {
    Database db = await instance.database;
    return (await db.query(
      model.table,
      where: "url = ? AND user_id = ?",
      whereArgs: [
        model.toMap()['url'],
        model.toMap()['user_id'],
      ],
    ))
        .isNotEmpty;
  }
}
