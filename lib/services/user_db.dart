import 'package:majootestcase/models/user.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';

class UserDatabase {
  static late Database db;

  static final String dbName = 'user.db';
  static final String tableName = 'user';
  static final String id = 'id';
  static final String _email = 'email';
  static final String userName = 'username';
  static final String password = 'password';

  static Future<void> open() async {
    var path = await initDeleteDb(dbName);
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableName ( 
  $id integer primary key autoincrement, 
  $_email text not null,
  $userName text not null,
  $password text not null)
''');
    });
  }

  static Future<bool> insert(User user) async {
    var isExists = await getUserByEmail(user.email!);
    if (isExists != null) {
      return false;
    }
    int res = await db.insert(tableName, user.toJson());
    return res == 1;
  }

  static Future<User?> getUser(int id) async {
    final List<Map> maps =
        await db.query(tableName, where: '$id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return User.fromJson(maps.first as Map<String, dynamic>);
    }
    return null;
  }

  static Future<User?> getUserByEmail(String email) async {
    final List<Map> maps =
        await db.query(tableName, where: '$_email = ?', whereArgs: [email]);
    if (maps.isNotEmpty) {
      return User.fromJson(maps.first as Map<String, dynamic>);
    }
    return null;
  }
}
