import 'package:flutter/material.dart';

class PaymentFailureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Failed'),
      ),
      body: Center(
        child: Text('Your payment was unsuccessful. Please try again.'),
      ),
    );
  }
}
