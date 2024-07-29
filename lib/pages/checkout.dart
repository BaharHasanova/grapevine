import 'package:flutter/material.dart';
import 'cart_item.dart';
import 'payment.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<CartItem> cartItems = [
    CartItem(name: 'Warm Zipper', description: 'Hooded Jacket', price: 300),
    CartItem(name: 'Knitted Woo!', description: 'Hooded Jacket', price: 600),
    CartItem(name: 'Zipper Win', description: 'Hooded Jacket', price: 350),
    CartItem(name: 'Child Win', description: 'Hooded Jacket', price: 60),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: const Color(0xFF9683ce), // Customize as needed
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Checkbox(
                    value: item.isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        item.isSelected =
                            value ?? false; // Update the item's selected state
                      });
                    },
                  ),
                  title: Text(item.name),
                  subtitle: Text('${item.description} - \$${item.price}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            item.decrement();
                          });
                        },
                      ),
                      Text('${item.quantity}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            item.increment();
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Payment',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('\$${calculateTotal()}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9683ce),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ), // Match parent width
              ),
              child: const Text('Checkout', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }

  int calculateTotal() {
    return cartItems.fold(0, (total, item) {
      if (item.isSelected) {
        return total + item.price * item.quantity;
      }
      return total;
    });
  }
}
