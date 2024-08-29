import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var products = [].obs;
  var categories = [].obs;
  var favoriteProducts = [].obs;

  final String baseUrl = 'http://54.159.124.169:3000/users'; // Replace with your base URL

  @override
  void onInit() {
    super.onInit();
    getAllProducts(1); // Fetch products when controller initializes
    getAllCategories();
    getFavoriteProducts(); // Fetch favorite products
  }

  // Retrieve token from SharedPreferences
  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? ''; // Default to empty string if token is not found
  }

  // Get all categories
  Future<void> getAllCategories() async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/get-available-categories');
    final token = await _getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': token, // Use token from SharedPreferences
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
    final url = Uri.parse('$baseUrl/filtered');

    try {
      final token = await _getToken(); // Get token from SharedPreferences
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token // Use token from SharedPreferences
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
        print('Failed to load products');
      }
    } catch (e) {
      print('Error: $e');
      products.value = [];
    } finally {
      isLoading(false);
    }
  }

  // Get filtered products by category
  Future<void> getFilteredProducts(List<String> selectedCategories) async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/filtered');

    try {
      final token = await _getToken(); // Get token from SharedPreferences
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token // Use token from SharedPreferences
        },
        body: jsonEncode({
          'categories': selectedCategories,
          'page': 1,
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
        print('Failed to load products');
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
          'Authorization': token // Use token from SharedPreferences
        },
        body: jsonEncode({'favItem': favItem}),
      );

      if (response.statusCode == 200) {
        favoriteProducts.add(favItem['_id']);
        Get.snackbar('Favorites', 'Product added to favorites!',
            snackPosition: SnackPosition.TOP);
      } else {
        print('Failed to add item to favorites: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Remove item from favorites
  Future<void> removeFromFavorites(String productId) async {
    final url = Uri.parse('$baseUrl/remove-item-from-favs');

    try {
      final token = await _getToken(); // Get token from SharedPreferences
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token // Use token from SharedPreferences
        },
        body: jsonEncode({'productId': productId}),
      );

      if (response.statusCode == 200) {
        favoriteProducts.remove(productId);
        Get.snackbar('Favorites', 'Product removed from favorites!',
            snackPosition: SnackPosition.TOP);
      } else {
        print('Failed to remove item from favorites: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Check if product is in favorites
  bool isProductFavorite(String productId) {
    return favoriteProducts.contains(productId);
  }

  // Fetch favorite products
  Future<void> getFavoriteProducts() async {
    // Implement fetching favorite products if needed
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
          'Authorization': token // Use token from SharedPreferences
        },
        body: jsonEncode({'cartItem': cartItem}),
      );

      if (response.statusCode == 200) {
        print('Item added to cart');
        return true; // Return true if successfully added to cart
      } else {
        print('Failed to add item to cart');
        return false; // Return false on failure
      }
    } catch (e) {
      print('Error: $e');
      return false; // Return false on error
    }
  }
}
