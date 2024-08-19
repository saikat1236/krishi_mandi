import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddAddressController extends GetxController {
  Future<void> addAddress(String name, String mobile, String email,
      String addressLine1, String addressLine2, String city, int pin) async {
    final url = Uri.parse('http://54.159.124.169:3000/farmers/add-address');
    final headers = {
      'Authorization': 'your_auth_token',
      'Content-Type': 'application/json'
    };
    final body = jsonEncode({
      'name': name,
      'mobile': mobile,
      'email': email,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'pin': pin
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // handle success
    } else {
      // handle error
    }
  }
}
