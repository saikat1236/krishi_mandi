import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/constants/AppConstants.dart';
import 'package:krishi_customer_app/controller/customer_apis/profile_controller.dart';
import 'package:krishi_customer_app/views/consumer%20ui/add_address.dart';

class ShippingAddressesScreen extends StatefulWidget {
  const ShippingAddressesScreen({super.key});

  @override
  _ShippingAddressesScreenState createState() =>
      _ShippingAddressesScreenState();
}

class _ShippingAddressesScreenState extends State<ShippingAddressesScreen> {
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  int _selectedAddressIndex = 0;

  @override
  void initState() {
    super.initState();
    userProfileController.getUserProfile();
  }

  Future<void> _refreshData() async {
    await userProfileController.getUserProfile(); // Refresh user profile data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Shipping Address',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh,color:Colors.white),
            onPressed: _refreshData,
          ),
        ],
      ),
      body: Obx(() {
        if (userProfileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          var addresses = userProfileController.userProfile.value['payload']
              ['userProfile']['Address'];

          // Check if addresses is null or an empty list
          if (addresses == null || addresses.isEmpty) {
            return const Center(
              child: Text(
                'No addresses found',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }

          // If addresses is a list, iterate through it
          if (addresses is List) {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                return _buildAddressCard(addresses[index], index);
              },
            );
          }

          // If addresses is not a list (assuming it's a single address map)
          return _buildAddressCard(addresses, 0);
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddShippingAddressScreen());
          // Add new address functionality
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAddressCard(Map<String, dynamic> address, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  address['name'] ?? '',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    // Edit address functionality
                  },
                  child: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              (address['addressLine1'] ?? '') +
                  ' ' +
                  (address['addressLine2'] ?? '') +
                  ', ' +
                  (address['city'] ?? '') +
                  ', ' +
                  (address['pin']?.toString() ?? ''),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: _selectedAddressIndex == index,
                  onChanged: (bool? value) {
                    setState(() {
                      _selectedAddressIndex = index;
                      AppContants.selectedAddress = address;
                    });
                  },
                  activeColor: Colors.green,
                ),
                const Text('Use as the shipping address'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
