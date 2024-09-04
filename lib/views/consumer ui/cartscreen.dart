import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:krishi_customer_app/views/consumer%20ui/final_order.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/customer_apis/profile_controller.dart';

class CartListScreen extends StatefulWidget {
  @override
  _CartListScreenState createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  final UserProfileController userProfileController = Get.put(UserProfileController());

  int? _rad; // The currently selected value

  bool _isLoadingComplete = false; // Flag to control the OK button

  @override
  void initState() {
    super.initState();
    // Schedule the loading dialog to show after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _showLoadingDialog();
      userProfileController.getUserProfile().then((_) {
        setState(() {
          _isLoadingComplete = true; // Enable the OK button when loading is complete
        });
        // Future.delayed(Duration(seconds: 1), () {
        //   if (mounted) {
        //     Navigator.of(context).pop(); // Close the dialog automatically after 2 seconds
        //   }
        // });
      });
    });
  }

  // void _showLoadingDialog() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         contentPadding: EdgeInsets.all(20), // Add padding around content
  //         content: SizedBox(
  //           width: 200, // Set a fixed width for the dialog
  //           height: 150, // Increase height to accommodate the button
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
  //             children: [
  //               Text(
  //                 "Cart page is Loading...",
  //                 style: TextStyle(fontSize: 16),
  //               ),
  //               SizedBox(height: 20), // Space between spinner and text
  //               CircularProgressIndicator(),
  //               // SizedBox(height: 20), // Space between spinner and button
  //               // StatefulBuilder(
  //               //   builder: (context, setState) {
  //               //     return ElevatedButton(
  //               //       onPressed: _isLoadingComplete
  //               //           ? () {
  //               //               Get.back(); // Close the dialog when the button is clicked
  //               //             }
  //               //           : null, // Disable the button until loading is complete
  //               //       style: ElevatedButton.styleFrom(
  //               //         backgroundColor: _isLoadingComplete ? Colors.green : Colors.grey, // Change color based on loading state
  //               //       ),
  //               //       child: Text("OK"),
  //               //     );
  //               //   },
  //               // ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }


// @override
// void initState() {
//   super.initState();
//   // Schedule the loading dialog to show after the first frame is rendered
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     _showLoadingDialog(); 
//     userProfileController.getUserProfile().then((_) {
//       Get.back(); // Close the loading dialog once the profile is loaded
//     });
//   });
// }

// void _showLoadingDialog() {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         contentPadding: EdgeInsets.all(20), // Add padding around content
//         content: SizedBox(
//           width: 200, // Set a fixed width for the dialog
//           height: 100, // Set a fixed height for the dialog
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
//             children: [
//               Text(
//                 "Cart page is Loading...",
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 20), // Space between spinner and text
//               CircularProgressIndicator(),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }




  void _increaseQuantity(int index) {
    setState(() {
      userProfileController.cartItems[index]['ProductQuantityAddedToCart']++;
      tot = userProfileController.getCartSubtotal() + vouch; 
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      // if (userProfileController.cartItems[index]['ProductQuantityAddedToCart'] > 1) {
      //   userProfileController.cartItems[index]['ProductQuantityAddedToCart']--;
      //   tot = userProfileController.getCartSubtotal() + vouch; 
      // }
      //  int minQuantity = userProfileController.cartItems[index]['minQuantity'] ?? 1;
    if (userProfileController.cartItems[index]['ProductQuantityAddedToCart'] > userProfileController.cartItems[index]['minQuantity']) {
      userProfileController.cartItems[index]['ProductQuantityAddedToCart']--;
      tot = userProfileController.getCartSubtotal() + vouch;
    }
    });
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? ''; // Default to empty string if token is not found
  }

  Future<void> _removeItemFromCart(String productId) async {
    final url = Uri.parse('http://54.159.124.169:3000/users/remove-item-from-cart');
    final token = await _getToken();
    
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token, // Use token from SharedPreferences
        },
        body: jsonEncode({
          'productId': productId,
        }),
      );

      if (response.statusCode == 200) {
        // Successfully deleted the item
        userProfileController.getUserProfile(); // Refresh the cart items
      } else {
        // Handle the error
        print('Failed to delete the item: ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions that occur
      print('Error occurred while deleting the item: $e');
    }
  }

  var vouch = 0;
  double tot = 0.0; // Initialize tot as double

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); // Navigate back
              },
            );
          },
        ),
      ),
      body: Obx(() {
        if (userProfileController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (userProfileController.cartItems.isEmpty) {
          return Center(child: Text('Your cart is empty.'));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: userProfileController.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = userProfileController.cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x66E5E5E5),
                              blurRadius: 10,
                              offset: Offset(10, 10),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              margin: const EdgeInsets.all(8.0),
                              child: Image.network(
                                cartItem['productImages'][0] ?? '',
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                  return Image.asset(
                                    'assets/no_image.jpg', // Path to your fallback asset image
                                    fit: BoxFit.cover,
                                  );
                                },
                              ), // Load the image dynamically
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            cartItem['productName'],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Quantity: ',
                                                  style: TextStyle(
                                                    color: Color(0xFFCACACA),
                                                    fontSize: 12,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '${cartItem['ProductQuantityAddedToCart']} ${cartItem['productUnitType']}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Rs ${cartItem['pricePerUnit']}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        print(cartItem['productId']);
                                        _removeItemFromCart(cartItem['productId']); // Call the delete API
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    right: 8,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove),
                       onPressed: () {
  setState(() {
    int minQuantity = cartItem['minQ'] ?? 1;
    int currentQuantity = userProfileController.cartItems[index]['ProductQuantityAddedToCart'];

    if (currentQuantity > minQuantity) {
      // Decrease the quantity if it's above the minimum
      userProfileController.cartItems[index]['ProductQuantityAddedToCart']--;
    } else {
      // Show a pop-up message if the quantity is at or below the minimum
      Get.snackbar(
        "Cannot Decrease",
        "Quantity cannot be less than the minimum quantity of $minQuantity.",
        snackPosition: SnackPosition.TOP,
      );
    }
  });
},

                                        ),
                                        Text(
                                          '${cartItem['ProductQuantityAddedToCart']}',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () => _increaseQuantity(index),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Sub-total"),
                              Obx(() => Text("Rs ${userProfileController.getCartSubtotal().toStringAsFixed(2)}")),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Voucher"),
                              Text("Rs $vouch"),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          height: 1.0,
                          width: double.infinity,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                              Text(
                                "Rs ${userProfileController.getCartSubtotal().toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => FinalOrderScreen(cartItems:  userProfileController.getCartItems(),)); // Navigate to the final order screen
        },
        label: Text('Place Order',
        style: TextStyle(color: Colors.white,fontSize: 16 ),),
        // icon: Icon(Icons.shopping_cart_checkout),
        backgroundColor: Colors.black, // Customize button color
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Position at the bottom center
    );
  }
}
