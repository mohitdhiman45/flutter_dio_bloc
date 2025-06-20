import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await openDatabase(
      join(await getDatabasesPath(), 'user_app.db'),
      version: 1,
      onCreate: (db, v) {
        return db.execute('''
          CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, email TEXT)
        ''');
      },
    );
    return _db!;
  }
}
