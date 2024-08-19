import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileController extends GetxController {
  var isLoading = false.obs;
  var userProfile = {}.obs;

  final String baseUrl = 'http://54.159.124.169:3000/users'; // Replace with your base URL

  @override
  void onInit() {
    super.onInit();
    getUserProfile(); // Fetch user profile when controller initializes
  }

  // Retrieve token from SharedPreferences
  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? ''; // Default to empty string if token is not found
  }

  // Get user profile
  Future<void> getUserProfile() async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/get-user-profile');
    final token = await _getToken();
  print('Token fetched from SharedPreferences: $token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': token, // Use token from SharedPreferences
      // 'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJiMzg0MzcwNC1mMTczLTRkYWUtODM2YS0wODQ3NTI1YjZlNjkiLCJ1c2VyVHlwZSI6ImNvbnN1bWVyIiwiaWF0IjoxNzIzODMwNDA4fQ.AMHrZdJf8GGWnzwteVXJqH5Yx4-iahH9alaBS6FFPyc'
    };
    try {
      final response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        if (decodedResponse is Map<String, dynamic>) {
          userProfile.value = decodedResponse;
        } else {
          userProfile.value = {};
        }
      } else {
        userProfile.value = {};
        print('Failed to load user profile: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      userProfile.value = {};
    } finally {
      isLoading(false);
    }
  }
}
