import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:krishi_customer_app/constants/AppConstants.dart';
import 'package:krishi_customer_app/views/consumer%20ui/homescreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/otpdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmAuthController extends GetxController {
  var isLoading = false.obs;
  var isRegistered = false.obs;
  var isSignedIn = false.obs;
  var isOtpVerified = false.obs;
  RxString farmertoken = "".obs;

  final String baseUrl = '${AppContants.baseUrl}/auth-farmer'; // Replace with your base URL

  // Register a new user
  Future<void> registerUser(
      String userName, String email, String mobileNumber) async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/register-user');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'userName': userName,
      'email': email,
      'mobileNumber': mobileNumber,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      final respo = jsonDecode(response.body);
      if (respo["status"] == true) {
        isRegistered(true);
        // Get.snackbar('Success', 'User registered successfully');
      } else {
        isRegistered(false);
        Get.snackbar('Error', response.body);
      }
    } catch (e) {
      print('Error: $e');
      isRegistered(false);
    } finally {
      isLoading(false);
    }
  }

  // Sign in a user
  Future<void> signIn(String mobileNumber, BuildContext context) async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/sign-in');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'mobileNumber': mobileNumber});

    try {
      final response = await http.post(url, headers: headers, body: body);
        var respo = jsonDecode(response.body);
      if (respo["status"] == true) {
        // Get.snackbar("Otp has", respo["message"]);
        // print("1");7085959

          Get.snackbar("Otp has been sent Successfully", "");
          print("3");
          isSignedIn(true);

      } else {
        print("4");
        Get.snackbar("Error", respo["message"]);
        isSignedIn(false);
      }
    } catch (e) {
      // print("1");
      print('Error: $e');
      isSignedIn(false);
    } finally {
      print("1");
      isLoading(false);
    }
  }

  // Verify OTP
  Future<void> verifyOtp(String mobileNumber, String otp) async {
    // isLoading(true);
    int Intotp = int.parse(otp);
    final url = Uri.parse('$baseUrl/verify-otp');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'mobileNumber': mobileNumber,
      'otp': Intotp,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200 && jsonDecode(response.body)["status"].toString() == "true" ) {
        final farmertoken = jsonDecode(response.body)["payload"].toString();
          Get.snackbar('Success', 'User registered successfully');

        // Save the token in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('farmertoken', farmertoken);
        

        // Set the token in AppContants
        AppContants.apptoken = farmertoken;
        print("farmertoken "+farmertoken);

        // Update state
        isOtpVerified(true);
        Get.snackbar("OTP Verified Successfully", "");

    // Get.to(() => HomePage());
      } else {
        isOtpVerified(false);
        Get.snackbar(
        'Verification Failed',
        '',
        snackPosition: SnackPosition.TOP,
      );
      }
    } catch (e) {
      print('Error: $e');
      isOtpVerified(false);
    } finally {
      isLoading(false);
    }
  }
}
