// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/views/consumer%20ui/homescreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/order_success.dart';
import 'package:krishi_customer_app/views/consumer%20ui/payment_failed.dart';
import 'package:krishi_customer_app/views/consumer%20ui/profile.dart';
import 'package:krishi_customer_app/views/homescreen.dart';

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
  // Address should not be final if you need to update it
  late Map<String, dynamic> address;

  @override
  void initState() {
    super.initState();
    final UserProfileController userProfileController =
        Get.find<UserProfileController>();

    // Fetch the default address
    address = userProfileController.userProfile['Address']
        .firstWhere((addr) => addr['default'] == true, orElse: () => {});

    if (address.isEmpty) {
      // Handle the case where no default address is found
      print('No default address found.');
    }
  }

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
    final UserProfileController userProfileController =
        Get.find<UserProfileController>();

    final order = {
      "productsOrdered": widget.cartItems.map((item) {
        return {
          "productId": item['productId'] ?? "No Product ID",
          "quantity": item['ProductQuantityAddedToCart'].toInt() ?? 0,
        };
      }).toList(),
      "addressId": address['addressId'] ?? "No Address ID",
      "totalAmount": userProfileController.getTotalAmount().toInt() ?? 0,
      "paymentType": "online"
    };

    var delhivery = 0;
    var subtot = order['totalAmount'];
    var tot = subtot + delhivery;
    // order['totalAmount'] = tot;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        backgroundColor: Color(0xFF2E2E2E),
        // elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,

        // title: const Text('My Cart',
        //     style:
        //         TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
                    height: 180,
                    // height: 180,
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
                                child: Text("${address['name']}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text(
                                    "${address['addressLine1']}, ${address['addressLine2']}, ${address['city']}, ${address['pin']} "),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.all(3.0),
                              //   child: Text("${address['email']}"),
                              // ),
                              // Padding(
                              //   padding: EdgeInsets.all(3.0),
                              //   child: Text("${address['mobile']}"),
                              // ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.green, // Background color
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                18.0), // Rounded edges
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30,
                                              vertical: 10), // Button size
                                        ),
                                        onPressed: () async {
                                          final updatedAddress =
                                              await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileScreenmain(),
                                            ),
                                          );

                                          if (updatedAddress != null) {
                                            setState(() {
                                              address =
                                                  updatedAddress; // Update the address
                                            });
                                          }
                                        },
                                        child: Text(
                                          "Change/Edit",
                                          style: TextStyle(
                                              color:
                                                  Colors.white), // Text color
                                        ),
                                      ),
                                    ),
                                  ]),
                            ],
                          ),
                        )
                      ],
                    )),
              ),

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
                            Text("Rs $delhivery")
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
                                  fontWeight: FontWeight.w500))),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios_outlined,
                            color: Colors.green),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              ), //
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     // ignore: prefer_const_literals_to_create_immutables
              //     children: [
              //       ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: Colors.black,
              //           // Background color
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(10.0),
              //             // side: BorderSide(color: Colors.black, width: 2.0),
              //             // Rounded edges
              //           ),
              //           padding: EdgeInsets.symmetric(
              //               horizontal: 40, vertical: 10), // Button size
              //         ),
              //         onPressed: () {
              //           print(order);
              //           // Example widget code
              //           orderController.createOrder(order);
              //         },
              //         child: Center(
              //           child: Text(
              //             "Continue to Pay",
              //             style: TextStyle(
              //                 color: Colors.white, fontSize: 16), // Text color
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          orderController.createOrder(order);
          // print(userProfileController.userProfile["Address"]);
        },
        label: Text(
          'Continue to Pay',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        // icon: Icon(Icons.shopping_cart_checkout),
        backgroundColor: Colors.black, // Customize button color
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
