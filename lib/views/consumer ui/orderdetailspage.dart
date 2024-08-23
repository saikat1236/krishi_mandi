import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Order Details',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order No: 1947034',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('05-12-2019', style: TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 8.0),
            const Text('Tracking number: IW3475453455',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8.0),
            const Text('3 items', style: TextStyle(color: Colors.black)),
            const SizedBox(height: 16.0),
            _buildOrderItem('Potato', '51\$', 'assets/Small banner.png'),
            _buildOrderItem('Potato', '51\$', 'assets/Small banner.png'),
            _buildOrderItem('Potato', '51\$', 'assets/Small banner.png'),
            const SizedBox(height: 16.0),
            const Text('Order information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            _buildOrderInfoRow(
                'Shipping Address:', 'Belonia Boroj Colony, South Tripura'),
            _buildOrderInfoRow('Payment method:', 'Cash On Delivery'),
            // _buildOrderInfoRow('Delivery method:', 'FedEx, 3 days, 15\$'),
            _buildOrderInfoRow('Discount:', '10%, Personal promo code'),
            _buildOrderInfoRow('Total Amount:', '150\$', isBold: true),
            const SizedBox(height: 16.0),
            // const Center(child: GradientButton(label: "Shop Now"))
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Rounded edges
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15), // Button size
                ),
                onPressed: () {
                  // Get.to(widget.initialScreen);
                  // Add navigation or functionality here for consumer
                },
                child: const Text(
                  "Shop Now",
                  style: TextStyle(color: Colors.white,
                  fontSize: 20), // Text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(String name, String price, String imageUrl) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(color: Colors.green, width: 2),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(imageUrl, width: 50, height: 50),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(name, style: const TextStyle(fontSize: 16)),
            ),
            Text(price,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfoRow(String label, String value,
      {IconData? icon, Color? iconColor, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(icon, color: iconColor),
            ),
          Text(label, style: const TextStyle(color: Colors.grey)),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(value,
                style: TextStyle(
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          ),
        ],
      ),
    );
  }
}
