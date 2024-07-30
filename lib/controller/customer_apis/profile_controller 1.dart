import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:krishi_customer_app/constants/AppConstants.dart';

class UserProfileController extends GetxController {
  var isLoading = false.obs;
  var userProfile = {}.obs;

  final String baseUrl = 'http://43.204.188.100:3000/users'; // Replace with your base URL

  @override
  void onInit() {
    super.onInit();
    getUserProfile(); // Fetch user profile when controller initializes
  }

  // Get user profile
  Future<void> getUserProfile() async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/get-user-profile');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${AppContants.apptoken}'
        },
      );

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
