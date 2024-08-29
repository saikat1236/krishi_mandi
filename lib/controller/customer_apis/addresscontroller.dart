import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import this package to use jsonEncode
import 'package:krishi_customer_app/constants/AppConstants.dart';
import 'package:krishi_customer_app/controller/customer_apis/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShippingAddressController extends GetxController {
  final String apiUrl = "http://54.159.124.169:3000/users";
  final UserController userController = Get.find<UserController>();

    // Retrieve token from SharedPreferences
  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? ''; // Default to empty string if token is not found
  }
  

  // Method to add address
  Future<void> addAddress({
    
    required String name,
    required String mobile,
    required String email,
    required String addressLine1,
    required String addressLine2,
    required String city,
    required int pin,
  }) async {
    try {
      final token = await _getToken();
      var response = await http.post(
        Uri.parse('$apiUrl/add-address'),
        
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({
          "address": {
            "name": name,
            "mobile": mobile.toString(),
            "email": email,
            "addressLine1": addressLine1,
            "addressLine2": addressLine2,
            "city": city,
            "pin": pin.toString(),
          }
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Address added successfully", "");
        userController.getUserById(); // Update the user's profile
      } else {
        print("Failed to add address: ${response.body}");
      }
    } catch (e) {
      print("Exception while adding address: $e");
    }
  }


   // Method to update address
  Future<void> updateAddress({
    required String name,
    required String mobile,
    required String email,
    required String addressLine1,
    required String addressLine2,
    required String city,
    required int pin,
    required String addressId, // Add addressId to identify which address to update
  }) async {
    try {
      final token = await _getToken();
      var response = await http.post(
        Uri.parse('$apiUrl/update-address'), // Use correct endpoint
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({
          "name": name,
          "mobile": mobile,
          "email": email,
          "addressLine1": addressLine1,
          "addressLine2": addressLine2,
          "city": city,
          "pin": pin,
          "addressId":addressId,
          "default": false
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Address updated successfully", "");
        userController.getUserById(); // Update the user's profile or handle accordingly
      } else {
        print("Failed to update address: ${response.body}");
      }
    } catch (e) {
      print("Exception while updating address: $e");
    }
  }


  // Method to delete address by addressId
  Future<void> deleteAddress({required String addressId}) async {
       final token = await _getToken();
    try {
      var response = await http.post(
        Uri.parse('http://54.159.124.169:3000/users/removeAddress'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({
          "addressId": addressId,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Address deleted successfully", "");
        userController.getUserById(); // Update the user's profile
      } else {
        print("Failed to delete address: ${response.body}");
      }
    } catch (e) {
      print("Exception while deleting address: $e");
    }
  }

    // Method to set an address as the default
  Future<void> setDefaultAddress({required String addressId}) async {
    final token = await _getToken();
    try {
      var response = await http.post(
        Uri.parse('$apiUrl/set-default-address'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({
          "addressId": addressId,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Default address set successfully", "");
        userController.getUserById(); // Update the user's profile
      } else {
        print("Failed to set default address: ${response.body}");
      }
    } catch (e) {
      print("Exception while setting default address: $e");
    }
  }
}
