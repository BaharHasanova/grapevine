import 'package:flutter/material.dart';
import 'package:flutter_test_application_1/pages/payment_method.dart';
import 'package:flutter_test_application_1/pages/add_new_card.dart'; // Ensure you have this page for adding new cards

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      title: 'Credit/Debit Card',
      logoAsset: 'assets/credit_card.png',
    ),
    PaymentMethod(
      title: 'NetBanking',
      logoAsset: 'assets/netbanking.png',
    ),
    PaymentMethod(
      title: 'Wallet',
      logoAsset: 'assets/wallet.png',
    ),
    PaymentMethod(
      title: 'Cash On Delivery',
      logoAsset: 'assets/cash.svg',
    ),
  ];

  int? selectedMethodIndex;
  int? selectedCardIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Method'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: paymentMethods.length,
              itemBuilder: (context, index) {
                var method = paymentMethods[index];
                return Card(
                  elevation: 2,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ExpansionTile(
                    leading: Image.asset(method.logoAsset, width: 40),
                    title: Text(
                      method.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: index == 3
                        ? Radio<int>(
                            value: index,
                            groupValue: selectedMethodIndex,
                            onChanged: (int? value) {
                              setState(() {
                                selectedMethodIndex = value;
                                selectedCardIndex =
                                    null; // Reset card selection
                              });
                            },
                          )
                        : const Icon(Icons.arrow_drop_down),
                    initiallyExpanded: selectedMethodIndex == index,
                    onExpansionChanged: (bool expanded) {
                      if (expanded) {
                        setState(() {
                          selectedMethodIndex = index;
                        });
                      }
                    },
                    children: _buildPaymentOptions(index),
                  ),
                );
              },
            ),
          ),
          _buildTotalAmountSection(),
          _buildMakePaymentButton(),
        ],
      ),
    );
  }

  List<Widget> _buildPaymentOptions(int index) {
    if (index == 0) {
      // Credit/Debit Card options
      return [
        ListTile(
          leading: const Icon(Icons.add, color: Colors.black),
          title: const Text('Add New Card'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // Navigate to Add New Card page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddNewCardPage()),
            ).then((value) {
              // Handle new card addition here
            });
          },
        ),
        ListTile(
          leading: Image.asset('assets/mastercard.svg', width: 40),
          title: const Text('**** **** **** 1234'),
          trailing: Radio<int>(
            value: 0,
            groupValue: selectedCardIndex,
            onChanged: (int? value) {
              setState(() {
                selectedCardIndex = value;
                selectedMethodIndex = 0; // Ensure method is also selected
              });
            },
          ),
        ),
        // Add more cards here if needed
      ];
    } else if (index == 1) {
      // NetBanking options
      return [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Available NetBanking options',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        // Add specific bank options here
      ];
    } else if (index == 2) {
      // Wallet options
      return [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Available Wallet options',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        // Add specific wallet options here
      ];
    }
    return [];
  }

  Widget _buildTotalAmountSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      color: Colors.grey[200],
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Amount',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '\$28.6',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMakePaymentButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: selectedMethodIndex != null
            ? () {
                // Handle payment confirmation
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedMethodIndex != null
              ? const Color(0xFF9683ce) // Active color (blue)
              : Colors.grey, // Disabled color
          minimumSize: const Size(double.infinity, 50),
        ),
        child: const Text(
          'Make Payment',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
