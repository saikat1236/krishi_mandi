import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import this package to use jsonEncode
import 'package:krishi_customer_app/constants/AppConstants.dart';

class ShippingAddressController extends GetxController {
  final String apiUrl = "http://43.204.188.100:3000/farmers/add-address";

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
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "${AppContants.apptoken}", // Ensure AppConstants.apptoken is not null
        },
        body: jsonEncode({ // Convert the body to a JSON string
          "name": name,
          "mobile": mobile.toString(),
          "email": email,
          "addressLine1": addressLine1,
          "addressLine2": addressLine2,
          "city": city,
          "pin": pin.toString(),
        }),
      );

      if (response.statusCode == 200) {
        // Handle success, if needed
        Get.snackbar("Address added successfully", "Item has been added successfully to cart");
      } else {
        // Handle errors, if needed
        print("Failed to add address: ${response.body}");
      }
    } catch (e) {
      // Handle exceptions, if any
      print("Exception while adding address: $e");
    }
  }
}
