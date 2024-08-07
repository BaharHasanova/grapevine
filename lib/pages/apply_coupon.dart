import 'package:flutter/material.dart';

class ApplyCouponPage extends StatefulWidget {
  const ApplyCouponPage({Key? key}) : super(key: key);

  @override
  _ApplyCouponPageState createState() => _ApplyCouponPageState();
}

class _ApplyCouponPageState extends State<ApplyCouponPage> {
  final List<Coupon> coupons = [
    Coupon(
      code: 'FIRST30',
      description:
          'Get 30% Cashback on your first order. Apply Code to Avail. Hurry up!',
      terms: 'View more',
    ),
    Coupon(
      code: 'NEW20',
      description:
          'Get 20% Cashback on orders above \$200. Apply Code to Avail. Hurry up!',
      terms:
          'Terms & conditions: coupon code can be only applied once in 2hrs. Cashback will be credited in the form of scratch card into bank account within 24hrs. Offer valid till 1st April 2022 12:00 PM.',
      expanded: true, // To demonstrate expanded state
    ),
    Coupon(
      code: 'ALL15',
      description:
          'Get 15% Cashback on the listed brands. Apply Code to Avail. Hurry up!',
      terms: 'View more',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply Coupon'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: coupons.isEmpty ? _buildNoCouponsFound() : _buildCouponList(),
    );
  }

  Widget _buildNoCouponsFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/not_found.png', // Ensure this asset exists
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 20),
          const Text(
            'No coupons found!',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search coupon',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: coupons.length,
              itemBuilder: (context, index) {
                return _buildCouponCard(coupons[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponCard(Coupon coupon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        title: Text(
          coupon.code,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          coupon.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: ElevatedButton(
          onPressed: () {
            // Implement coupon application logic
            print('Coupon ${coupon.code} applied!');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(color: Colors.blue),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Apply',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Text(
              coupon.expanded ? coupon.terms : '',
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                coupon.expanded = !coupon.expanded;
              });
            },
            child: Text(coupon.expanded ? 'View less' : 'View more'),
          ),
        ],
      ),
    );
  }
}

class Coupon {
  final String code;
  final String description;
  final String terms;
  bool expanded;

  Coupon({
    required this.code,
    required this.description,
    required this.terms,
    this.expanded = false,
  });
}
