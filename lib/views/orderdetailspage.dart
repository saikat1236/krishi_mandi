import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order №1947034',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('05-12-2019', style: TextStyle(color: Colors.grey)),
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
            _buildOrderInfoRow('Shipping Address:',
                '3 Newbridge Court, Chino Hills, CA 91709, United States'),
            _buildOrderInfoRow('Payment method:', '**** **** **** 3947',
                icon: Icons.credit_card, iconColor: Colors.orange),
            _buildOrderInfoRow('Delivery method:', 'FedEx, 3 days, 15\$'),
            _buildOrderInfoRow('Discount:', '10%, Personal promo code'),
            _buildOrderInfoRow('Total Amount:', '133\$', isBold: true),
            const SizedBox(height: 16.0),
            const Center(child: GradientButton(label: "Shop Now"))
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

class GradientButton extends StatefulWidget {
  final String label;

  const GradientButton({super.key, required this.label});

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff52DB22), Color(0xff2C7512)], // White to dark green
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        child: Text(
          widget.label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
