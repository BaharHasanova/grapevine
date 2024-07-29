import 'package:flutter/material.dart';
import 'package:flutter_test_application_1/pages/payment_method.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List<PaymentMethod> paymentMethods = [
    PaymentMethod(
        title: 'Amazon Pay',
        logoAsset: 'assets/amazon_pay.png'), // Changed to .png
    PaymentMethod(
        title: 'Credit Card', logoAsset: 'assets/visa.png'), // Changed to .png
    PaymentMethod(
        title: 'Paypal', logoAsset: 'assets/paypal.png'), // Changed to .png
    PaymentMethod(
        title: 'Google Pay',
        logoAsset: 'assets/google_pay.png'), // Changed to .png
  ];

  int? selectedMethodIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Method'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: paymentMethods.length,
              itemBuilder: (context, index) {
                var method = paymentMethods[index];
                return ListTile(
                  leading: Radio<int>(
                    value: index,
                    groupValue: selectedMethodIndex,
                    onChanged: (int? value) {
                      setState(() {
                        selectedMethodIndex = value;
                      });
                    },
                  ),
                  title: Text(method.title),
                  trailing: Image.asset(method.logoAsset,
                      width: 40), // Using Image.asset
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sub-Total'),
                    Text('\$300.50'),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Shipping Fee'),
                    Text('\$15.00'),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Payment'),
                    Text('\$315.50',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle payment confirmation
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9683ce),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Confirm Payment',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
