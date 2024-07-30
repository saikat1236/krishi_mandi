import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/views/farmerui/menubar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.initialScreen, required this.farmerscreen});
  final Widget initialScreen;
  final Widget farmerscreen;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/krishi_farm_logo.png"),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0), // Rounded edges
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 50, vertical: 15), // Button size
              ),
              onPressed: () {
                Get.to(widget.initialScreen);
                // Add navigation or functionality here for consumer
              },
              child: Text(
                "Continue as Consumer",
                style: TextStyle(color: Colors.white), // Text color
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0), // Rounded edges
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 50, vertical: 15), // Button size
              ),
              onPressed: () {
                Get.to(widget.farmerscreen);
                // Add navigation or functionality here for farmer
              },
              child: Text(
                "Continue as Farmer",
                style: TextStyle(color: Colors.white), // Text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
