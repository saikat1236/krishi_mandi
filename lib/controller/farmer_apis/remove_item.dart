import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RemoveItemFromFavsController extends GetxController {
  Future<void> removeItemFromFavs(String productId) async {
    final url =
        Uri.parse('http://43.204.188.100:3000/farmers/remove-item-from-favs');
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
