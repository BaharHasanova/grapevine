import 'package:flutter/material.dart';

class AddNewCardPage extends StatelessWidget {
  const AddNewCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Card'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField('Card Number', TextInputType.number),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child:
                        _buildTextField('Expiry Date', TextInputType.datetime)),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField('CVV', TextInputType.number)),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextField('Card Holder Name', TextInputType.name),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Handle card addition logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0000FF),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Add Card',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, TextInputType inputType) {
    return TextField(
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
