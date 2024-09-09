import 'dart:convert';

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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

class FarmHome extends StatefulWidget {
  const FarmHome();

  @override
  State<FarmHome> createState() => _FarmHomeState();
}

class _FarmHomeState extends State<FarmHome> {
  int? _temperature;
  String? cond;
  String? loc;
  int? htemp;
  int? ltemp;
  // Replace with your API endpoint
  final String apiUrl = 'http://54.159.124.169:3000/common/forecast-weather';

  Future<void> fetchWeatherData(double lat, double lon) async {
    try {
      // Fetch the token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // String? token = prefs.getString('token');
      String token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIzMmUxZGViMi01YWQyLTRkNDQtYWJjOS1hZTAyMjU0Zjc4ZmYiLCJ1c2VyVHlwZSI6ImNvbnN1bWVyIiwiaWF0IjoxNzI1ODkzOTcyfQ.YoMldPlLkuWm3OZIHEdvAltMB4dLqVdCNmYiKdY6hxY";

      if (token == null) {
        // Handle the case where the token is missing
        print('Token is missing');
        return;
      }

      // Prepare the request body with lat and lon
      final body = json.encode({"lat": lat, "lan": lon});

      // Prepare the headers with Authorization
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token, // Add 'Bearer' before the token
      };

      // Make the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // Successfully received a response
        print('Weather data: ${response.body}');
        final jsonData = jsonDecode(response.body);
        setState(() {
          var payload = jsonData["payload"];
          var day = payload["days"];
          double? temperature = day[0]["temp"]?.toDouble();
          _temperature = temperature!.round();
          cond = day[0]["conditions"];
          loc = payload["timezone"];
          htemp = day[0]["tempmax"].round();
          ltemp = day[0]["tempmin"].round();
          print(_temperature);
          print(cond);
        });
        // You can now handle the response and update the UI or state as needed
      } else {
        print(
            'Failed to fetch weather data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  Future<void> _getLocationAndFetchWeather() async {
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
          print('Location permissions are denied');
          return;
        }
      }

      // Get current location
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      // Fetch weather data with current location
      fetchWeatherData(position.latitude, position.longitude);
    } catch (e) {
      print('Error getting location: $e');
    }
  }


  @override
  void initState() {
    super.initState();
    // _loadImageFromAssets();
     _getLocationAndFetchWeather(); 
    // fetchWeatherData();
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
                              image: AssetImage("assets/Rectangle 39.png"),
                              fit: BoxFit
                                  .contain, // Adjust the image fit as per your design
                            ),
                          ),
                          child: _temperature == null ||
                                  cond == null ||
                                  loc == null
                              ? Center(
                                  child:
                                      CircularProgressIndicator()) // Show a loading indicator while data is being fetched
                              : Stack(
                                  children: [
                                    Positioned(
                                        top: 30,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start, // To align all texts to the left
                                            children: [
                                              Text(
                                                "$_temperature°",
                                                style: TextStyle(
                                                  color: Colors
                                                      .white, // Text color
                                                  fontSize: 60, // Font size
                                                  fontWeight: FontWeight
                                                      .w500, // Font weight
                                                ),
                                              ),
                                              Text(
                                                "H: $htemp° L: $ltemp°",
                                                style: TextStyle(
                                                  color: Colors
                                                      .white, // Text color
                                                  fontSize: 16, // Font size
                                                  fontWeight: FontWeight
                                                      .w400, // Medium weight
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "$loc",
                                                    style: TextStyle(
                                                      color: Colors
                                                          .white, // Text color
                                                      fontSize: 16, // Font size
                                                      fontWeight: FontWeight
                                                          .w500, // Regular weight
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          30), // Add some space between the two texts
                                                  Text(
                                                    "$cond",
                                                    style: TextStyle(
                                                      color: Colors
                                                          .white, // Text color
                                                      fontSize: 17, // Font size
                                                      fontWeight: FontWeight
                                                          .w400, // Regular weight
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                    Positioned(
                                      top: 0, // Places the image at the top
                                      right: 0, // Places the image at the right
                                      child: Image.asset(
                                        'assets/Group 52.png',
                                        width:
                                            220, // Adjust the width as needed
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
                        )),
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
