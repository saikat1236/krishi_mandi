import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/AppConstants.dart';

class ConsumerController extends GetxController {
  var isLoading = false.obs;
  var consumers = [].obs;

  final String baseUrl = '${AppContants.baseUrl}/consumer'; // Replace with your base URL
  // final String baseUrl = 'https://backend.krishimandi.in/consumer'; // Replace with your base URL

  // Get all consumers
  Future<void> getAllConsumers() async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/getAll');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        consumers.value = jsonDecode(response.body);
      } else {
        consumers.value = [];
      }
    } catch (e) {
      print('Error: $e');
      consumers.value = [];
    } finally {
      isLoading(false);
    }
  }

  // Add a new consumer
  Future<void> addConsumer(Map<String, dynamic> consumerData) async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/add');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(consumerData);

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        await getAllConsumers(); // Refresh the list
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  // Update a consumer
  Future<void> updateConsumer(String id, Map<String, dynamic> consumerData) async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/update/$id');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(consumerData);

    try {
      final response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        await getAllConsumers(); // Refresh the list
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  // Delete a consumer
  Future<void> deleteConsumer(String id) async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/delete/$id');

    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        await getAllConsumers(); // Refresh the list
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
