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
        title: const Text(
          'Adding Shipping Address',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Field
                _buildTextField(
                  label: 'Name',
                  controller: _nameController,
                  isRequired: true,
                ),
                // Mobile Field with Real-Time Validation
                _buildMobileField(),
                // Email Field
                _buildEmailField(),
                // _buildTextField(
                //   label: 'Email',
                //   controller: _emailController,
                //   isRequired: true,
                // ),
                // Address Line 1
                _buildTextField(
                  label: 'Address Line 1',
                  controller: _addressLine1Controller,
                  isRequired: true,
                ),
                // Address Line 2 (Optional)
                _buildTextField(
                  label: 'Address Line 2',
                  controller: _addressLine2Controller,
                  isRequired: false,
                ),
                // City Field
                _buildTextField(
                  label: 'City',
                  controller: _cityController,
                  isRequired: true,
                ),
                // Pin Field
                _buildPinField(),
                const SizedBox(height: 16),
                // Save Address Button
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required bool isRequired,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
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

  Widget _buildMobileField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: _mobileController,
        keyboardType: TextInputType.phone,
        onChanged: (value) {
          if (value.length == 10) {
            // Trigger validation
            _formKey.currentState?.validate();
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Mobile Number';
          } else if (value.length != 10 || !RegExp(r'^\d+$').hasMatch(value)) {
            return 'Mobile Number must be 10 digits only';
          }
          return null;
        },
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


  Widget _buildEmailField() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress, // Opens email-specific keyboard
      onChanged: (value) {
        // Trigger validation on input change
        _formKey.currentState?.validate();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Email';
        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid Email address';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  );
}


  Widget _buildPinField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: _pinController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Pin';
          } else if (value.length != 6 || !RegExp(r'^\d+$').hasMatch(value)) {
            return 'Pin must be 6 digits';
          }
          return null;
        },
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

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            // Save address via controller
            _controller.addAddress(
              name: _nameController.text,
              mobile: _mobileController.text,
              email: _emailController.text,
              addressLine1: _addressLine1Controller.text,
              addressLine2: _addressLine2Controller.text.isNotEmpty
                  ? _addressLine2Controller.text
                  : '', // Fallback for optional field
              city: _cityController.text,
              pin: int.tryParse(_pinController.text) ?? 0,
            );
            Get.back(); // Go back after saving
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
    );
  }
}
