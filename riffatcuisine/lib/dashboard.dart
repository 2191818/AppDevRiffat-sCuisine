import 'package:flutter/material.dart';
import 'adminMenuContent.dart';
import 'adminOrderContent.dart';
import 'profile.dart';
import 'main.dart';
import 'login.dart';
import 'adminHomeContent.dart';
import 'dart:io';
import 'userManage.dart';
import 'account.dart';
import 'database.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AdminDashboard(
        enteredUsername: '',
      ),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  final String enteredUsername;

  const AdminDashboard({Key? key, required this.enteredUsername})
      : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;
  File? _profileImage;
  int _userId = 0;
  late UserDatabase userDatabase;

  @override
  void initState() {
    super.initState();
    userDatabase = UserDatabase();
    userDatabase.open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColorOldLace,
      appBar: AppBar(
        backgroundColor: customColorFireBrick,
        title: Text(
          "Riffat's Cuisine",
          style: TextStyle(
              fontFamily: 'PeachandCream',
              fontSize: 64,
              color: customColorOldLace),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const SizedBox(height: 50),
            CircleAvatar(
              backgroundColor: customColorOldLace,
              radius: 50,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: customColorFireBrick,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: _profileImage != null
                      ? Image.file(
                          _profileImage!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/tablogo.png',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.enteredUsername,
                    style: TextStyle(
                      fontSize: 60,
                      color: customColorFireBrick,
                      fontFamily: 'PeachandCream',
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
              onTap: null,
            ),
            // ListTile(
            //   title: const Text('Account Details'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => AccountPage(enteredUsername: widget.enteredUsername)
            //       ),
            //     );
            //   },
            // ),
            ListTile(
              title: const Text('Profile Picture'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageUploadPage(
                      onImageSelected: (image) {
                        setState(() {
                          _profileImage = image;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('User Management'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserManagementPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
            ListTile(
              title: const Text('App Information',
                  style: TextStyle(color: Colors.grey)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('App Information',
                          style: TextStyle(
                              color: customColorFireBrick,
                              fontFamily: 'PeachandCream',
                              fontSize: 64),
                          textAlign: TextAlign.center),
                      content: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Divider(),
                          SizedBox(height: 8),
                          Text('App Name: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Riffat\'s Cuisine'),
                          SizedBox(height: 8),
                          Text('Version: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('3.0.0'),
                          SizedBox(height: 8),
                          Text('Developer: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Muhammad Arsalan Saeed'),
                          SizedBox(height: 8),
                          Text('Contact: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('arsalan.m.saeed@outlook.com'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: customColorFireBrick,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: customColorOldLace,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.restaurant_menu,
              color: customColorOldLace,
            ),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.receipt_long,
              color: customColorOldLace,
            ),
            label: 'Order',
          ),
        ],
        selectedItemColor: customColorOldLace,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
      body: _getPage(_currentIndex, _profileImage, _userId),
    );
  }

  Widget _getPage(int index, File? profileImage, int userId) {
    switch (index) {
      case 0:
        return AdminHomeContent(
          enteredUsername: widget.enteredUsername,
          profileImage: profileImage,
          userId: userId,
        );
      case 1:
        return const AdminMenuContent();
      case 2:
        return const AdminOrderContent();
      default:
        return AdminHomeContent(
          enteredUsername: widget.enteredUsername,
          profileImage: profileImage,
          userId: userId,
        );
    }
  }
}
