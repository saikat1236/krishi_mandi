import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetOrdersController extends GetxController {
  Future<void> getOrders(String userId) async {
    final url = Uri.parse('http://43.204.188.100:3000/orders?userId=$userId');
    final headers = {'Authorization': 'your_auth_token'};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // handle success
    } else {
      // handle error
    }
  }
}
