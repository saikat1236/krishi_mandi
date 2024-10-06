import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class ProductController extends GetxController {
  var isLoading = true.obs;
  var products = [].obs; // Use a List<Map<String, dynamic>> for products
  var filteredProducts = [].obs; // Filtered products to display
  var categories = [].obs; // List of categories
  var favoriteProducts = [].obs; // List of favorite product IDs
    var searchResults = [].obs;
  var favprods = [].obs;

  final String baseUrl = 'https://backend.krishimandi.in/users'; // Replace with your base URL

  @override
  void onInit() {
    super.onInit();
    getAllProducts(1); // Fetch all products when controller initializes
    getAllCategories();
    getFavoriteProductsOnly(1);
    // getFavoriteProducts(); // Fetch favorite products
    loadFavoriteProducts(); 

  }

  // Retrieve token from SharedPreferences
  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? ''; // Default to empty string if token is not found
  }
  void searchProducts(String query) async {
        final token = await _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/search'),
      
      body: jsonEncode({
        "page": 1,
        "limit": 10,
        "query": query,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token, // Use your token retrieval method
      },
    );

    if (response.statusCode == 200) {
      searchResults.value = jsonDecode(response.body)['payload'];
    } else {
      searchResults.value = [];
    }
  }

    void clearSearchResults() {
    searchResults.clear();
  }
  // Get all categories
  Future<void> getAllCategories() async {
    // isLoading(true);
    final url = Uri.parse('$baseUrl/get-available-categories');
    final token = await _getToken();

    final headers = {
      'Content-Type': 'application/json',
          'Authorization': token // Use token from SharedPreferences
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
    // isLoading(true);
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
          'categories': [], // Fetch all products without filtering
          'page': page,
          'limit': 100, // Increase limit to fetch more products
        }),
      );

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body)["payload"];
        if (decodedResponse is List) {
          products.value = decodedResponse;
          filteredProducts.value = decodedResponse; // Initialize filteredProducts with all products
        } else {
          products.value = [];
          filteredProducts.value = [];
        }
      } else {
        products.value = [];
        filteredProducts.value = [];
        print('Failed to load products');
      }
    } catch (e) {
      print('Error: $e');
      products.value = [];
      filteredProducts.value = [];
    } finally {
      isLoading(false);
    }
  }

// Store favorite products in SharedPreferences
Future<void> _storeFavoriteProducts() async {
  final prefs = await SharedPreferences.getInstance();
  // Convert favoriteProducts list to JSON string and store it
  await prefs.setString('favoriteProducts', jsonEncode(favoriteProducts));
}


// Load filtered products from SharedPreferences
// Load favorite products from SharedPreferences
Future<void> loadFavoriteProducts() async {
  final prefs = await SharedPreferences.getInstance();
  final String? storedFavorites = prefs.getString('favoriteProducts');
  if (storedFavorites != null) {
    final List<dynamic> decodedFavorites = jsonDecode(storedFavorites);
    favoriteProducts.value = List<String>.from(decodedFavorites);
  }
}

Future<void> getFavoriteProductsOnly(int page) async {
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
        'categories': [], // Fetch all products without filtering
        'page': page,
        'limit': 100, // Increase limit to fetch more products
      }),
    );

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body)["payload"];
      
      if (decodedResponse is List) {
        // Assuming favoriteProducts is a list of product IDs
        var favoriteProductIds = favoriteProducts; // List of product IDs directly

        // Filter products from decodedResponse that match the IDs in favoriteProducts
        var favoriteProductList = decodedResponse
            .where((product) => favoriteProductIds.contains(product['productId']))
            .toList();

        // Update favprods with the filtered favorite products
        favprods.value = favoriteProductList;
        print("favprods $favprods");
      } else {
        favprods.value = [];
        print('No products found');
      }
    } else {
      favprods.value = [];
      print('Failed to load products');
    }
  } catch (e) {
    print('Error: $e');
    favprods.value = [];
  } finally {
    isLoading(false);
  }
}


  // Filter products by selected categories
  void filterProductsByCategory(String selectedCategory) {
  if(selectedCategory=='fruits') selectedCategory='Fruit';
   if(selectedCategory=='vegetables') selectedCategory='Vegetable';

    // selectedCategory="Fruit";
    if (products.isNotEmpty) {
      if (selectedCategory.isEmpty) {
        filteredProducts.value = products; // Show all products if no category is selected
      } else {
        filteredProducts.value = products
            .where((product) => product['category'] == selectedCategory)
            .toList(); // Filter products based on selected category
      }
    }
            // filteredProducts.value = products
           
            // .where((product) => product['category'] == "Vegetable")
            // .toList(); // Filter products based on selected category
    print(filteredProducts);
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
      // Parse the response body
      final responseData = jsonDecode(response.body);

      // Check if the response contains 'productId'
      if (responseData['status'] == true && responseData['payload'] != null) {
        final productId = responseData['payload']['productId'];

        if (productId != null) {
          // Assign the productId to the favItem for tracking
          favItem['productId'] = productId;

          // Add productId to the favoriteProducts list
          favoriteProducts.add(productId);

          // Show snackbar confirmation
          Get.snackbar('Favorites', 'Product added to favorites!',
              snackPosition: SnackPosition.TOP);

          print(favoriteProducts); // Print the updated favorite products list
        } else {
          print('Failed: productId not found in response');
        }
      } else {
        print('Failed to add item to favorites: ${response.body}');
      }
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
    print(favoriteProducts.contains(productId));
    return favoriteProducts.contains(productId);
  }

  // // Fetch favorite products
  // Future<void> getFavoriteProducts() async {
  //   // isLoading(true);
  //       // selectedCategory="Fruit";

  //       favoriteProducts.value = products
  //           .where((product) => product['isAvailableInFav'] == true)
  //           .toList(); // Filter products based on selected category
  //           // filteredProducts.value = products
           
  //           // .where((product) => product['category'] == "Vegetable")
  //           // .toList(); // Filter products based on selected category
  //   print("fav products: $favoriteProducts");
  //   // isLoading(false);
  //   // Implement fetching favorite products if needed
  // }

Future<void> toggleFavorite(String productId) async {
  // Check if the productId is already in favoriteProducts
  if (favoriteProducts.contains(productId)) {
    // If it is, remove it from favorites
    favoriteProducts.remove(productId);
    Get.snackbar('Favorites', 'Product removed from favorites!',
        snackPosition: SnackPosition.TOP, backgroundColor: Colors.white);
  } else {
    // If it's not, add it to favorites
    favoriteProducts.add(productId);
    Get.snackbar('Favorites', 'Product added to favorites!',
        snackPosition: SnackPosition.TOP, backgroundColor: Colors.white);
  }
  getFavoriteProductsOnly(1);
  // loadFavoriteProducts();

  // Store updated favorite products in SharedPreferences
  await _storeFavoriteProducts();

  // Optional: You can refresh any UI state if necessary
  favoriteProducts.refresh();
  print("Updated favorite products: $favoriteProducts");
  update();
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
