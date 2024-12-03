// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../constants/AppConstants.dart';

// class AllOrdersController extends GetxController {
//   var isLoading = true.obs;
//   var allOrders = [].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchAllOrders();
//   }

//   Future<String> _getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('token') ??
//         ''; // Default to empty string if token is not found
//   }

//   void fetchAllOrders() async {

//     final url = '$baseUrl/create-order';
//     print('$url');
//     isLoading.value = true;
//     final token = await _getToken();
//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': token,
//         },
//         body: jsonEncode(), // Send the order directly
//       );
//       var orderData = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         allOrders.value = data['data'];
//         isLoading.value = false;
//       } else {
//         print(
//             'Failed to fetch orders. Status code: ${response.statusCode}'); // Add this line
//         isLoading.value = false;
//       }
//     } catch (e) {
//       print('Error: $e');
//       isLoading.value = false;
//     }
//   }
// }
