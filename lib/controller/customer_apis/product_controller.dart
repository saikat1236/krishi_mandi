import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var products = [].obs;
  var categories = [].obs;

  final String baseUrl = 'http://54.159.124.169:3000/users'; // Replace with your base URL

  @override
  void onInit() {
    super.onInit();
    getAllProducts(1); // Fetch products when controller initializes
    getAllCategories();
  }

  // Retrieve token from SharedPreferences
  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? ''; // Default to empty string if token is not found
  }

  // Get all categories
  Future<void> getAllCategories() async {
    // isLoading(true);
    final url = Uri.parse('http://54.159.124.169:3000/users/get-available-categories');
    final token = await _getToken();
  print('Token fetched from SharedPreferences: $token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': token, // Use token from SharedPreferences
            // 'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJiMzg0MzcwNC1mMTczLTRkYWUtODM2YS0wODQ3NTI1YjZlNjkiLCJ1c2VyVHlwZSI6ImNvbnN1bWVyIiwiaWF0IjoxNzIzODMwNDA4fQ.AMHrZdJf8GGWnzwteVXJqH5Yx4-iahH9alaBS6FFPyc'
    };
    try {
       final response = await http.post(url, headers: headers);

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
      final token = await _getToken(); // Get token from SharedPreferences
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token // Use token from SharedPreferences
          //  'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJiMzg0MzcwNC1mMTczLTRkYWUtODM2YS0wODQ3NTI1YjZlNjkiLCJ1c2VyVHlwZSI6ImNvbnN1bWVyIiwiaWF0IjoxNzIzODMwNDA4fQ.AMHrZdJf8GGWnzwteVXJqH5Yx4-iahH9alaBS6FFPyc'
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
      final token = await _getToken(); // Get token from SharedPreferences
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $token' // Use token from SharedPreferences
           'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIyZmU2YWM1Ni02OGRkLTQ5M2ItYWE5YS02MDNmNWQ4OWU5ODciLCJ1c2VyVHlwZSI6ImNvbnN1bWVyIiwiaWF0IjoxNzIzODM0NDMyfQ.66fTNMdmFGHJD5ivLze4QnRAu8YZmTQpyhoOJ08d6ak'
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
      final token = await _getToken(); // Get token from SharedPreferences
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token' // Use token from SharedPreferences
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
