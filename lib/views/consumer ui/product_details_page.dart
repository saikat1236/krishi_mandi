import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/constants/AppConstants.dart';
import 'package:krishi_customer_app/views/consumer%20ui/cartscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/profile.dart';
import 'package:krishi_customer_app/views/consumer%20ui/signupscreen%201.dart';
import 'package:krishi_customer_app/views/farmerui/menubar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/customer_apis/product_controller.dart';
import 'package:krishi_customer_app/controller/customer_apis/profile_controller.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsPage({Key? key, required this.product})
      : super(key: key); // Added key for widget tree

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late int qty;
  bool _isInCart = false;

  @override
  void initState() {
    super.initState();
    // Initialize qty with product['minQuantity']
    qty = widget.product['minQuantity'] ?? 1;
    _checkIfInCart(); // Check if the product is already in the cart
  }

  final cartController = Get.find<UserProfileController>();

  // Function to check if the product is in the cart
  void _checkIfInCart() async {
    // Assuming cartController has a method to get cart items
    await cartController.getUserProfile();
    final cartItems = cartController.userProfile['cartItems'] ?? [];
    setState(() {
      _isInCart = cartItems.any((item) => item['productId'] == widget.product['productId']);
    });
  }

  // final cartController = Get.find<UserProfileController>();

  Future<void> addToCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final url = Uri.parse(
        'http://54.159.124.169:3000/users/add-item-in-cart'); // Replace with your API endpoint

    final cartItem = {
      "orderType": 1,
      "productId":
          widget.product['productId'], // Assuming 'id' is the key for productId
      "productName": widget.product['name'],
      "ProductQuantityAddedToCart": qty,
      "productInfo":
          widget.product['about'], // Assuming 'about' holds product info
      "productImages":
          widget.product['images'], // Assuming 'images' is a list of image URLs
      "pricePerUnit": widget.product['pricePerUnit'],
      "productUnitType": widget.product[
          'unit'], // Assuming 'unitType' is the key for product unit type
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': token ?? '', // Use the token from SharedPreferences
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({"cartItem": cartItem}),
      );

      if (response.statusCode == 200) {
        // If the server returns an OK response, parse the JSON
        final responseData = jsonDecode(response.body);
        // Get.snackbar("Product added to cart successfully: ","$responseData",snackPosition: SnackPosition.TOP);
        Get.snackbar("Product added to cart successfully", "",
            snackPosition: SnackPosition.TOP);
        // Show a success message or update the UI
        await cartController.getUserProfile();
      } else {
        print('Failed to add product to cart: ${response.body}');
        // Show an error message
      }
    } catch (e) {
      print('Error adding product to cart: $e');
      // Show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        // elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,

        title: const Text('',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartListScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreenmain(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align children to the left
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    child: Image.network(product["images"][0])),
                // SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product['name'],
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Rs " + product['pricePerUnit'] + " " + product['unit'],
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.w800,
                    ),
                    // maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Select Quantity",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
    Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double quantityWidth = constraints.maxWidth * 0.5; // Adjust percentage as needed
          return Container(
            width: quantityWidth,
            height: 50,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      int minQuantity = widget.product['minQuantity'] ?? 1;
                      if (qty > minQuantity) {
                        qty--; // Decrease qty
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.remove_circle,
                      size: 40.0,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  qty.toString(),
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.0),
                InkWell(
                  onTap: () {
                    setState(() {
                      qty++; // Increase qty
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.add_circle,
                      size: 40.0,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double buttonWidth = constraints.maxWidth * 0.5;
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isInCart
                                ? Colors.grey
                                : Color.fromRGBO(74, 230, 50, 0.961),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(
                                color: _isInCart
                                    ? Colors.grey
                                    : Color.fromRGBO(74, 230, 50, 0.961),
                                width: 2.0,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: buttonWidth * 0.1,
                              vertical: 15,
                            ),
                          ),
                          onPressed: _isInCart
                              ? null
                              : () async {
                                  await addToCart();
                                  setState(() {
                                    _isInCart = true;
                                  });
                                },
                          child: Text(
                            _isInCart ? "Already in cart" : "Add to cart",
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      },
                    ),
                  ),
  ],
),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Description:",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(color: Colors.orange[50]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product['about'],
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      // maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
