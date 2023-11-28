import 'package:sqlite3/sqlite3.dart';

class UserRepository {
  final db = sqlite3.open('db.sqlite3');

  void f () {
    db.execute('''
    CREATE TABLE artists (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT NOT NULL
    );
  ''');

  // Prepare a statement to run it multiple times:
  final stmt = db.prepare('INSERT INTO artists (name) VALUES (?)');
  stmt
    ..execute(['The Beatles'])
    ..execute(['Led Zeppelin'])
    ..execute(['The Who'])
    ..execute(['Nirvana']);

  // Dispose a statement when you don't need it anymore to clean up resources.
  stmt.dispose();

  // You can run select statements with PreparedStatement.select, or directly
  // on the database:
  final ResultSet resultSet =
      db.select('SELECT * FROM artists WHERE name LIKE ?', ['The %']);

  // You can iterate on the result set in multiple ways to retrieve Row objects
  // one by one.
  for (final Row row in resultSet) {
    print('Artist[id: ${row['id']}, name: ${row['name']}]');
  }


  // Don't forget to dispose the database to avoid memory leaks
  db.dispose();
  }
}