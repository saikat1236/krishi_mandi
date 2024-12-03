import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/constants/AppConstants.dart';
import 'package:krishi_customer_app/views/consumer%20ui/cartscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/profile.dart';
import 'package:krishi_customer_app/views/consumer%20ui/signupscreen%201.dart';
import 'package:krishi_customer_app/views/farmerui/menubar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:krishi_customer_app/controller/customer_apis/user_controller.dart';
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
  int activeIndex = 0; // Tracks the active image index for the dots indicator

  late int _rating; // Initial rating



  @override
  void initState() {
    super.initState();
    // Initialize qty with product['minQuantity']
    _rating = widget.product['ratings']['averageRating'] ?? 1;
    // _rating=1;
    print(widget.product);
    qty = widget.product['minQuantity'] ?? 1;
    _checkIfInCart(); // Check if the product is already in the cart
  }

  void _setRating(int rating) {
    setState(() {
      _rating = rating;
    });
  }


  final UserController userController = Get.find<UserController>();
  final UserProfileController userProfileController =
      Get.find<UserProfileController>();

  void _ratingshow(Map<String, dynamic> product) {
    int _selectedRating = 1; // Local state to keep track of selected rating

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // To update the state of the dialog
          builder: (context, setState) {
            return AlertDialog(
              title: Center(child: Text("Rate the Product")),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 1; i <= 5; i++)
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _selectedRating =
                                  i; // Update local state for selected rating
                            });

                            // Submit the rating after the selection
                            await userController.rateProduct(
                              product['_id'], // Product's ID
                              product['productId'], // Product's unique ID
                              _selectedRating, // The selected rating
                            );

                            // Close dialog after rating
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.star,
                            color: i <= _selectedRating
                                ? Colors.orange
                                : Colors.grey,
                            size: 30,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    _selectedRating == 0
                        ? "Tap a star to rate."
                        : "You rated: $_selectedRating star${_selectedRating > 1 ? 's' : ''}",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(""),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  final cartController = Get.find<UserProfileController>();

  // Function to check if the product is in the cart
  void _checkIfInCart() async {
    // Assuming cartController has a method to get cart items
    await cartController.getUserProfile();
    final cartItems = cartController.userProfile['cartItems'] ?? [];
    setState(() {
      _isInCart = cartItems
          .any((item) => item['productId'] == widget.product['productId']);
    });
  }

  void _showMinimumQuantityDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Minimum Quantity Reached"),
          content: Text(
              "You can't go below the minimum quantity of ${widget.product['minQuantity'] ?? 1}."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  // final cartController = Get.find<UserProfileController>();

  Future<void> addToCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final url = Uri.parse(
        '${AppContants.baseUrl}/users/add-item-in-cart'); // Replace with your API endpoint

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
      // "pricePerUnit": widget.product['pricePerUnit'],
      "pricePerUnit": widget.product['pricePerUnit'].toString(),
      "productUnitType": widget.product[
          'unit'], // Assuming 'unitType' is the key for product unit type
      "minQ": widget.product['minQuantity']
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
    bool cart = userProfileController.cartItems.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF2E2E2E),
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context); // Navigate back
              },
            );
          },
        ),
        actions: [
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartListScreen(),
                    ),
                  );
                },
              ),
              // Conditionally show the red dot if the cart is not empty
              if (cart) // Replace `cartItems.isNotEmpty` with your cart-check logic
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 10,
                      minHeight: 10,
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
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
                CarouselSlider.builder(
                  itemCount: widget.product["images"].length,
                  itemBuilder: (context, index, realIndex) {
                    final imageUrl = widget.product["images"][index];
                    return Container(
                      width: double.infinity,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset(
                            'assets/no_image.jpg', // Path to your asset image
                            height: 400, // Adjust image height ratio as needed
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 400,
                    autoPlay: true, // Enables auto sliding of images
                    enlargeCenterPage: true, // Image in the center is larger
                    viewportFraction: 1.0, // Makes it full screen width
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex =
                            index; // Update the active index for dot indicator
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Center(child: buildIndicator()),
                // Container(
                //     width: double.infinity,
                //     child: Image.network(product["images"][0],
                //      errorBuilder: (BuildContext context, Object exception,
                //           StackTrace? stackTrace) {
                //         return Image.asset(
                //           'assets/no_image.jpg', // Path to your asset image
                //           // width: 500,
                //           height: 400, // Adjust image height ratio as needed
                //           fit: BoxFit.cover,
                //         );
                //       },)
                //     ),
                SizedBox(height: 20),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        // Generate star icons based on _rating value
                        for (int i = 1; i <= 5; i++)
                          // GestureDetector(
                          // onTap: () => _setRating(i),
                          Icon(
                            Icons.star,
                            color: i <= _rating ? Colors.orange : Colors.grey,
                          ),
                        // ),
                        SizedBox(width: 10),
                        Text(
                          _rating.toStringAsFixed(1),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 10),
                        // Text(
                        //   "(${(_rating * 100).toInt()}) Reviews", // Example count based on rating
                        //   style: TextStyle(fontSize: 16),
                        // ),
                      ],
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(74, 230, 50, 0.961),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    onPressed: () => _ratingshow(product),
                    child: const Text(
                      'Rate product',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ]),

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
                    "Rs ${product['pricePerUnit'].toString()} ${product['unit']}",
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
                          double quantityWidth = constraints.maxWidth *
                              0.5; // Adjust percentage as needed
                          return Container(
                            width: quantityWidth,
                            height: 50,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      int minQuantity =
                                          widget.product['minQuantity'] ?? 1;
                                      if (qty > minQuantity) {
                                        print("min");
                                        qty--; // Decrease qty
                                      } else {
                                        // Show a pop-up message
                                        _showMinimumQuantityDialog();
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
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Save up to 10%",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                        Text(
                          " with business pricing and GST input tax credit.",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width:
                                250, // Ensures it takes the full width of the parent
                            constraints: BoxConstraints(
                              minHeight:
                                  50, // Ensures a minimum height for the box
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: Colors.grey), // Grey border
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), // Shadow color
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // Shadow position
                                ),
                              ],
                            ),
                            child: TextField(
                              // keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'GST Number', // Hint text
                                border: InputBorder
                                    .none, // Remove the default TextField border
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 15), // Padding inside the box
                              ),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            constraints: BoxConstraints(
                              minHeight:
                                  50, // Ensures a minimum height for the box
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border:
                                  Border.all(color: Colors.grey), // Grey border
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), // Shadow color
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // Shadow position
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  // shape: RoundedRectangleBorder(
                                  //   // borderRadius: BorderRadius.circular(20.0),
                                  //   // side: BorderSide(
                                  //   //   // color: Colors.white,
                                  //   //   width: 2.0,
                                  //   // ),
                                  // ),
                                  // padding: EdgeInsets.symmetric(

                                  //   vertical: 15,
                                  // ),
                                ),
                                onPressed: () {
                                  print("gst submit");
                                },
                                child: Container(
                                  child: Text("Submit"),
                                )),
                          )
                          // Spacer(),
                        ],
                      ),
                    )
                  ],
                ),
                // SizedBox(height: 10,),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     "Labels:",
                //     style: TextStyle(
                //       fontSize: 20,
                //       color: Colors.black,
                //       fontWeight: FontWeight.w500,
                //     ),
                //     maxLines: 2,
                //     textAlign: TextAlign.left,
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: product["labels"].map<Widget>((label) {
                        return Container(
                            width: 100,
                            child: Column(
                              children: [
                                Image.network(
                                  label["imageUrl"],
                                  height: 50,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  label["name"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ));
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Product Details:",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Brand:",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Model:",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Color:",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Brand Value", // Change this to the actual brand value
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Model Value", // Change this to the actual model value
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Color Value", // Change this to the actual color value
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                ),
              ],
            )),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.product["images"].length,
        effect: ExpandingDotsEffect(
          dotHeight: 8,
          dotWidth: 8,
          activeDotColor:
              Color.fromARGB(255, 58, 213, 6), // Color of active dot
          dotColor: Colors.grey, // Color of inactive dots
        ),
      );
}
