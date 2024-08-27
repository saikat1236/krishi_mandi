import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:krishi_customer_app/controller/customer_apis/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController extends GetxController {
    final UserProfileController userProfileController = Get.put(UserProfileController());
  var isLoading = false.obs;
  var orders = [].obs;
   var errorMessage = ''.obs;

  final String baseUrl = 'http://54.159.124.169:3000/users'; // Replace with your base URL
    Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? ''; // Default to empty string if token is not found
  }
  // // Get all orders
  // Future<void> getAllOrders() async {
  //   isLoading(true);
  //   final url = Uri.parse('$baseUrl/getAll');

  //   try {
  //     final response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       orders.value = jsonDecode(response.body);
  //     } else {
  //       orders.value = [];
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     orders.value = [];
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  // Add a new order

  Future<void> createOrder(Map<String, dynamic> order) async {
    final url = 'http://54.159.124.169:3000/users/create-order';
    isLoading.value = true;
      final token = await _getToken();

    try {
      final response = await http.post(
        Uri.parse(url),
     headers :{
      'Content-Type': 'application/json',
      'Authorization': token, // Use token from SharedPreferences
    },
        body: jsonEncode(order),
      );

      if (response.statusCode == 200) {
        // Handle success
        Get.snackbar('Success', 'Order created successfully');
        // print('Response body: ${response.body}');
        userProfileController.getOrders();

        // You can navigate to the success screen or perform other actions here
      } else {
        // Handle error
        errorMessage.value = 'Failed to create order: ${response.reasonPhrase}';
        Get.snackbar('Error', errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
//  Future<void> addOrder(Map<String, dynamic> orderData) async {
//     isLoading(true);
//     final url = Uri.parse('$baseUrl/create-order');
//     final headers = {'Content-Type': 'application/json'};
//     final body = jsonEncode(orderData);

//     try {
//       final response = await http.post(url, headers: headers, body: body);
//       if (response.statusCode == 200) {
//         print('Order added successfully');
//         await userProfileController.getOrders(); // Refresh the list if needed
//       } else {
//         print('Failed to add order. Status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     } finally {
//       isLoading(false);
//     }
//   }

  // // Update an order
  // Future<void> updateOrder(String id, Map<String, dynamic> orderData) async {
  //   isLoading(true);
  //   final url = Uri.parse('$baseUrl/update/$id');
  //   final headers = {'Content-Type': 'application/json'};
  //   final body = jsonEncode(orderData);

  //   try {
  //     final response = await http.put(url, headers: headers, body: body);
  //     if (response.statusCode == 200) {
  //       await getAllOrders(); // Refresh the list
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  // Delete an order
  // Future<void> deleteOrder(String id) async {
  //   isLoading(true);
  //   final url = Uri.parse('$baseUrl/delete/$id');

  //   try {
  //     final response = await http.delete(url);
  //     if (response.statusCode == 200) {
  //       await getAllOrders(); // Refresh the list
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   } finally {
  //     isLoading(false);
  //   }
  // }
}


