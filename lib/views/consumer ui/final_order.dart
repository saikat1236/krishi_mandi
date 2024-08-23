// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/views/consumer%20ui/homescreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/order_success.dart';

import '../../controller/customer_apis/order_controller.dart';
import '../../controller/customer_apis/profile_controller.dart';

class FinalOrderScreen extends StatefulWidget {
    final List<dynamic> cartItems;
    //  final UserProfileController userProfileController;
  FinalOrderScreen({required this.cartItems});
  @override
  _CartListScreenState createState() => _CartListScreenState();
}

class _CartListScreenState extends State<FinalOrderScreen> {
  int? _rad; // The currently selected value

  int _quantity = 3; // Initial quantity

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }
    final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    final UserProfileController userProfileController = Get.find<UserProfileController>();
    final address = userProfileController.userProfile['Address'][0];
    // Create the order object
    final order = {
  "orderType": 1,
  "userName": userProfileController.userProfile['userName'] ?? "Unknown User",
  "email": userProfileController.userProfile['email'] ?? "example@example.com",
  "mobileNumber": userProfileController.userProfile['mobileNumber'] ?? "0000000000",
  "address": {
    "addressId": address['addressId'] ?? "No Address ID",
    "name": address['name'] ?? "No Name",
    "mobile": address['mobile'] ?? "0000000000",
    "email": address['email'] ?? "example@example.com",
    "addressLine1": address['addressLine1'] ?? "No Address Line 1",
    "addressLine2": address['addressLine2'] ?? "No Address Line 2",
    "city": address['city'] ?? "No City",
    "pin": address['pin'] ?? "000000",
  },
  "image": "",
  "productsOrdered": widget.cartItems.map((item) {
    return {
      "productName": item['productName'] ?? "No Product Name",
      "productId": item['productId'] ?? "No Product ID",
      "quantity": item['ProductQuantityAddedToCart'] ?? 0,
      "pricePerUnit": item['pricePerUnit'] ?? 0.0,
      "totalAmount": (item['pricePerUnit'] ?? 0.0) * (item['ProductQuantityAddedToCart'] ?? 0),
    };
  }).toList(),
  "totalAmount": userProfileController.getTotalAmount() ?? 0.0,
  "paymentType": "Credit Card",
};

    var subtot = order['totalAmount'];
    var tot = subtot + 245;
    order['totalAmount'] = tot;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        // elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,

        // title: const Text('My Cart',
        //     style:
        //         TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
        //   actions: [
        //   IconButton(
        //     icon: Icon(Icons.person),
        //     onPressed: () {
        //             Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => HomePage(),
        //       ),
        //     );
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        // width: 428,
        // height: 926,
        clipBehavior: Clip.antiAlias,
        // decoration: BoxDecoration(color: Color(0xFFFAF8F8)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Text(
                    "Where should we send the order?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text("Select a delivery address")
                ]),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    // height: 220,
                    height: 180,
                    width: 550,
                    decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      border: Border.all(
                        color: Colors.grey, // Border color
                        width: 2.0, // Border width
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0), // Radius for all corners
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Default'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text("Saikat Biswas",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text("${order['address']['addressLine1']}, ${order['address']['addressLine2']}, ${order['address']['city']}, ${order['address']['pin']} "),
                              ),
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text("${order['address']['email']}"),
                              ),
                               Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text("${order['address']['mobile']}"),
                              ),
                              Row(children: [
                                // ElevatedButton(
                                //   style: ElevatedButton.styleFrom(
                                //     backgroundColor:
                                //         Colors.green, // Background color
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(
                                //           18.0), // Rounded edges
                                //     ),
                                //     padding: EdgeInsets.symmetric(
                                //         horizontal: 30,
                                //         vertical: 10), // Button size
                                //   ),
                                //   onPressed: () {
                                //     // Get.to(widget.initialScreen);
                                //     // Add navigation or functionality here for consumer
                                //   },
                                //   child: Text(
                                //     "Change/Edit",
                                //     style: TextStyle(
                                //         color: Colors.white), // Text color
                                //   ),
                                // ),
                                // SizedBox(width: 30),
                                // ElevatedButton(
                                //   style: ElevatedButton.styleFrom(
                                //     backgroundColor: const Color.fromRGBO(
                                //         244, 67, 54, 1), // Background color
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(
                                //           18.0), // Rounded edges
                                //     ),
                                //     padding: EdgeInsets.symmetric(
                                //         horizontal: 30,
                                //         vertical: 10), // Button size
                                //   ),
                                //   onPressed: () {
                                //     // Get.to(widget.initialScreen);
                                //     // Add navigation or functionality here for consumer
                                //   },
                                //   child: Text(
                                //     "Delete",
                                //     style: TextStyle(
                                //         color: Colors.white), // Text color
                                //   ),
                                // ),
                              ]),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     width: 386,
              //     height: 45,
              //     child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Positioned(
              //             left: 1,
              //             top: 0,
              //             child: Container(
              //               width: 244,
              //               height: 45,
              //               child: TextField(
              //                 // controller: _phoneController,
              //                 decoration: InputDecoration(
              //                   border: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(
              //                         15.0), // Set border radius here
              //                   ),
              //                   hintText: 'Promo code',
              //                 ),
              //                 keyboardType: TextInputType.phone,
              //               ),
              //             ),
              //           ),
              //           // ignore: prefer_const_constructors
              //           //       TextField(
              //           //   // controller: _phoneController,
              //           //   decoration: InputDecoration(
              //           //     border: OutlineInputBorder(),
              //           //     hintText: 'Promo code',
              //           //   ),
              //           //   keyboardType: TextInputType.phone,
              //           // ),
              //           ElevatedButton(
              //             style: ElevatedButton.styleFrom(
              //               backgroundColor: Color.fromRGBO(74, 230, 50, 0.7),
              //               // Background color
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(15.0),
              //                 // side: BorderSide(color: Colors.black, width: 2.0),
              //                 // Rounded edges
              //               ),
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: 40, vertical: 4), // Button size
              //             ),
              //             onPressed: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => HomePage(),
              //                 ),
              //               );
              //             },
              //             child: Center(
              //               child: Text(
              //                 "Apply",
              //                 style:
              //                     TextStyle(color: Colors.white), // Text color
              //               ),
              //             ),
              //           ),
              //         ]),
              //   ),
              // ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sub-total",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text('Rs $subtot')
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [Text("Voucher", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),), Text("Rs 245")],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery Fee",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text("Rs 245")
                          ],
                        ),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.symmetric(vertical: 10.0),
                      //   height: 1.0,
                      //   width: double.infinity,
                      //   color: Colors.black,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            Text(
                              "Rs $tot",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text("Add More items to cart",
                              style: TextStyle(
                                color: Colors.green,
                                  fontSize: 18, 
                                  fontWeight: FontWeight.w500
                                  ))),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios_outlined, color: Colors.green),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              ),//
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            // side: BorderSide(color: Colors.black, width: 2.0),
                            // Rounded edges
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10), // Button size
                        ),
                         onPressed: () {
                        orderController.createOrder(order).then((_) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderSuccessScreen(order: order),
                            ),
                          );
                        });
                      },
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(color: Colors.white,fontSize: 16), // Text color
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
