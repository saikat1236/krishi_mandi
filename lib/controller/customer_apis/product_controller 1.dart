import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:krishi_customer_app/constants/AppConstants.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var products = [].obs;

  final String baseUrl = 'http://54.159.124.169:3000/users'; // Replace with your base URL

  @override
  void onInit() {
    super.onInit();
    getAllProducts(1); // Fetch products when controller initializes
  }

  // Get all products
  Future<void> getAllProducts(int page) async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/filtered');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${AppContants.apptoken}'
        },
        body: jsonEncode({
          'categories': [],
          'page': page,
          'limit': 10,
        }),
      );

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body)["payload"];
        if (decodedResponse is List) {
          products.value = decodedResponse;
        } else {
          products.value = [];
        }
      } else {
        products.value = [];
        print('Failed to load products: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      products.value = [];
    } finally {
      isLoading(false);
    }
  }

  // Add item to favorites
  Future<void> addToFavorites(Map<String, dynamic> favItem) async {
    final url = Uri.parse('$baseUrl/add-item-in-favs');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${AppContants.apptoken}'
        },
        body: jsonEncode({'favItem': favItem}),
      );

      if (response.statusCode == 200) {
        print('Item added to favorites: ${response.body}');
        // Implement any state management logic if needed
      } else {
        print('Failed to add item to favorites: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Add item to cart
  Future<bool> addToCart(Map<String, dynamic> cartItem) async {
    final url = Uri.parse('$baseUrl/add-item-in-cart');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${AppContants.apptoken}'
        },
        body: jsonEncode({'cartItem': cartItem}),
      );

      if (response.statusCode == 200) {
        print('Item added to cart: ${response.body}');
        // Implement any state management logic if needed
        return true; // Return true if successfully added to cart
      } else {
        print('Failed to add item to cart: ${response.body}');
        return false; // Return false on failure
      }
    } catch (e) {
      print('Error: $e');
      return false; // Return false on error
    }
  }
}
