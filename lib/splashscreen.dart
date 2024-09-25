import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/constants/AppConstants.dart';
import 'package:krishi_customer_app/views/consumer%20ui/signupscreen%201.dart';
import 'package:krishi_customer_app/views/farmerui/f-homepage.dart';
import 'package:krishi_customer_app/views/farmerui/menubar.dart';
import 'package:krishi_customer_app/views/farmerui/upload.dart';

import 'views/farmerui/loginsreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen(
      {super.key, required this.initialScreen, required this.farmerscreen});
  final Widget initialScreen;
  final Widget farmerscreen;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  //  Future<void> _checkTokenAndNavigate() async {
  //   // Retrieve the token from SharedPreferences
  //   final prefs = await SharedPreferences.getInstance();
  // final token = prefs.getString('token');

  //   // Set the token in AppContants
  //   // AppContants.apptoken = farmertoken ?? ''; // Ensure token is not null

  //   // Determine the initial route based on the token
  //   Widget initialScreen;
  // if (token != null && token.isNotEmpty) {
  //   initialScreen = HomePage(); // Uncomment this if HomeScreen is available
  // } else {
  //   initialScreen = LoginScreen();
  // }

  //   await prefs.remove('farmertoken');

  //   // Navigate to SplashScreen with the determined initialScreen
  //   Get.offAll(() => SplashScreen(
  //         initialScreen: initialScreen, // Navigate to determined screen
  //         farmerscreen: FarmHome(), // Farmer home page or another page based on your need
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter, // Starting point of the gradient
          // end: Alignment.bottomLeft, // Ending point of the gradient
          colors: [
            Color.fromRGBO(6, 246, 34, 1)
                .withOpacity(1), // Gradient color with opacity
            Color.fromARGB(0, 215, 12, 12), // No color at the end
          ],
          stops: [0.5, 0.5], // Define the point where the gradient stops
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/krishi_logo.png"),
              SizedBox(height: 80),
              Container(
                width: 350,
                child: Text(
                  "Join us & start your journey with Krishi Mandi",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 100),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Rounded edges
                    side: BorderSide(
                        color: Color.fromRGBO(74, 230, 50, 0.961), width: 2.0),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 100, vertical: 15), // Button size
                ),
                onPressed: () {
                  // AppContants.isfarmer = false;
                  Get.off(widget.initialScreen);
                  print("customer");
                  // Add navigation or functionality here for consumer
                },
                child: Text(
                  "Continue as Consumer",
                  style: TextStyle(color: Colors.black), // Text color
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.black, width: 2.0),
                    // Rounded edges
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 100, vertical: 15), // Button size
                ),
                onPressed: () {
                  // AppContants.isfarmer = true;
                  Get.off(widget.farmerscreen);
                     print("farmer");
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => LoginScreenfarm(),
                  //   ),
                  // );
                  // Add navigation or functionality here for farmer
                },
                child: Text(
                  "Continue as Farmer",
                  style: TextStyle(color: Colors.black), // Text color
                ),
              ),
              SizedBox(height: 10),
 
            ],
          ),
        ),
      ),
    );
  }
}
