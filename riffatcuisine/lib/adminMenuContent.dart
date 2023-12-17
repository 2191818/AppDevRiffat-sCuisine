import 'package:flutter/material.dart';
import 'main.dart';
import 'createMenu.dart';
import 'database.dart';
import 'updateMenu.dart';

class AdminMenuContent extends StatefulWidget {
  const AdminMenuContent({super.key});

  @override
  _AdminMenuContentState createState() => _AdminMenuContentState();
}

class _AdminMenuContentState extends State<AdminMenuContent> {
  MenuDatabase menuDatabase = MenuDatabase();

  List<Map<String, dynamic>> menuItems = [];

  @override
  void initState() {
    super.initState();
    menuDatabase.open();
    getMenuItems();
  }

  void getMenuItems() async {
    List<Map<String, dynamic>> items = await menuDatabase.getAllMenuItems();

    setState(() {
      menuItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColorOldLace,
      body: Column(
        children: [
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
                      MaterialPageRoute(builder: (context) => AddMenuItemPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColorFireBrick,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Add Item',
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
                  onPressed: () {
                    getMenuItems(); // Reload menu items
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColorFireBrick,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Load Items',
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
              children: menuItems.map((item) {
                return Card(
                  child: ListTile(
                    title: Text(
                      item['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Type: ${item['type']} - Price: \$${item['price']}',
                    ),
                    trailing: Wrap(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateMenuItemPage(
                                      foodId: item["food_id"])),
                            );
                          },
                          icon: const Icon(Icons.edit, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: () async {
                            await menuDatabase.db.rawDelete(
                              "delete from menu where food_id = ?",
                              [item["food_id"]],
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Menu item deleted')),
                            );
                            getMenuItems(); // Refresh the list after deletion
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}