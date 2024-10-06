import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateCartItemQuantityController extends GetxController {
  Future<void> updateCartItemQuantity(String productId, int quantity) async {
    final url = Uri.parse(
        'https://backend.krishimandi.in/farmers/update-cart-item-quantity');
    final headers = {
      'Authorization': 'your_auth_token',
      'Content-Type': 'application/json'
    };
    final body = jsonEncode({'productId': productId, 'quantity': quantity});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // handle success
    } else {
      // handle error
    }
  }
}
