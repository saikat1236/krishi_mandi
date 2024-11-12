import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constants/AppConstants.dart';
class RemoveItemFromCartController extends GetxController {
  Future<void> removeItemFromCart(String productId) async {
    final url =
        Uri.parse('${AppContants.baseUrl}/users/remove-item-from-cart');
    final headers = {
      'Authorization': 'your_auth_token',
      'Content-Type': 'application/json'
    };
    final body = jsonEncode({'productId': productId});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // handle success
    } else {
      // handle error
    }
  }
}
