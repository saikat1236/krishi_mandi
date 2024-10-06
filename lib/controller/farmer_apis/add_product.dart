import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddProductController extends GetxController {
  Future<void> addProduct(
      String productName,
      String productInfo,
      List<String> productImages,
      double pricePerUnit,
      String productUnitType) async {
    final url = Uri.parse('https://backend.krishimandi.in/farmers/add-product');
    final headers = {
      'Authorization': 'your_auth_token',
      'Content-Type': 'application/json'
    };
    final body = jsonEncode({
      'productName': productName,
      'productInfo': productInfo,
      'productImages': productImages,
      'pricePerUnit': pricePerUnit,
      'productUnitType': productUnitType
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // handle success
    } else {
      // handle error
    }
  }
}
