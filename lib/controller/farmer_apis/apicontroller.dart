import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiEndpoints {
  static const String baseUrl = 'http://54.159.124.169:3000';

  static const String signIn = '$baseUrl/auth-farmer/sign-in';
  static const String verifyOtp = '$baseUrl/auth-farmer/verify-otp';
  static const String registerUser = '$baseUrl/auth-farmer/register-user';
  static const String addItemToCart = '$baseUrl/cart/add-item';
  static const String removeItemFromCart = '$baseUrl/cart/remove-item';
  static const String createOrder = '$baseUrl/order/create';
  static const String getOrderDetails = '$baseUrl/order/details';
  static const String changeOrderStatus = '$baseUrl/order/status';
  static const String getAllOrders = '$baseUrl/order/all';
  static const String getFarmerProfile = '$baseUrl/farmers/get-user-profile';
  static const String updateFarmerProfile = '$baseUrl/farmers/update-profile';
  static const String deleteFarmerProfile = '$baseUrl/farmers/delete-profile';
  static const String getFarmerCart = '$baseUrl/cart/get-farmer-cart';
  static const String predictByUploadingImage = '$baseUrl/farmers/predict-quality';
  static const String predictUsingUrl = '$baseUrl/farmers/predict-quality';
  static const String listCartItems = '$baseUrl/farmers/get-cart-items';
  static const String listOrders = '$baseUrl/farmers/get-orders-list';
  static const String getAddress = '$baseUrl/farmers/get-addresses';
  static const String getFavs = '$baseUrl/farmers/get-favs-list';
}

class ApiController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController productIdController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController cartIdController = TextEditingController();
  final TextEditingController orderIdController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController profileDataController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController orderDetailsController = TextEditingController();

  static const Map<String, String> headers = {
    'Authorization': 'your_jwt_token',
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<void> signIn() async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.signIn),
      headers: headers,
      body: jsonEncode(<String, String>{
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Signed in successfully');
    } else {
      Get.snackbar('Error', 'Failed to sign in');
    }
  }

  Future<void> verifyOtp() async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.verifyOtp),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        'mobileNumber': mobileNumberController.text,
        'otp': otpController.text,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'OTP verified successfully');
    } else {
      Get.snackbar('Error', 'Failed to verify OTP');
    }
  }

  Future<void> registerUser() async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.registerUser),
      headers: headers,
      body: jsonEncode(<String, String>{
        'email': emailController.text,
        'mobileNumber': mobileNumberController.text,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Registered successfully');
    } else {
      Get.snackbar('Error', 'Failed to register');
    }
  }

  Future<void> addItemToCart() async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.addItemToCart),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        'productId': productIdController.text,
        'quantity': int.parse(quantityController.text),
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Item added to cart successfully');
    } else {
      Get.snackbar('Error', 'Failed to add item to cart');
    }
  }

  Future<void> removeItemFromCart() async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.removeItemFromCart),
      headers: headers,
      body: jsonEncode(<String, String>{
        'productId': productIdController.text,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Item removed from cart successfully');
    } else {
      Get.snackbar('Error', 'Failed to remove item from cart');
    }
  }

  Future<void> createOrder() async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.createOrder),
      headers: headers,
      body: jsonEncode(<String, String>{
        'cartId': cartIdController.text,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Order created successfully');
    } else {
      Get.snackbar('Error', 'Failed to create order');
    }
  }

  Future<void> getOrderDetails() async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.getOrderDetails),
      headers: headers,
      body: jsonEncode(<String, String>{
        'orderId': orderIdController.text,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Order details fetched successfully');
    } else {
      Get.snackbar('Error', 'Failed to fetch order details');
    }
  }

  Future<void> changeOrderStatus() async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.changeOrderStatus),
      headers: headers,
      body: jsonEncode(<String, String>{
        'orderId': orderIdController.text,
        'status': statusController.text,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Order status changed successfully');
    } else {
      Get.snackbar('Error', 'Failed to change order status');
    }
  }

  Future<void> getAllOrders() async {
    final response = await http.get(
      Uri.parse(ApiEndpoints.getAllOrders),
      headers: headers,
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'All orders fetched successfully');
    } else {
      Get.snackbar('Error', 'Failed to fetch orders');
    }
  }

  Future<void> getFarmerProfile() async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.getFarmerProfile),
      headers: headers,
      body: jsonEncode(<String, String>{
        'userId': userIdController.text,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Farmer profile fetched successfully');
    } else {
      Get.snackbar('Error', 'Failed to fetch farmer profile');
    }
  }

  Future<void> updateFarmerProfile() async {
    final response = await http.put(
      Uri.parse(ApiEndpoints.updateFarmerProfile),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        'userId': userIdController.text,
        'profileData': profileDataController.text,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Farmer profile updated successfully');
    } else {
      Get.snackbar('Error', 'Failed to update farmer profile');
    }
  }

  Future<void> deleteFarmerProfile() async {
    final response = await http.delete(
      Uri.parse(ApiEndpoints.deleteFarmerProfile),
      headers: headers,
      body: jsonEncode(<String, String>{
        'userId': userIdController.text,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Farmer profile deleted successfully');
    } else {
      Get.snackbar('Error', 'Failed to delete farmer profile');
    }
  }

  Future<void> getFarmerCart() async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.getFarmerCart),
      headers: headers,
      body: jsonEncode(<String, String>{
        'userId': userIdController.text,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Farmer cart fetched successfully');
    } else {
      Get.snackbar('Error', 'Failed to fetch farmer cart');
    }
  }

  Future<void> predictByUploadingImage(String filePath) async {
    var request = http.MultipartRequest('POST', Uri.parse(ApiEndpoints.predictByUploadingImage))
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('file', filePath));

    var response = await request.send();
    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Image uploaded and prediction successful');
    } else {
      Get.snackbar('Error', 'Failed to upload image for prediction');
    }
  }

  Future<void> predictUsingUrl() async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.predictUsingUrl),
      headers: headers,
      body: jsonEncode(<String, String>{
        'imageUrl': urlController.text,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Prediction using URL successful');
    } else {
      Get.snackbar('Error', 'Failed to predict using URL');
    }
  }

  Future<void> listCartItems() async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.listCartItems),
      headers: headers,
      body: jsonEncode(<String, String>{
        'userId': userIdController.text,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Cart items fetched successfully');
    } else {
      Get.snackbar('Error', 'Failed to fetch cart items');
    }
  }

  Future<void> listOrders() async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.listOrders),
      headers: headers,
      body: jsonEncode(<String, String>{
        'userId': userIdController.text,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Orders list fetched successfully');
    } else {
      Get.snackbar('Error', 'Failed to fetch orders list');
    }
  }

  Future<void> getAddress() async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.getAddress),
      headers: headers,
      body: jsonEncode(<String, String>{
        'userId': userIdController.text,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Addresses fetched successfully');
    } else {
      Get.snackbar('Error', 'Failed to fetch addresses');
    }
  }

  Future<void> getFavs() async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.getFavs),
      headers: headers,
      body: jsonEncode(<String, String>{
        'userId': userIdController.text,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Favorites fetched successfully');
    } else {
      Get.snackbar('Error', 'Failed to fetch favorites');
    }
  }
}
