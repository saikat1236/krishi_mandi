import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:dropdown_model_list/drop_down/select_drop_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:krishi_customer_app/views/farmerui/ratecalc.dart';
import 'package:krishi_customer_app/views/farmerui/upload.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FarmHome extends StatefulWidget {
  const FarmHome();

  @override
  State<FarmHome> createState() => _FarmHomeState();
}

class _FarmHomeState extends State<FarmHome> {
  File? _image;
  String? _response;

  @override
  void initState() {
    super.initState();
    // _loadImageFromAssets();
  }

  @override
  Widget build(BuildContext context) {
    // Variable to hold the selected value
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,

          title: const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Krishi ',
                  style: TextStyle(
                      color: Colors.black, // Color for 'Krishi'
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
                TextSpan(
                  text: 'Mandi',
                  style: TextStyle(
                      color: Colors.green, // Color for 'Mandi'
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
              ],
            ),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image.asset('assets/krishi-logo.png'),
              );
            },
          ),
          //           actions: [
          //   IconButton(
          //     icon: Icon(Icons.shopping_cart),
          //     onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => CartListScreen(),
          //       ),
          //     );
          //   },
          //   ),
          //   IconButton(
          //     icon: Icon(Icons.person),
          //     onPressed: () {
          //             Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => ProfileScreenmain(),
          //       ),
          //     );
          //     },
          //   ),
          // ],
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        // height: 300,
                        decoration: BoxDecoration(
                            // color: Colors.grey[200],
                            ),
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/Group 42.png"),
                              fit: BoxFit
                                  .contain, // Adjust the image fit as per your design
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0, // Places the image at the top
                                right: 0, // Places the image at the right
                                child: Image.asset(
                                  'assets/Group 52.png',
                                  width: 220, // Adjust the width as needed
                                  // height: 100, // Adjust the height as needed
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  // SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Overview",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Column(
                    children: [
                           GestureDetector(
                        onTap: () {
                          // Navigate to another screen when tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Uploadpage()), // Replace 'TargetScreen' with your screen
                          );
                        },
                      child: Center(
                        child: Container(
                          height: 100.0,
                          width: 400.0,
                          decoration: BoxDecoration(
                            color: Colors.white, // Background color
                            borderRadius:
                                BorderRadius.circular(15.0), // Rounded corners
                            border: Border.all(
                              color: Color.fromARGB(
                                  200, 131, 221, 93), // Border color
                              width: 2.0, // Border width
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 1, // Shadow spread
                                blurRadius: 6, // Shadow blur
                                offset: Offset(0, 1), // Shadow position
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Calculator',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Yield Estimate',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Image.asset('assets/Vector.png'),
                              ],
                            ),
                          ),
                        )
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                           GestureDetector(
                        onTap: () {
                          // Navigate to another screen when tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RateCalc()), // Replace 'TargetScreen' with your screen
                          );
                        },
                      child: Center(
                        child: Container(
                          height: 100.0,
                          width: 400.0,
                          decoration: BoxDecoration(
                            color: Colors.white, // Background color
                            borderRadius:
                                BorderRadius.circular(15.0), // Rounded corners
                            border: Border.all(
                              color: Color.fromARGB(
                                  200, 131, 221, 93), // Border color
                              width: 2.0, // Border width
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 1, // Shadow spread
                                blurRadius: 6, // Shadow blur
                                offset: Offset(0, 1), // Shadow position
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Mandi Rates Fetcher',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Real time Price Updates',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Image.asset('assets/Vector (1).png'),
                              ],
                            ),
                          ),
                        ),
                      ),
                           ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to another screen when tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Uploadpage()), // Replace 'TargetScreen' with your screen
                          );
                        },
                        child: Center(
                          child: Container(
                            height: 100.0,
                            width: 400.0,
                            decoration: BoxDecoration(
                              color: Colors.white, // Background color
                              borderRadius: BorderRadius.circular(
                                  15.0), // Rounded corners
                              border: Border.all(
                                color: Color.fromARGB(
                                    200, 131, 221, 93), // Border color
                                width: 2.0, // Border width
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), // Shadow color
                                  spreadRadius: 1, // Shadow spread
                                  blurRadius: 6, // Shadow blur
                                  offset: Offset(0, 1), // Shadow position
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Free AI Quality Analysis',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'AI Powered Quality Monitoring',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Image.asset(
                                      'assets/streamline_ai-generate-landscape-image-spark-solid.png'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(
                  //     "BLOG POSTS",
                  //     style: TextStyle(
                  //       fontSize: 23,
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.w700,
                  //     ),
                  //     maxLines: 2,
                  //     textAlign: TextAlign.left,
                  //   ),
                  // ),
                ],
              )),
        ));
  }
}





