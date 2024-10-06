import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:krishi_customer_app/controller/customer_apis/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShippingAddressController extends GetxController {
  final String apiUrl = "https://backend.krishimandi.in/users";
  final UserController userController = Get.find<UserController>();

  bool _isDialogVisible = false;

  // Retrieve token from SharedPreferences
  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? ''; // Default to empty string if token is not found
  }

  // Method to show a loading dialog
  void _showLoadingDialog() {
    if (!_isDialogVisible) {
      Get.dialog(
        AlertDialog(
          contentPadding: EdgeInsets.all(20),
          content: SizedBox(
            width: 200,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Please wait...",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );
      _isDialogVisible = true;
    }
  }

  // Method to hide the loading dialog
  void _hideLoadingDialog() async {
    // Ensure dialog has at least been shown for 2 seconds
    await Future.delayed(Duration(seconds: 2));
    if (_isDialogVisible) {
      if (Get.isDialogOpen!) {
        Get.back(); // Close the loading dialog
      }
      _isDialogVisible = false;
    }
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
    // _showLoadingDialog(); // Show loading dialog
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
        Get.snackbar("Success", "Address added successfully");
        userController.getUserById(); // Update the user's profile
          // Get.back();
      } else {
        print("Failed to add address: ${response.body}");
        Get.snackbar("Error", "Failed to add address. Please try again.");
      }
    } catch (e) {
      print("Exception while adding address: $e");
      Get.snackbar("Error", "An error occurred. Please try again.");
    } finally {
      // _hideLoadingDialog(); // Hide loading dialog with a delay
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
    required String addressId,
  }) async {
    _showLoadingDialog(); // Show loading dialog
    try {
      final token = await _getToken();
      var response = await http.post(
        Uri.parse('$apiUrl/update-address'),
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
          "addressId": addressId,
          "default": false
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Address updated successfully");
        userController.getUserById(); // Update the user's profile
             await Future.delayed(Duration(seconds: 2));
      if (Get.isDialogOpen!) {
        Get.back(); // Close the loading dialog
      }
      } else {
        print("Failed to update address: ${response.body}");
        Get.snackbar("Error", "Failed to update address. Please try again.");
      }
    } catch (e) {
      print("Exception while updating address: $e");
      Get.snackbar("Error", "An error occurred. Please try again.");
    } finally {
      _hideLoadingDialog(); // Hide loading dialog with a delay
    }
  }

  // Method to delete address
  Future<void> deleteAddress({required String addressId}) async {
    _showLoadingDialog(); // Show loading dialog
    try {
      final token = await _getToken();
      var response = await http.post(
        Uri.parse('$apiUrl/removeAddress'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({
          "addressId": addressId,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Address deleted successfully");
        userController.getUserById(); // Update the user's profile
     await Future.delayed(Duration(seconds: 2));
      if (Get.isDialogOpen!) {
        Get.back(); // Close the loading dialog
      }
      } else {
        print("Failed to delete address: ${response.body}");
        Get.snackbar("Error", "Failed to delete address. Please try again.");
      }
    } catch (e) {
      print("Exception while deleting address: $e");
      Get.snackbar("Error", "An error occurred. Please try again.");
    } finally {
      _hideLoadingDialog(); // Hide loading dialog with a delay
    }
  }

  // Method to set an address as the default
  Future<void> setDefaultAddress({required String addressId}) async {
    _showLoadingDialog(); // Show loading dialog
    try {
      final token = await _getToken();
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
        Get.snackbar("Success", "Default address set successfully");
        userController.getUserById(); // Update the user's profile
      await Future.delayed(Duration(seconds: 2));
      if (Get.isDialogOpen!) {
        Get.back(); // Close the loading dialog
      }
      } else {
        print("Failed to set default address: ${response.body}");
        Get.snackbar("Error", "Failed to set default address. Please try again.");
      }
    } catch (e) {
      print("Exception while setting default address: $e");
      Get.snackbar("Error", "An error occurred. Please try again.");
    } finally {
      _hideLoadingDialog(); // Hide loading dialog with a delay
    }
  }
}
