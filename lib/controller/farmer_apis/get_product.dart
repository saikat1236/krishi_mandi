import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetProductController extends GetxController {
  Future<void> getProduct(String productId) async {
    final url = Uri.parse('https://backend.krishimandi.in/products/$productId');
    final headers = {'Authorization': 'your_auth_token'};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // handle success
    } else {
      // handle error
    }
  }
}
