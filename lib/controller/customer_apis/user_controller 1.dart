import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  var isLoading = false.obs;
  var user = {}.obs;

  final String baseUrl = 'http://54.159.124.169:3000/user'; // Replace with your base URL

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
      }
    } catch (e) {
      print('Error: $e');
      user.value = {};
    } finally {
      isLoading(false);
    }
  }

  // Get user by ID
  Future<void> getUserById(String id) async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/getById/$id');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        user.value = jsonDecode(response.body);
      } else {
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
