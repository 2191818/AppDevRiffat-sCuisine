import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabase {
  late Database db;

  Future open() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'user.db');
    db = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
      create table if not exists users (
      user_id integer primary key,
      username varchar(50) not null,
      password varchar(50) not null,
      email varchar(50) not null,
      first_name varchar(50) not null,
      last_name varchar(50) not null,
      is_admin integer not null
      );
      ''');
    });
  }

  Future<int?> getUserIdByUsername(String username) async {
    List<Map> maps = await db.query('users', columns: ['user_id'], where: 'username = poka', whereArgs: [username]);
    if (maps.isNotEmpty) {
      return maps.first['user_id'];
    }
    return null;
  }

  Future<Map<dynamic, dynamic>?> getNameByUsername(String username) async {
    List<Map> maps = await db.query('users', columns: ['first_name', 'last_name'], where: 'username = ?', whereArgs: [username]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<int> createUser(Map<String, dynamic> user) async {
    return await db.insert('users', user);
  }

  Future<Map<dynamic, dynamic>?> getUserById(int userId) async {
    List<Map> maps = await db.query('users', where: 'user_id = ?', whereArgs: [userId]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<Map<dynamic, dynamic>?> getUserByUsername(String username) async {
    List<Map> maps = await db.query('users', where: 'username = ?', whereArgs: [username]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final List<Map<String, dynamic>> users = await db.rawQuery('SELECT * FROM users');
    return users;
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    return await db.update('users', user, where: 'user_id = ?', whereArgs: [user['user_id']]);
  }

  Future<int> deleteUser(int userId) async {
    return await db.delete('users', where: 'user_id = ?', whereArgs: [userId]);
  }
}


class MenuDatabase {
  late Database db;

  Future open() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'menu.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table if not exists menu (
      food_id integer primary key,
      name varchar(50) not null,
      type varchar(50) not null,
      description text,
      price real not null
      );
      ''');
    });
  }

  Future<int> createMenuItem(Map<String, dynamic> menuItem) async {
    return await db.insert('menu', menuItem);
  }

  Future<Map<dynamic, dynamic>?> getMenuItemById(int foodId) async {
    List<Map> maps =
        await db.query('menu', where: 'food_id = ?', whereArgs: [foodId]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getAllMenuItems() async {
    final List<Map<String, dynamic>> menuItems =
        await db.rawQuery('SELECT * FROM menu');
    return menuItems;
  }

  Future<int> updateMenuItem(Map<String, dynamic> menuItem) async {
    return await db.update('menu', menuItem,
        where: 'food_id = ?', whereArgs: [menuItem['food_id']]);
  }

  Future<int> deleteMenuItem(int foodId) async {
    return await db.delete('menu', where: 'food_id = ?', whereArgs: [foodId]);
  }
}
