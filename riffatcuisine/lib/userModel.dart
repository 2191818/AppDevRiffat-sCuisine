import 'database.dart';

class UserModel {
  final UserDatabase _userDatabase = UserDatabase();

  Future<Map<dynamic, dynamic>?> getUserById(int userId) async {
    await _userDatabase.open();
    List<Map> maps = await _userDatabase.db.query('users', where: 'user_id = ?', whereArgs: [userId]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<Map<dynamic, dynamic>?> login(String username, String password) async {
    await _userDatabase.open();
    List<Map> maps = await _userDatabase.db.query('users', where: 'username = ? AND password = ?', whereArgs: [username, password]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<void> createUser(String username, String password, String email, String firstName, String lastName, int isAdmin) async {
    await _userDatabase.open();
    await _userDatabase.db.insert('users', {
      'username': username,
      'password': password,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'is_admin': isAdmin,
    });
  }

  Future<void> deleteUser(int userId) async {
    await _userDatabase.open();
    await _userDatabase.db.delete('users', where: 'user_id = ?', whereArgs: [userId]);
  }

  Future<void> updateUser(int userId, String username, String password, String email, String firstName, String lastName, int isAdmin) async {
    await _userDatabase.open();
    await _userDatabase.db.update('users', {
      'username': username,
      'password': password,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'is_admin': isAdmin,
    }, where: 'user_id = ?', whereArgs: [userId]);
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    await _userDatabase.open();
    return await _userDatabase.db.query('users');
  }

  Future<Map<String, dynamic>?> getFullNameByUsername(String username) async {
    await _userDatabase.open();
    List<Map> maps = await _userDatabase.db.query('users',
        columns: ['first_name', 'last_name'],
        where: 'username = ?',
        whereArgs: [username]);

    if (maps.isNotEmpty) {
      return {
        'first_name': maps.first['first_name'],
        'last_name': maps.first['last_name'],
      };
    }
    return null;
  }
}
