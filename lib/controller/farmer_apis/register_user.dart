import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constants/AppConstants.dart';

class RegisterUserController extends GetxController {
  Future<void> registerUser(String email, String mobileNumber) async {
    final url =
        Uri.parse('${AppContants.baseUrl}/auth-farmer/register-user');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email, 'mobileNumber': mobileNumber});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // handle success
    } else {
      // handle error
    }
  }
}
