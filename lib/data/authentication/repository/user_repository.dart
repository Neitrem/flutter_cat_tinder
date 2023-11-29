import 'dart:io';

import 'package:cinder/data/authentication/models/user_dto.dart';
import 'package:cinder/data/authentication/repository/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';

class UserRepository {
  final db_h = DatabaseHelper.instance;


  // Future<void> _createTables() async {
  //   db.execute('''
  //     CREATE TABLE IF NOT EXISTS users (
  //       id INTEGER PRIMARY KEY,
  //       login TEXT NOT NULL UNIQUE,
  //       password TEXT NOT NULL
  //     );'''
  //   );

  //   db.execute('''
  //     CREATE TABLE IF NOT EXISTS urls (
  //       id INTEGER PRIMARY KEY,
  //       url TEXT NOT NULL,
  //       user_id INTEGER NOT NULL,
  //       FOREIGN KEY(user_id) REFERENCES users(id)
  //     );
  //     '''
  //   );
  // }

  Future<bool> _isAuthorised() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final isUserExist = prefs.get('user') == null ? false : true;

    return isUserExist;
  }

  Future<UserDTO?> getUser() async {
    final isAuth = await _isAuthorised();

    switch (isAuth) {
      case true:
        return null;
      case false:
        return null;
    }
  }

  // Future<UserDTO?> login(String login, String password) async {
  //   final ResultSet resultSet =
  //     db.select('SELECT * FROM users WHERE login = ?', [login]);

  //     print(resultSet.toString());

  //     return null;
  // }

  Future<String?> register(String login, String password) async {
    final s = await db_h.insert(Note(name: "name", description: "description"));
    return s.toString();
    // try {
    //   db.execute('''
    //     INSERT INTO users (login, password) VALUES (?, ?)
    //     ''',
    //     [login, password]
    //   );
    //   return 'success';
    // } catch (e) {
    //   return 'error';
    // }
  }

  // void f () {
    

  // // Prepare a statement to run it multiple times:
  // final stmt = db.prepare('INSERT INTO artists (name) VALUES (?)');
  // stmt
  //   ..execute(['The Beatles'])
  //   ..execute(['Led Zeppelin'])
  //   ..execute(['The Who'])
  //   ..execute(['Nirvana']);

  // // Dispose a statement when you don't need it anymore to clean up resources.
  // stmt.dispose();

  // // You can run select statements with PreparedStatement.select, or directly
  // // on the database:
  // final ResultSet resultSet =
  //     db.select('SELECT * FROM artists WHERE name LIKE ?', ['The %']);

  // // You can iterate on the result set in multiple ways to retrieve Row objects
  // // one by one.
  // for (final Row row in resultSet) {
  //   print('Artist[id: ${row['id']}, name: ${row['name']}]');
  // }


  // // Don't forget to dispose the database to avoid memory leaks
  // db.dispose();
  // }
}