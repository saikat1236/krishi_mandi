import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceOrderController extends GetxController {
  Future<void> placeOrder(Map<String, dynamic> orderDetails) async {
    final url = Uri.parse('http://54.159.124.169:3000/consumers/place-order');
    final headers = {
      'Authorization': 'your_auth_token',
      'Content-Type': 'application/json'
    };
    final body = jsonEncode(orderDetails);

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // handle success
    } else {
      // handle error
    }
  }
}
