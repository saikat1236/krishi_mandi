import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import '../../constants/AppConstants.dart';

class RazorpayWebView extends StatelessWidget {
  final String orderId;
  final int amount;

  RazorpayWebView({required this.orderId, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Razorpay Payment')),
      body: WebView(
        initialUrl: 'https://your-server.com/razorpay/payment?order_id=$orderId&amount=${amount * 100}', // Create this endpoint on your server
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          // Any additional setup can be done here
        },
        onPageFinished: (String url) {
          // Handle success or failure after page load
          if (url.contains('success')) {
            // Handle successful payment here
            Get.snackbar('Payment Success', 'Payment completed successfully');
            Get.back(); // Go back to the previous screen
          } else if (url.contains('failure')) {
            // Handle payment failure here
            Get.snackbar('Payment Failed', 'Failed to complete the payment');
            Get.back(); // Go back to the previous screen
          }
        },
      ),
    );
  }
}
