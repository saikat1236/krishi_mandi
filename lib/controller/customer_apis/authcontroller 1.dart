import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:krishi_customer_app/constants/AppConstants.dart';
import 'package:krishi_customer_app/global_auth.dart';
import 'package:krishi_customer_app/views/consumer%20ui/homescreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/otpdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isRegistered = false.obs;
  var isSignedIn = false.obs;
  var isOtpVerified = false.obs;
  RxString token = "".obs;

  final String baseUrl =
      'https://backend.krishimandi.in/auth'; // Replace with your base URL

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
      if (response.statusCode == 200) {
        isRegistered(true);
        Get.snackbar('Success', 'User registered successfully');
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
      if (response.statusCode == 200) {
        var respo = jsonDecode(response.body);
        if (respo["status"] ==false
           ) {
          Get.snackbar("Error", respo["message"]);
        } else {
          isSignedIn(true);
        }
      } else {
        isSignedIn(false);
      }
    } catch (e) {
      print('Error: $e');
      isSignedIn(false);
    } finally {
      isLoading(false);
    }
  }

  // Verify OTP
  Future<void> verifyOtp(String mobileNumber, String otp) async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/verify-otp');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'mobileNumber': mobileNumber,
      'otp': otp,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final token = jsonDecode(response.body)["payload"].toString();

        // Save the token in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        // Set the token in AppContants
        AppContants.apptoken = token;
        String auth_token = token;

        Get.find<GlobalController>().setAuthToken(auth_token);

        // Update state
        isOtpVerified(true);
        Get.to(HomePage());
      } else {
        isOtpVerified(false);
      }
    } catch (e) {
      print('Error: $e');
      isOtpVerified(false);
    } finally {
      isLoading(false);
    }
  }
}
