import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constants/AppConstants.dart';
class GetProductController extends GetxController {
  Future<void> getProduct(String productId) async {
    final url = Uri.parse('${AppContants.baseUrl}/products/$productId');
    final headers = {'Authorization': 'your_auth_token'};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // handle success
    } else {
      // handle error
    }
  }
}
