import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FarmController extends GetxController {



  var isLoading = false.obs;
  var farmer = {}.obs;

  @override
  void onInit() {
    super.onInit();
    getUserById();
  }

  final String baseUrl = 'http://54.159.124.169:3000/farmers';

  // Retrieve token from SharedPreferences
  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('farmertoken') ?? ''; // Default to empty string if token is not found
  }

  // Add a new user
  // Future<void> addUser(String name, String email, String phone) async {
  //   isLoading(true);
  //   final url = Uri.parse('$baseUrl/add');
  //   final headers = {'Content-Type': 'application/json'};
  //   final body = jsonEncode({
  //     'name': name,
  //     'email': email,
  //     'phone': phone,
  //   });

  //   try {
  //     final response = await http.post(url, headers: headers, body: body);
  //     if (response.statusCode == 200) {
  //       farmer.value = jsonDecode(response.body);
  //     } else {
  //       farmer.value = {};
  //       print('Error: Failed to add user, status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     farmer.value = {};
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  // Get user by ID
  Future<void> getUserById() async {
    isLoading(true);
    final url = Uri.parse('http://54.159.124.169:3000/farmers/get-user-profile');
      // Fetch the token from SharedPreferences
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
        final jsonData = jsonDecode(response.body);
        if (jsonData.containsKey('payload') && jsonData['payload'].containsKey('userProfile')) {
          farmer.value = jsonData['payload']['userProfile'];
          // update(); // Force update
        } else {
          print('Error: Invalid JSON structure');
          farmer.value = {};
        }
      } else {
        print('Error: Failed to fetch data, status code: ${response.statusCode}');
        farmer.value = {};
      }
    } catch (e) {
      print('Error: $e');
      farmer.value = {};
    } finally {
      isLoading(false);
    }
  }

  var isFavorite = false.obs;

  // Future<void> addFavorite(String productId,) async {
  //   final url = Uri.parse('http://54.159.124.169:3000/users/add-item-in-favs');
  //     final token = await _getToken();
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': token,
  //   };
  //   final body = jsonEncode({'productId': productId});

  //   try {
  //     final response = await http.post(url, headers: headers, body: body);
  //     if (response.statusCode == 200) {
  //       isFavorite(true); // Update the state to reflect the product is favorited
  //     } else {
  //       print('Failed to add favorite: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Exception while adding favorite: $e');
  //   }
  // }

  // Future<void> removeFavorite(String productId) async {
  //   final url = Uri.parse('http://54.159.124.169:3000/users/remove-item-from-favs');
  //     final token = await _getToken();
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': token,
  //   };
  //   final body = jsonEncode({'productId': productId});

  //   try {
  //     final response = await http.post(url, headers: headers, body: body);
  //     if (response.statusCode == 200) {
  //       isFavorite(false); // Update the state to reflect the product is not favorited
  //     } else {
  //       print('Failed to remove favorite: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Exception while removing favorite: $e');
  //   }
  // }

  // void toggleFavorite(String productId) {
  //   if (isFavorite.value) {
  //     removeFavorite(productId);
  //   } else {
  //     addFavorite(productId);
  //   }
  // }
}