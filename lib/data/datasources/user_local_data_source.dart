import 'package:sqflite/sqflite.dart';
import '../../core/db_helper.dart';
import '../models/user_model.dart';

class UserLocalDataSource {
  Future<void> cacheUsers(List<UserModel> users) async {
    final db = await DBHelper.database;
    await db.delete('users');
    for (var u in users) {
      await db.insert('users', u.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<UserModel>> getCachedUsers() async {
    final db = await DBHelper.database;
    final list = await db.query('users');
    return list.map((m) => UserModel.fromJson(m)).toList();
  }

  Future<void> insertUser(UserModel u) async {
    final db = await DBHelper.database;
    await db.insert('users', u.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateUser(UserModel u) async {
    final db = await DBHelper.database;
    await db.update('users', u.toJson(), where: 'id = ?', whereArgs: [u.id]);
  }

  Future<void> deleteUser(int id) async {
    final db = await DBHelper.database;
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
