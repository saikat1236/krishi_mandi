import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import this package to use jsonEncode
import 'package:krishi_customer_app/constants/AppConstants.dart';
import 'package:krishi_customer_app/controller/customer_apis/user_controller.dart';

class ShippingAddressController extends GetxController {
  final String apiUrl = "http://54.159.124.169:3000/users";
  final UserController userController = Get.find<UserController>();

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
      var response = await http.post(
        Uri.parse('$apiUrl/add-address'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIyZmU2YWM1Ni02OGRkLTQ5M2ItYWE5YS02MDNmNWQ4OWU5ODciLCJ1c2VyVHlwZSI6ImNvbnN1bWVyIiwiaWF0IjoxNzIzODM0NDMyfQ.66fTNMdmFGHJD5ivLze4QnRAu8YZmTQpyhoOJ08d6ak",
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
        Get.snackbar("Address added successfully", "Item has been added successfully to cart");
        userController.getUserById(); // Update the user's profile
      } else {
        print("Failed to add address: ${response.body}");
      }
    } catch (e) {
      print("Exception while adding address: $e");
    }
  }

  // Method to delete address by addressId
  Future<void> deleteAddress({required String addressId}) async {
    try {
      var response = await http.post(
        Uri.parse('http://54.159.124.169:3000/users/removeAddress'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIyZmU2YWM1Ni02OGRkLTQ5M2ItYWE5YS02MDNmNWQ4OWU5ODciLCJ1c2VyVHlwZSI6ImNvbnN1bWVyIiwiaWF0IjoxNzIzODM0NDMyfQ.66fTNMdmFGHJD5ivLze4QnRAu8YZmTQpyhoOJ08d6ak",
        },
        body: jsonEncode({
          "addressId": addressId,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Address deleted successfully", "Item has been removed successfully from cart");
        userController.getUserById(); // Update the user's profile
      } else {
        print("Failed to delete address: ${response.body}");
      }
    } catch (e) {
      print("Exception while deleting address: $e");
    }
  }
}
