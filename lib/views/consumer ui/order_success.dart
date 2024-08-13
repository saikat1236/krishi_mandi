// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/views/consumer%20ui/homescreen.dart';

class OrderSuccessScreen extends StatefulWidget {
  @override
  _CartListScreenState createState() => _CartListScreenState();
}

class _CartListScreenState extends State<OrderSuccessScreen> {
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

  @override
  Widget build(BuildContext context) {
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
                    "Yes, you’ve successfully ordered!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.",
                    textAlign: TextAlign.center,
                  )
                ]),
              ),
              SizedBox(height: 20),
              Image.asset("assets/Check icon.png"),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    height: 270,
                    width: 500,
                    decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0), // Radius for all corners
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Payment Details',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [Text("Order No."), Text("12345678")],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [Text("Total"), Text("150\ ₹")],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Date & Time"),
                                    Text("12/12/2024")
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [Text("Payment Method"), Text("UPI")],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [Text("Name"), Text("Saikat Biswas")],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Email"),
                                    Text("saikat1236@gmail.com")
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          "Back to Shop",
                          style: TextStyle(
                              color: Colors.white, fontSize: 16), // Text color
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
