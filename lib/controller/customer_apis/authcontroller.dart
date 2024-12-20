import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:krishi_customer_app/constants/AppConstants.dart';
import 'package:krishi_customer_app/views/consumer%20ui/homescreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/otpdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isRegistered = false.obs;
  var isSignedIn = false.obs;
  var isOtpVerified = false.obs;
  RxString token = "".obs;

  final String baseUrl = '${AppContants.baseUrl}/auth';
  // final String baseUrl = 'https://backend.krishimandi.in/auth'; // Replace with your base URL

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
        // Get.snackbar('Success', 'User registered success
        // fully');
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
      final resp = json.decode(response.body);
      print(resp);
      if (response.statusCode == 200) {
        var respo = jsonDecode(response.body);
        // Get.snackbar("Otp has", respo["message"]);
        // print("1");7085959
        if (respo["status"] ==false
           ) {
          Get.snackbar("Error", respo["message"]);
          print("if if");
        } else {
          Get.snackbar("Otp has been sent Successfully", "");
          print("if else");
          isSignedIn(true);
        }
      } else {
        print("else");
        isSignedIn(false);
      }
    } catch (e) {
      // print("1");
      print('Error: $e');
      isSignedIn(false);
    } finally {
      print("finally");
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
        final token = jsonDecode(response.body)["payload"].toString();
          Get.snackbar('Success', 'User registered successfully');

        // Save the token in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        // Set the token in AppContants
        AppContants.apptoken = token;
        print("token "+token);

        // Update state
        isOtpVerified(true);
        Get.snackbar("OTP Verified Successfully", "");
        // return true;

    // Get.to(() => HomePage());
      } else {
        isOtpVerified(false);
        Get.snackbar(
        'Verification Failed',
        '',
        snackPosition: SnackPosition.TOP,
      );
        // return false;
      }
    } catch (e) {
      print('Error: $e');
      isOtpVerified(false);
          // return false;
    } finally {
      isLoading(false);
    }
  }
}
