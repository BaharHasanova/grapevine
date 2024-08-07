import 'package:flutter/material.dart';
import 'package:flutter_test_application_1/pages/payment.dart';
import 'address.dart';
import 'apply_coupon.dart';
import 'cart_item.dart';

class CheckoutPage extends StatefulWidget {
  final String selectedSize; // Add this line to receive the size

  const CheckoutPage({Key? key, required this.selectedSize}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<CartItem> cartItems = [
    CartItem(
      name: 'Calvin Klein Regular fit slim fit shirt',
      description: 'Hooded Jacket',
      price: 300,
      imageUrl: 'https://link_to_image.jpg',
      selectedSize: 'M', // Default size (can be changed dynamically)
    ),
    // Add other items...
  ];

  List<Address> savedAddresses = [
    Address(
      name: 'David Guetta',
      mobileNumber: '1234567890',
      streetDetails: '2972 Westheimer Rd.',
      landmark: 'Near Shopping Center',
      state: 'Santa Ana',
      city: 'Illinois',
      pincode: '85486',
      addressType: 'Home',
      useAsDefault: true,
    ),
    Address(
      name: 'David Guetta',
      mobileNumber: '0987654321',
      streetDetails: '4517 Washington Ave.',
      landmark: 'Near Park',
      state: 'Manchester',
      city: 'Kentucky',
      pincode: '39495',
      addressType: 'Office',
      useAsDefault: false,
    ),
  ];

  // Define selectedAddress variable at the class level
  Address? selectedAddress;

  @override
  void initState() {
    super.initState();
    // Initialize selectedAddress with the first address or default address
    selectedAddress = savedAddresses.firstWhere(
      (address) => address.useAsDefault,
      orElse: () => savedAddresses[0],
    );

    // Update selected size for the first cart item as an example
    if (cartItems.isNotEmpty) {
      cartItems[0].selectedSize = widget.selectedSize;
    }

    updateDeliveryAddress();
  }

  String deliveryAddress = '';

  double get total => cartItems.fold(
        0,
        (previousValue, element) =>
            previousValue + element.price * element.quantity,
      );

  void updateDeliveryAddress() {
    deliveryAddress =
        '${selectedAddress!.name}\n${selectedAddress!.streetDetails}\n${selectedAddress!.city}, ${selectedAddress!.state} ${selectedAddress!.pincode}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Deliver to:", style: TextStyle(fontSize: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          deliveryAddress,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _showAddressSelectionPopup(context);
                        },
                        child: const Text("Change"),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      CartItem item = cartItems[index];
                      return Card(
                        key: ValueKey(item.name), // Ensure unique key
                        child: StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return ListTile(
                              leading: Image.network(item.imageUrl),
                              title: Text(item.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Display the selected size
                                  Text(
                                    'Selected Size: ${item.selectedSize}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  DropdownButton<String>(
                                    value: item.selectedSize,
                                    onChanged: (newValue) {
                                      if (newValue != null) {
                                        setState(() {
                                          item.selectedSize = newValue;
                                        });
                                      }
                                    },
                                    items: item.availableSizes.map((size) {
                                      return DropdownMenuItem<String>(
                                        value: size,
                                        child: Text(size),
                                      );
                                    }).toList(),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: item.quantity > 1
                                            ? () {
                                                setState(
                                                    () => item.decrement());
                                              }
                                            : null,
                                      ),
                                      Text('${item.quantity}'),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          setState(() => item.increment());
                                        },
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        cartItems.removeAt(index);
                                      });
                                    },
                                    child: const Text("Remove"),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text("Apply Coupon"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ApplyCouponPage()));
                    },
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total Payment",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('\$${total.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentPage()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9683ce),
                        minimumSize: const Size(double.infinity, 50)),
                    child:
                        const Text('Continue', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddressSelectionPopup(BuildContext context) async {
    Address? result = await showModalBottomSheet<Address>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Change Address",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              ...savedAddresses.map((address) {
                return ListTile(
                  title: Text(address.addressType),
                  subtitle: Text(
                      '${address.name}\n${address.streetDetails}\n${address.city}, ${address.state} ${address.pincode}'),
                  isThreeLine: true,
                  trailing: Radio<Address>(
                    value: address,
                    groupValue: selectedAddress,
                    onChanged: (Address? value) {
                      setState(() {
                        selectedAddress = value;
                        updateDeliveryAddress();
                        Navigator.pop(context, value);
                      });
                    },
                  ),
                );
              }).toList(),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context); // Close current sheet
                  var newAddress = await Navigator.push<Address>(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddressPage()),
                  );

                  if (newAddress != null) {
                    setState(() {
                      savedAddresses.add(newAddress);
                      selectedAddress =
                          newAddress; // Set new address as selected
                      updateDeliveryAddress(); // Update displayed address
                    });

                    // Show success dialog
                    _showSuccessDialog(context);
                  }
                },
                child: const Text("+ Add New Address"),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9683ce),
                  ),
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        );
      },
    );

    // Handle result after the bottom sheet is closed
    if (result != null) {
      setState(() {
        selectedAddress = result;
        updateDeliveryAddress();
      });
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Column(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 16),
              Text(
                'Address Added Successfully!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9683ce),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Done'),
              ),
            ),
          ],
        );
      },
    );
  }
}
