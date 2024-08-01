import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/constants/AppConstants.dart';
import 'package:krishi_customer_app/views/consumer%20ui/signupscreen%201.dart';
import 'package:krishi_customer_app/views/farmerui/menubar.dart';
import 'package:krishi_customer_app/views/farmerui/upload.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen(
      {super.key, required this.initialScreen, required this.farmerscreen});
  final Widget initialScreen;
  final Widget farmerscreen;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,   // Starting point of the gradient
      // end: Alignment.bottomLeft, // Ending point of the gradient
      colors: [
        Color.fromRGBO(6, 246, 34, 1).withOpacity(1), // Gradient color with opacity
        Color.fromARGB(0, 215, 12, 12),           // No color at the end
      ],
      stops: [0.5, 0.5],              // Define the point where the gradient stops
    ),
  ),
      child: Scaffold(
        backgroundColor: Colors.white, 
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/krishi-logo.png"),
              SizedBox(height: 80),
              Container(
                width: 350,
                child: Text("Join us & start your journey with Krishi Mandi",
                style:TextStyle(
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
                    side: BorderSide(color: Color.fromRGBO(74, 230, 50, 0.961), width: 2.0),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 100, vertical: 15), // Button size
                ),
                onPressed: () {
                  AppContants.isfarmer = false;
                  Get.to(widget.initialScreen);
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
                  AppContants.isfarmer = true;
                  // Get.to(widget.farmerscreen);
                                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Uploadpage(),
                              ),
                            );
                  // Add navigation or functionality here for farmer
                },
                child: Text(
                  "Continue as Farmer",
                  style: TextStyle(color: Colors.black), // Text color
                ),
              ),
             SizedBox(height: 10),
             RichText(
  text: TextSpan(
    text: 'New here? ', // Normal text
    style: TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
    children: <TextSpan>[
      TextSpan(
        text: 'Sign up',
        style: TextStyle(
          color: Colors.greenAccent, // Color for the clickable text
          fontWeight: FontWeight.bold,
        ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Navigate to the SignUpScreen when "Sign up" is clicked
                Get.to(SignUpScreen()); // Using GetX for navigation
                // or use Navigator.push if not using GetX
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SignUpScreen()),
                // );
              },
      ),
    ],
  ),
)
            ],
          ),
        ),
      ),
    );
  }
}
