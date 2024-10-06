import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  var isLoading = false.obs;
  var orders = [].obs;

  final String baseUrl = 'https://backend.krishimandi.in/order'; // Replace with your base URL

  // Get all orders
  Future<void> getAllOrders() async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/getAll');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        orders.value = jsonDecode(response.body);
      } else {
        orders.value = [];
      }
    } catch (e) {
      print('Error: $e');
      orders.value = [];
    } finally {
      isLoading(false);
    }
  }

  // Add a new order
  Future<void> addOrder(Map<String, dynamic> orderData) async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/add');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(orderData);

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        await getAllOrders(); // Refresh the list
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  // Update an order
  Future<void> updateOrder(String id, Map<String, dynamic> orderData) async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/update/$id');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(orderData);

    try {
      final response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        await getAllOrders(); // Refresh the list
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  // Delete an order
  Future<void> deleteOrder(String id) async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/delete/$id');

    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        await getAllOrders(); // Refresh the list
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
