import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileController extends GetxController {
  var isLoading = false.obs;
  var userProfile = {}.obs;
  var cartItems = [].obs;
  var orders = [].obs;
  var favorites = [].obs;

  final String baseUrl = 'http://54.159.124.169:3000/users'; // Replace with your base URL

  @override
  void onInit() {
    super.onInit();
    getUserProfile(); // Fetch user profile when controller initializes
  }

  // Retrieve token from SharedPreferences
  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? ''; // Default to empty string if token is not found
  }

  // Get user profile
  Future<void> getUserProfile() async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/get-user-profile');
    final token = await _getToken();
    print('Token fetched from SharedPreferences: $token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': token, // Use token from SharedPreferences
    };
    try {
      final response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        if (decodedResponse is Map<String, dynamic>) {
          userProfile.value = decodedResponse['payload']['userProfile'] ?? {};

          // Update specific fields
          cartItems.value = userProfile['cartItems'] ?? [];
          orders.value = userProfile['orders'] ?? [];
          favorites.value = userProfile['favorites'] ?? [];

  print("cart: " + jsonEncode(cartItems));
  print("orders: " + jsonEncode(orders));
  print("favorites: " + jsonEncode(favorites));

        } else {
          userProfile.value = {};
          cartItems.clear();
          orders.clear();
          favorites.clear();
        }
      } else {
        userProfile.value = {};
        cartItems.clear();
        orders.clear();
        favorites.clear();
        print('Failed to load user profile: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      userProfile.value = {};
      cartItems.clear();
      orders.clear();
      favorites.clear();
    } finally {
      isLoading(false);
    }
  }

  // Get cart items
  List<dynamic> getCartItems() {
    return cartItems;
  }

  // Get orders
  List<dynamic> getOrders() {
    return orders;
  }

  // Get favorites
  List<dynamic> getFavorites() {
    return favorites;
  }
}
