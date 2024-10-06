import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddToFavoritesController extends GetxController {
  Future<void> addToFavorites(String productId) async {
    final url = Uri.parse('https://backend.krishimandi.in/users/add-to-favorites');
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
