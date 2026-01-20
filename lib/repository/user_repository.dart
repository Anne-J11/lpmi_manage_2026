import 'package:lpmi_manage/database/database_helper.dart';
import 'package:lpmi_manage/model/user.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  static const String tableName = 'users';

  Future<void> insertUser(User user) async {
    final db = await _dbHelper.database;
    await db.insert(
      tableName,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<void> updatePassword(String email, String newPassword) async {
    final db = await _dbHelper.database;
    await db.update(
      tableName,
      {'password': newPassword},
      where: 'email = ?',
      whereArgs: [email],
    );
  }
}
