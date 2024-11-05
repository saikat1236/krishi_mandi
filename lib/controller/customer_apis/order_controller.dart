import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:krishi_customer_app/controller/customer_apis/profile_controller.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/AppConstants.dart';
import '../../views/consumer ui/order_success.dart';
import '../../views/consumer ui/payment_failed.dart';

class OrderController extends GetxController {
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  var isLoading = false.obs;
  var orders = [].obs;
  var errorMessage = ''.obs;
  late Razorpay _razorpay;
  var order2 = <String, dynamic>{}.obs;

    // New member variable to hold the callback
  // late Function(bool) onPaymentResult;
  var paymentSuccess = false.obs; // Observable for payment result

  final String baseUrl = '${AppContants.baseUrl}/users';

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void onClose() {
    _razorpay.clear(); // Clear all listeners
    super.onClose();
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ??
        ''; // Default to empty string if token is not found
  }

  // // Create an order and initiate Razorpay payment
  // Future<void> createOrder(Map<String, dynamic> order) async {
  //   final url = '$baseUrl/create-order';
  //   print('$url');
  //   isLoading.value = true;
  //   final token = await _getToken();

  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': token, // Use token from SharedPreferences
  //       },
  //       body: jsonEncode({
  //         // "productsOrdered": order['productsOrdered'] ?? [],
  //         // "addressId": order['addressId'] ?? "No Address ID",
  //         // "totalAmount": order['totalAmount'] ?? 0,
  //         // "paymentType": order['paymentType'] ?? "online",

  //         "productsOrdered": [
  //           {
  //             "productId": "fc4328e4-a628-4467-980d-c7f402ab09d4",
  //             "quantity": 10
  //           }
  //         ],
  //         "addressId": "w9hbxkwz",
  //         "totalAmount": 800,
  //         "paymentType": "online"
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       Get.snackbar('Success', 'Order created successfully');
  //       userProfileController.getOrders();

  //       // Extract order details for payment from response
  //       var orderData = jsonDecode(response.body);
  //       var razorpayOrderId = orderData[
  //           'razorpayOrderId']; // Ensure this field exists in the response
  //       var amount = orderData['amount'];
  //       print(razorpayOrderId);
  //       startPayment(razorpayOrderId, amount);
  //     } else {
  //       errorMessage.value =
  //           'Failed to create order: ${response.statusCode}, ${response.body}';
  //       print('Full response: $response'); // Print the entire response
  //       Get.snackbar('Error', errorMessage.value);
  //     }
  //   } catch (e) {
  //     errorMessage.value = 'An error occurred: $e';
  //     Get.snackbar('Error', errorMessage.value);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // // Initialize Razorpay payment
  // void startPayment(String orderId, int amount) {
  //   var options = {
  //     'key': 'rzp_test_B1NKQK3CKqxV4X', // Replace with your Razorpay Key
  //     'amount': amount * 100, // Amount in smallest currency unit
  //     'order_id': orderId,
  //     'name': 'Krishi Mandi',
  //     'description': 'Payment for your order',
  //     'prefill': {
  //       'contact': '9876543210',
  //       'email': 'customer@krishimandi.in',
  //     },
  //   };

  //   try {
  //     _razorpay.open(options);
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  // // Razorpay success handler
  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   Get.snackbar('Payment Success', 'Payment ID: ${response.paymentId}');
  //   // Handle post-payment actions, like updating order status on server
  // }

  // // Razorpay error handler
  // void _handlePaymentError(PaymentFailureResponse response) {
  //   Get.snackbar('Payment Failed', 'Error: ${response.message}');
  // }

  // // Razorpay external wallet handler
  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   Get.snackbar('External Wallet', 'Wallet: ${response.walletName}');
  // }






// Inside OrderController
Future<void> createOrder(Map<String, dynamic> order) async {
  order2.assignAll(order);
  final url = '$baseUrl/create-order';
  print('$url');
  isLoading.value = true;
  final token = await _getToken();

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode(order), // Send the order directly
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Order created successfully');
      userProfileController.getOrders();

      // Extract order details for payment from response
      var orderData = jsonDecode(response.body);
      var razorpayOrderId = orderData['razorpayOrderId'];
      var amount = orderData['amount'];
      print(razorpayOrderId);
      startPayment(razorpayOrderId, amount);
    } else {
      errorMessage.value = 'Failed to create order: ${response.statusCode}, ${response.body}';
      print('Full response: $response');
      Get.snackbar('Error', errorMessage.value);
      // onPaymentResult(false); // Trigger failure callback
      paymentSuccess.value = false;
    }
  } catch (e) {
    errorMessage.value = 'An error occurred: $e';
    Get.snackbar('Error', errorMessage.value);
    // onPaymentResult(false); // Trigger failure callback
    paymentSuccess.value = false;
  } finally {
    isLoading.value = false;
  }
}

void startPayment(String orderId, int amount) {
  var options = {
    'key': 'rzp_test_B1NKQK3CKqxV4X',
    'amount': amount * 100,
    'order_id': orderId,
    'name': 'Krishi Mandi',
    'description': 'Payment for your order',
    'prefill': {
      'contact': '9876543210',
      'email': 'customer@krishimandi.in',
    },
  };

  try {
    _razorpay.open(options);
  } catch (e) {
    // onPaymentResult(false); // Trigger failure callback
      paymentSuccess.value = false;
    print('Error: $e');
  }
}

// Razorpay success handler
void _handlePaymentSuccess(PaymentSuccessResponse response) {
  Get.snackbar('Payment Success', 'Payment ID: ${response.paymentId}');
  paymentSuccess.value = true;
  // Redirect to OrderSuccessScreen and remove the previous screen
  Get.off(() => OrderSuccessScreen(order: order2));
}

// Razorpay error handler
void _handlePaymentError(PaymentFailureResponse response) {
  Get.snackbar('Payment Failed', 'Error: ${response.message}');
  paymentSuccess.value = false;
  // Redirect to PaymentFailureScreen and remove the previous screen
  Get.off(() => PaymentFailureScreen());
}


// Razorpay external wallet handler
void _handleExternalWallet(ExternalWalletResponse response) {
  Get.snackbar('External Wallet', 'Wallet: ${response.walletName}');
}

}