import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateUserController extends GetxController {
  Future<void> updateUser(
      String userId, Map<String, dynamic> userDetails) async {
    final url = Uri.parse('http://43.204.188.100:3000/users/$userId');
    final headers = {
      'Authorization': 'your_auth_token',
      'Content-Type': 'application/json'
    };
    final body = jsonEncode(userDetails);

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // handle success
    } else {
      // handle error
    }
  }
}
