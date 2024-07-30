import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../farmerui/loginscreen.dart';

class MneuBar extends StatefulWidget {
  const MneuBar({super.key});

  @override
  State<MneuBar> createState() => _MneuBarState();
}

class _MneuBarState extends State<MneuBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            padding: const EdgeInsets.only(top: 200),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                          height: 200,
                          child: Image.asset('assets/krishi_farm_logo.png')),
                      const Text(
                        "Explore the application",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      const Text(
                        "Now your finances are in one place\n      and always under control",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      SizedBox(height: 200),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(FarmerLoginScreen());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Background color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white, // Text color
                              fontWeight: FontWeight.bold, // Bold text
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}
