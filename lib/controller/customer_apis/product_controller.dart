import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:krishi_customer_app/constants/AppConstants.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var products = [].obs;
  var categories= [].obs;

  String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OTdjM2QyNi01MTE5LTQzOGMtOTQ3Zi03ODkzZWUxZmNhMjIiLCJ1c2VyVHlwZSI6ImNvbnN1bWVyIiwiaWF0IjoxNzE2NDgwMTg0fQ.gCPwklJG6a-maKkZ2wNSss3XbLMF2hPXPE9660GdYbw";

  final String baseUrl = 'http://43.204.188.100:3000/users'; // Replace with your base URL

  @override
  void onInit() {
    super.onInit();
    getAllProducts(1); // Fetch products when controller initializes
    getAllcategories();
  }
  // Get all categories
    Future<void> getAllcategories() async {
    // isLoading(true);
    final url = Uri.parse('http://43.204.188.100:3000/users/get-available-categories');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': '${AppContants.apptoken}'
          'Authorization' : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OTdjM2QyNi01MTE5LTQzOGMtOTQ3Zi03ODkzZWUxZmNhMjIiLCJ1c2VyVHlwZSI6ImNvbnN1bWVyIiwiaWF0IjoxNzE2NDgwMTg0fQ.gCPwklJG6a-maKkZ2wNSss3XbLMF2hPXPE9660GdYbw'
          
        },
        body: jsonEncode({}),
      );

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body)["payload"];
        if (decodedResponse is List) {
          categories.value = decodedResponse;
        } else {
          categories.value = [];
        }
      } else {
        categories.value = [];
        print('Failed to load categories: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      categories.value = [];
    } finally {
      isLoading(false);
    }
  }

  // Get all products
  Future<void> getAllProducts(int page) async {
    // isLoading(true);
    final url = Uri.parse('$baseUrl/filtered');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': '${AppContants.apptoken}'
           'Authorization' : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OTdjM2QyNi01MTE5LTQzOGMtOTQ3Zi03ODkzZWUxZmNhMjIiLCJ1c2VyVHlwZSI6ImNvbnN1bWVyIiwiaWF0IjoxNzE2NDgwMTg0fQ.gCPwklJG6a-maKkZ2wNSss3XbLMF2hPXPE9660GdYbw'
          
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
          // 'Authorization': '${AppContants.apptoken}'
           'Authorization' : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OTdjM2QyNi01MTE5LTQzOGMtOTQ3Zi03ODkzZWUxZmNhMjIiLCJ1c2VyVHlwZSI6ImNvbnN1bWVyIiwiaWF0IjoxNzE2NDgwMTg0fQ.gCPwklJG6a-maKkZ2wNSss3XbLMF2hPXPE9660GdYbw'
          
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
          // 'Authorization': '${AppContants.apptoken}'
           'Authorization' : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OTdjM2QyNi01MTE5LTQzOGMtOTQ3Zi03ODkzZWUxZmNhMjIiLCJ1c2VyVHlwZSI6ImNvbnN1bWVyIiwiaWF0IjoxNzE2NDgwMTg0fQ.gCPwklJG6a-maKkZ2wNSss3XbLMF2hPXPE9660GdYbw'
          
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
