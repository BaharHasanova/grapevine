import 'package:flutter/material.dart';

// Define a simple Address model
class Address {
  final String name;
  final String mobileNumber;
  final String streetDetails;
  final String landmark;
  final String state;
  final String city;
  final String pincode;
  final String addressType;
  final bool useAsDefault;

  Address({
    required this.name,
    required this.mobileNumber,
    required this.streetDetails,
    required this.landmark,
    required this.state,
    required this.city,
    required this.pincode,
    required this.addressType,
    required this.useAsDefault,
  });
}

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String mobileNumber = '';
  String streetDetails = '';
  String landmark = '';
  String state = '';
  String city = '';
  String pincode = '';
  String addressType = 'Home';
  bool useAsDefault = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Address'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        // Make content scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  label: 'Name',
                  onChanged: (value) => name = value,
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  label: 'Mobile Number',
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => mobileNumber = value,
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  label: 'Flat No. Street Details',
                  onChanged: (value) => streetDetails = value,
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  label: 'Landmark',
                  onChanged: (value) => landmark = value,
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  label: 'State',
                  onChanged: (value) => state = value,
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  label: 'City/District',
                  onChanged: (value) => city = value,
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  label: 'Pincode',
                  keyboardType: TextInputType.number,
                  onChanged: (value) => pincode = value,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Address Type',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Home'),
                        value: 'Home',
                        groupValue: addressType,
                        onChanged: (value) {
                          setState(() {
                            addressType = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Office'),
                        value: 'Office',
                        groupValue: addressType,
                        onChanged: (value) {
                          setState(() {
                            addressType = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                CheckboxListTile(
                  title: const Text('Use as default address'),
                  value: useAsDefault,
                  onChanged: (bool? value) {
                    setState(() {
                      useAsDefault = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Create a new address instance
                        Address newAddress = Address(
                          name: name,
                          mobileNumber: mobileNumber,
                          streetDetails: streetDetails,
                          landmark: landmark,
                          state: state,
                          city: city,
                          pincode: pincode,
                          addressType: addressType,
                          useAsDefault: useAsDefault,
                        );

                        // Show success dialog before returning to the previous screen
                        _showSuccessDialog().then((_) {
                          // Return the new address to the previous screen after the dialog is dismissed
                          Navigator.pop(context, newAddress);
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9683ce),
                    ),
                    child: const Text('Continue'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    TextInputType keyboardType = TextInputType.text,
    required ValueChanged<String> onChanged,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }

  Future<void> _showSuccessDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Color(0xFF9683ce),
                size: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                'Address Added Successfully!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9683ce),
                  ),
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
