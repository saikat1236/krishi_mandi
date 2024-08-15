import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  var isLoading = false.obs;
  var user = {}.obs;

  @override
  void onInit() {
    super.onInit();
    getUserById();
  }

  final String baseUrl = 'http://43.204.188.100:3000/user';

  // Add a new user
  Future<void> addUser(String name, String email, String phone) async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/add');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'name': name,
      'email': email,
      'phone': phone,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        user.value = jsonDecode(response.body);
      } else {
        user.value = {};
        print('Error: Failed to add user, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      user.value = {};
    } finally {
      isLoading(false);
    }
  }

  // Get user by ID
Future<void> getUserById() async {
  // isLoading(true);
  final url = Uri.parse('http://43.204.188.100:3000/users/get-user-profile');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OTdjM2QyNi01MTE5LTQzOGMtOTQ3Zi03ODkzZWUxZmNhMjIiLCJ1c2VyVHlwZSI6ImNvbnN1bWVyIiwiaWF0IjoxNzE2NDgwMTg0fQ.gCPwklJG6a-maKkZ2wNSss3XbLMF2hPXPE9660GdYbw',
  };
// Include any necessary data if needed

  try {
    final response = await http.post(url, headers: headers);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      // print('$jsonData');
user.value = jsonData['payload']['userProfile'];
      // Check if 'payload' and 'userProfile' exist
      if (jsonData.containsKey('payload') && jsonData['payload'].containsKey('userProfile')) {
        user.value = jsonData['payload']['userProfile'];
      } else {
        print('Error: Invalid JSON structure');
        user.value = {};
      }
    } else {
      print('Error: Failed to fetch data, status code: ${response.statusCode}');
      user.value = {};
    }
  } catch (e) {
    print('Error: $e');
    user.value = {};
  } finally {
    isLoading(false);
  }
}

}
