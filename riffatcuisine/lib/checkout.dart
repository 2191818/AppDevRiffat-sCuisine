import 'package:flutter/material.dart';
import 'main.dart';

class CheckoutPage extends StatelessWidget {
  final List<Map<String, dynamic>> selectedItems;

  const CheckoutPage({Key? key, required this.selectedItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selected Items',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            // Display selected items
            ListView.builder(
              shrinkWrap: true,
              itemCount: selectedItems.length,
              itemBuilder: (context, index) {
                var selectedItem = selectedItems[index];
                return ListTile(
                  title: Text(
                    selectedItem['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    'Type: ${selectedItem['type']} - Price: \$${selectedItem['price']} - Quantity: ${selectedItem['quantity']}',
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Total Cost: \$${calculateTotalCost().toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: customColorFireBrick,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateTotalCost() {
    double totalCost = 0.0;
    for (var item in selectedItems) {
      totalCost += (item['price'] * item['quantity']);
    }
    return totalCost;
  }
}
