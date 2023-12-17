import 'package:flutter/material.dart';
import 'main.dart';
import 'addUser.dart';
import 'database.dart';
import 'updateUser.dart';

class UserManagementPage extends StatefulWidget {
  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  List<Map> userList = [];
  List<Widget> userListWidgets = [];
  UserDatabase userdb = new UserDatabase();

  @override
  void initState() {
    super.initState();
    userdb.open();
    getData();
  }

  void getData() async {
    try {
      final List<Map<String, dynamic>> users = await userdb.getAllUsers();

      setState(() {
        userList = users;
        userListWidgets = userList.map((user) {
          return Card(
            elevation: 5,
            child: ListTile(
              title: Text("${user["first_name"]} ${user["last_name"]}", style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                "Email: ${user["email"]}\nUsername: ${user["username"]}\nIs Admin: ${user["is_admin"] == 1 ? 'Yes' : 'No'}",
              ),
              trailing: Wrap(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UpdateUserPage(user_Id: user["user_id"]),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit, color: Colors.blue),
                  ),
                  IconButton(
                    onPressed: () async {
                      await userdb.db.rawDelete(
                        "delete from users where user_id = ?",
                        [user["user_id"]],
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('User data deleted')),
                      );
                      getData(); // Refresh the list after deletion
                    },
                    icon: Icon(Icons.delete, color: customColorFireBrick),
                  ),
                ],
              ),
            ),
          );
        }).toList();
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColorOldLace,
      appBar: AppBar(
        backgroundColor: customColorFireBrick,
        title: Text(
          'Admin User Management',
          style: TextStyle(
            fontSize: 64,
            color: customColorOldLace,
            fontFamily: 'PeachandCream',
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
          ),
          const Text('Administer user accounts and permissions on the system.'),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddUserPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColorFireBrick,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Add User',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: getData, // Just call getData directly
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColorFireBrick,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Load Users',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Expanded(
            child: ListView(
              children: userListWidgets,
            ),
          ),
        ],
      ),
    );
  }
}