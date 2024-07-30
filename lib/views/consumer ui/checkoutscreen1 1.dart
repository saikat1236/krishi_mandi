import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/constants/AppConstants.dart';
import 'package:krishi_customer_app/views/consumer%20ui/address.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Adding Shipping Address',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Shipping address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
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
                          AppContants.selectedAddress!['name'] ?? '',
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
                      (AppContants.selectedAddress!['addressLine1'] ?? '') +
                          ' ' +
                          (AppContants.selectedAddress!['addressLine2'] ?? '') +
                          ', ' +
                          (AppContants.selectedAddress!['city'] ?? '') +
                          ', ' +
                          (AppContants.selectedAddress!['pin']?.toString() ??
                              ''),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 16.0),
                    TextButton(
                      child: const Text('Change shipping address'),
                      onPressed: () {
                        Get.to(const ShippingAddressesScreen());
                      },
                    ),
                  ],
                ),
              ),
            )

            // child: ListTile(
            //   title: Text('Jane Doe',
            //       style: TextStyle(fontWeight: FontWeight.bold)),
            //   subtitle: Text(
            //       '3 Newbridge Court, Chino Hills, CA 91709, United States'),
            //   trailing: TextButton(
            //     onPressed: () {
            //       // Change address functionality
            //     },
            //     child: Text('Change', style: TextStyle(color: Colors.red)),
            //   ),
            // ),
            ,
            // SizedBox(height: 16),
            // Text('Payment',
            //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // SizedBox(height: 8),
            // Card(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12)),
            //   child: ListTile(
            //     leading: Image.asset('assets/cash_on_delivery.png',
            //         width: 40, height: 40),
            //     title: Text('Cash On Delivery',
            //         style: TextStyle(fontWeight: FontWeight.bold)),
            //     trailing: TextButton(
            //       onPressed: () {
            //         // Change payment method functionality
            //       },
            //       child: Text('Change', style: TextStyle(color: Colors.red)),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 16),
            // Text('Delivery method',
            //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // SizedBox(height: 8),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     _buildDeliveryMethodCard(
            //         'assets/fedex.png', 'FedEx', '2-3 days'),
            //     _buildDeliveryMethodCard('assets/usps.png', 'USPS', '2-3 days'),
            //   ],
            // ),
            const SizedBox(height: 16),
            const Divider(),
            _buildSummaryRow('Order:', '112\$'),
            _buildSummaryRow('Delivery:', '15\$'),
            _buildSummaryRow('Summary:', '127\$'),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Submit order functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'SUBMIT ORDER',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryMethodCard(
      String imagePath, String title, String subtitle) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(imagePath, width: 60, height: 60),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          Text(value,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
