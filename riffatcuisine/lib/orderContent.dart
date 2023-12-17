import 'package:flutter/material.dart';
import 'main.dart';
import 'checkout.dart';

class OrderContent extends StatefulWidget {
  final List<Map<String, dynamic>> selectedItems;

  const OrderContent({Key? key, required this.selectedItems}) : super(key: key);

  @override
  _OrderContentState createState() => _OrderContentState();
}

class _OrderContentState extends State<OrderContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Text(
          'Your Order',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: customColorFireBrick,
              fontSize: 64,
              fontFamily: 'PeachandCream'),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: _buildSelectedItems(),
        ),
        const SizedBox(height: 16),
        _buildTotalSection(),
        const SizedBox(height: 16),
        Container(
          width: 200,
          height: 60,
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
                MaterialPageRoute(
                  builder: (context) =>
                      CheckoutPage(selectedItems: widget.selectedItems),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: customColorFireBrick,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Checkout',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 50,)
      ],
    );
  }

  Widget _buildSelectedItems() {
    return ListView.builder(
      itemCount: widget.selectedItems.length,
      itemBuilder: (context, index) {
        var selectedItem = widget.selectedItems[index];
        return Card(
          child: ListTile(
            title: Text(
              selectedItem['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Type: ${selectedItem['type']} - Price: \$${selectedItem['price']}',
                ),
                Row(
                  children: [
                    const Text('Quantity: '),
                    Text(selectedItem['quantity'].toString()),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              onPressed: () {
                removeFromSelectedItems(index);
              },
              icon: const Icon(Icons.remove, color: Colors.red),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTotalSection() {
    double totalCost = calculateTotalCost();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          'Total | ',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '\$$totalCost',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: customColorFireBrick,
          ),
        ),
        const SizedBox(width: 50),
      ],
    );
  }

  void removeFromSelectedItems(int index) {
    setState(() {
      widget.selectedItems.removeAt(index);
    });
  }

  double calculateTotalCost() {
    double totalCost = 0.0;
    for (var item in widget.selectedItems) {
      totalCost += (item['price'] * item['quantity']);
    }
    return totalCost;
  }
}
