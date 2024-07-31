import 'package:flutter/material.dart';
import 'package:flutter_test_application_1/pages/checkout.dart';
// Ensure this is correctly imported based on your project structure

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProductPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Page'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/calvin_klein_shirt.png'), // Your image path
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Calvin Klein Regular fit slim fit shirt',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('\$35 \$40.25 15% OFF',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: ['S', 'M', 'L', 'XL', 'XXL']
                        .map((size) => Chip(
                            label: Text(size),
                            backgroundColor: Colors.grey[200]))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  deliverySection(context),
                  const SizedBox(height: 16),
                  productDetailsSection(),
                  const SizedBox(height: 16),
                  ratingsAndReviewsSection(context),
                  const SizedBox(height: 16),
                  youMayLikeSection(),
                  const SizedBox(height: 16),
                  purchaseButtons(context),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget deliverySection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Deliver to Maine Inglewood - 98380'),
              trailing: ElevatedButton(
                onPressed: () {
                  // Implement functionality to change delivery address
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9683CE),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Change'),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Get it by Wed, Feb 02'),
            ),
            const ListTile(
              leading: Icon(Icons.payment),
              title: Text('COD Available'),
            ),
            const ListTile(
              leading: Icon(Icons.repeat),
              title: Text('30 Days Exchange/ Return Available'),
            ),
          ],
        ),
      ),
    );
  }

  Widget productDetailsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const ListTile(
              title: Text('Product Details'),
              subtitle: Text(
                  'Fabric: Cotton\nLength: Regular\nNeck: Round Neck\nPattern: Graphic Print'),
            ),
            ListTile(
              title: const Text('View More'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Implement view more details functionality
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget ratingsAndReviewsSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('4.8/5'),
              subtitle: const Text('574 Ratings'),
              trailing: ElevatedButton(
                onPressed: () {
                  // Implement rate functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9683CE),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Rate'),
              ),
            ),
            ListTile(
              title: const Text('Amazing!'),
              subtitle: const Text(
                  'An amazing fit. I am somewhere around 6ft and ordered 40 size, it\'s a perfect fit and quality is worth the price...'),
              onTap: () {
                // Implement view all reviews functionality
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget youMayLikeSection() {
    return const Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // Implement similar products section
          ],
        ),
      ),
    );
  }

  Widget purchaseButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // Implement add to cart functionality
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(
                  0xFF9683CE), // Use foregroundColor instead of primary
              side: const BorderSide(
                  color: Color(0xFF9683CE), width: 2.0), // Defines the border
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(10.0), // Rounded corners
              // ),
            ),
            child: const Text('Add to Cart'), // OutlinedButton
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              _showModalBottomSheet(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const CheckoutPage()),
              // );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9683ce)),
            child: const Text('Buy Now'),
          ),
        ),
      ],
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    int? selectedSize; // Tracks the selected size index
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bottomSheetContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Select Size',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RadioListTile<int>(
                    title: const Text('S'),
                    value: 0,
                    groupValue: selectedSize,
                    onChanged: (int? value) {
                      setState(() => selectedSize = value);
                    },
                    activeColor: const Color(0xFF9683ce),
                  ),
                  RadioListTile<int>(
                    title: const Text('M'),
                    value: 1,
                    groupValue: selectedSize,
                    onChanged: (int? value) {
                      setState(() => selectedSize = value);
                    },
                    activeColor: const Color(0xFF9683ce),
                  ),
                  RadioListTile<int>(
                    title: const Text('L'),
                    value: 2,
                    groupValue: selectedSize,
                    onChanged: (int? value) {
                      setState(() => selectedSize = value);
                    },
                    activeColor: const Color(0xFF9683ce),
                  ),
                  RadioListTile<int>(
                    title: const Text('XL'),
                    value: 3,
                    groupValue: selectedSize,
                    onChanged: (int? value) {
                      setState(() => selectedSize = value);
                    },
                    activeColor: const Color(0xFF9683ce),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: selectedSize != null
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CheckoutPage()),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9683ce),
                        minimumSize: const Size(double.infinity,
                            50) // Ensure button stretches to full width
                        ),
                    child: const Text('Continue'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
