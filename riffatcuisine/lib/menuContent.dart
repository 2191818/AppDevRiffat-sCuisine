import 'package:flutter/material.dart';
import 'checkout.dart';
import 'main.dart';
import 'database.dart';

class MenuContent extends StatefulWidget {
  final void Function(List<Map<String, dynamic>> items) updateSelectedItems;

  const MenuContent({Key? key, required this.updateSelectedItems}) : super(key: key);

  @override
  _MenuContentState createState() => _MenuContentState();
}

class _MenuContentState extends State<MenuContent> {
  MenuDatabase menuDatabase = MenuDatabase();
  List<Map<String, dynamic>> menuItems = [];
  List<Map<String, dynamic>> selectedItems =
      []; // Added list for selected items

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

  void addToSelectedItems(Map<String, dynamic> item) {
    bool alreadyAdded =
        selectedItems.any((selectedItem) => _areItemsEqual(selectedItem, item));

    if (!alreadyAdded) {
      // Set initial quantity to 1 when adding a new item
      setState(() {
        selectedItems.add({
          ...item,
          'quantity': 1,
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item['name']} added to the order!'),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      // If the item is already in the list, increase its quantity by 1
      increaseItemQuantity(item);
    }
  }

  void increaseItemQuantity(Map<String, dynamic> item) {
    setState(() {
      item['quantity'] += 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Quantity increased for ${item['name']}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void decreaseItemQuantity(Map<String, dynamic> item) {
    if (item['quantity'] > 1) {
      setState(() {
        item['quantity'] -= 1;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Quantity decreased for ${item['name']}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  bool _areItemsEqual(Map<String, dynamic> item1, Map<String, dynamic> item2) {
    // Compare items based on their names
    return item1['name'] == item2['name'];
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
                      style: const TextStyle(
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
                            addToSelectedItems(item);
                          },
                          icon: const Icon(Icons.add, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.all(16),
          //   color: Colors.white,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const Text(
          //         'Selected Items',
          //         style: TextStyle(
          //           fontSize: 24,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       const SizedBox(height: 8),
          //       const Divider(),
          //       const SizedBox(height: 8),
          //       // Display selected items
          //       ListView.builder(
          //         shrinkWrap: true,
          //         itemCount: selectedItems.length,
          //         itemBuilder: (context, index) {
          //           var selectedItem = selectedItems[index];
          //           return ListTile(
          //             title: Text(
          //               selectedItem['name'],
          //               style: const TextStyle(
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 18,
          //               ),
          //             ),
          //             subtitle: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   'Type: ${selectedItem['type']} - Price: \$${selectedItem['price']}',
          //                 ),
          //                 Row(
          //                   children: [
          //                     const Text('Quantity: '),
          //                     DropdownButton<int>(
          //                       value: selectedItem['quantity'],
          //                       onChanged: (int? value) {
          //                         updateQuantity(index, value);
          //                       },
          //                       items: List.generate(10, (index) => index + 1)
          //                           .map((quantity) => DropdownMenuItem<int>(
          //                                 value: quantity,
          //                                 child: Text(quantity.toString()),
          //                               ))
          //                           .toList(),
          //                     ),
          //                   ],
          //                 ),
          //               ],
          //             ),
          //             trailing: IconButton(
          //               onPressed: () {
          //                 removeFromSelectedItems(index);
          //               },
          //               icon: const Icon(Icons.remove, color: Colors.red),
          //             ),
          //           );
          //         },
          //       ),
          //       const SizedBox(height: 16),
          //       Text(
          //         'Total Cost: \$${calculateTotalCost().toStringAsFixed(2)}',
          //         style: TextStyle(
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold,
          //             color: customColorFireBrick),
          //       ),
          //       ElevatedButton(
          //         onPressed: () {
          //           // Navigate to the checkout page
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) =>
          //                   CheckoutPage(selectedItems: selectedItems),
          //             ),
          //           );
          //         },
          //         child: const Text('Checkout'),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  void updateQuantity(int index, int? quantity) {
    if (quantity != null) {
      setState(() {
        selectedItems[index]['quantity'] = quantity;
      });
    }
  }

// Update the calculateTotalCost function
  double calculateTotalCost() {
    double totalCost = 0.0;
    for (var item in selectedItems) {
      totalCost += (item['price'] * item['quantity']);
    }
    return totalCost;
  }

  void removeFromSelectedItems(int index) {
    setState(() {
      selectedItems.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item removed from the order!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
