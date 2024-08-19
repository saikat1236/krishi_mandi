import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/customer_apis/addresscontroller.dart';
import 'package:krishi_customer_app/models/address.dart';

class UpdShippingAddressScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final ShippingAddressController _controller = Get.put(ShippingAddressController());
final Address address;
 final TextEditingController _nameController;
  final TextEditingController _mobileController;
  final TextEditingController _emailController;
  final TextEditingController _addressLine1Controller;
  final TextEditingController _addressLine2Controller;
  final TextEditingController _cityController;
  final TextEditingController _pinController;

  UpdShippingAddressScreen({super.key, required this.address})
      : _nameController = TextEditingController(text: address.name),
        _mobileController = TextEditingController(text: address.mobile),
        _emailController = TextEditingController(text: address.email),
        _addressLine1Controller = TextEditingController(text: address.addressLine1),
        _addressLine2Controller = TextEditingController(text: address.addressLine2),
        _cityController = TextEditingController(text: address.city),
        _pinController = TextEditingController(text: address.pin.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
         onPressed: () {
    Navigator.pop(context);
  },
        ),
        title: const Text('Updating Shipping Address',
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
                _buildTextField(label: 'Mobile', controller: _mobileController),
                _buildTextField(label: 'Email', controller: _emailController),
                _buildTextField(label: 'Address Line 1', controller: _addressLine1Controller),
                _buildTextField(label: 'City', controller: _cityController),
                _buildTextField(label: 'Pin', controller: _pinController),
                const SizedBox(height: 16),
                // Container with a fixed height and width
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
                      }
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Update Address',
                      style: TextStyle(color: Colors.white, fontSize: 18),
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
          if (value == null || value.isEmpty) {
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
}
