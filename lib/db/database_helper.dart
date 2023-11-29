import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "crud.sqlite3";

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
      
    return await openDatabase(path, onCreate: _onCreate);
  }

    // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        login TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      );'''
    );

    db.execute('''
      CREATE TABLE IF NOT EXISTS urls (
        id INTEGER PRIMARY KEY,
        url TEXT NOT NULL,
        user_id INTEGER NOT NULL,
        FOREIGN KEY(user_id) REFERENCES users(id)
      );
      '''
    );
  }

  Future<int> insert(dynamic model, String table) async {
    Database db = await instance.database;
    print("insert");
    return await db.insert(table, model.toMap());
  }
}


class Note {
     int? id;
     String name;
     String description;

     Note({
       this.id,
       required this.name,
       required this.description,
     });

     Map<String, dynamic> toMap() {
       return {
         'id': id,
         'name': name,
         'description': description,
       };
     }

     factory Note.fromMap(Map<String, dynamic> map) {
       return Note(
         id: map['id'],
         name: map['name'],
         description: map['description'],
       );
     }
   }