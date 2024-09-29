import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/customer_apis/addresscontroller.dart';

class AddShippingAddressScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final ShippingAddressController _controller = Get.put(ShippingAddressController());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  AddShippingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Adding Shipping Address',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(label: 'Name', controller: _nameController),
                _buildMobileField(), // Use the new method for the mobile field
                _buildTextField(label: 'Email', controller: _emailController),
                _buildTextField(label: 'Address Line 1', controller: _addressLine1Controller),
                _buildOptionalTextField(label: 'Address Line 2', controller: _addressLine2Controller),
                _buildTextField(label: 'City', controller: _cityController),
                _buildPinField(), // Use the method for the pin field
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _controller.addAddress(
                          name: _nameController.text,
                          mobile: _mobileController.text,
                          email: _emailController.text,
                          addressLine1: _addressLine1Controller.text,
                          addressLine2: _addressLine2Controller.text,
                          city: _cityController.text,
                          pin: int.tryParse(_pinController.text) ?? 0,
                        );
                        Get.back(); // Move this to inside the validation
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'SAVE ADDRESS',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          // Check if the field is empty, but skip validation for Address Line 2
          if (label != 'Address Line 2' && (value == null || value.isEmpty)) {
            return 'Please enter $label';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionalTextField(
      {required String label, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  // New method for the mobile field
  Widget _buildMobileField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: _mobileController,
        validator: (value) {
          // Validate the mobile field
          if (value == null || value.isEmpty) {
            return 'Please enter Mobile Number';
          }
          return null;
        },
        keyboardType: TextInputType.phone, // Open numeric keypad
        decoration: InputDecoration(
          labelText: 'Mobile',
          labelStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  // Method for the pin field
  Widget _buildPinField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: _pinController,
        validator: (value) {
          // Validate the pin field
          if (value == null || value.isEmpty) {
            return 'Please enter Pin';
          }
          return null;
        },
        keyboardType: TextInputType.number, // Open numeric keypad
        decoration: InputDecoration(
          labelText: 'Pin',
          labelStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
