import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/views/consumer%20ui/homescreen.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsOrdered = order['productsOrdered'] as List<dynamic>;
    final paymentDetails = order['paymentDetails'];
    final address = order['address'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2E2E2E),
        elevation: 0,
                centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Order Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order No: ${order['orderId']} ',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                // Text(
                //   formatDate(order['dateAndTimeOrderPlaced']['\$date']),
                //   style: const TextStyle(color: Colors.black),
                // ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              'Tracking number: ${order['currentOrderStatus']['status']}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8.0),
            Text(
              '${productsOrdered.length} items',
              // "3 items",
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 16.0),
            ...productsOrdered.map((product) => _buildOrderItem(
              product['productName'],
              '₹${product['pricePerUnit']}',
              // 'assets/potato.png',
              product['image']??""
            )).toList(),
            const SizedBox(height: 16.0),
            const Text(
              'Order information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildOrderInfoRow(
              'Shipping Address:',
              '${address['name']}, ${address['addressLine1']}, ${address['addressLine2']}, ${address['city']}, ${address['pin']}',
            ),
            _buildOrderInfoRow('Payment method:', paymentDetails['paymentType']),
            _buildOrderInfoRow('Discount:', '10%, Personal promo code'),
            _buildOrderInfoRow('Total Amount:', '₹${order['totalAmount']}', isBold: true),
            const SizedBox(height: 16.0),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                child: const Text(
                  "Shop Now",
                  style: TextStyle(color: Colors.white, fontSize: 20), // Text color
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
                       Image.network(
  imageUrl,
  width: 50,
  height: 50, // Adjust image height ratio as needed
  fit: BoxFit.cover,
  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
    return Image.asset(
      'assets/no_image.jpg', // Path to your asset image
      width: 50,
      height: 50, // Adjust image height ratio as needed
      fit: BoxFit.cover,
    );
  },
),
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

  String formatDate(String dateStr) {
    final dateTime = DateTime.parse(dateStr);
    return '${dateTime.day}-${dateTime.month}-${dateTime.year}';
  }
}
