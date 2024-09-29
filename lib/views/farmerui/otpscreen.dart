import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:krishi_customer_app/global_auth.dart';
import 'package:krishi_customer_app/views/consumer%20ui/otpdialog.dart';
import 'package:krishi_customer_app/views/consumer%20ui/signupscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/homescreen.dart';

import 'package:krishi_customer_app/views/farmerui/f-homepage.dart';

import '../../controller/farmer_apis/authcontroller.dart';

class OtpScreenfarm extends StatefulWidget {
  final String mobileNumber;
  const OtpScreenfarm({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  State<OtpScreenfarm> createState() => _OtpScreen2State();
}

class _OtpScreen2State extends State<OtpScreenfarm> {
  // final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final FarmAuthController controller = Get.put(FarmAuthController());
  bool _isChecked = false;
  final _otpControllers = List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    // If value length is 1, move to the next field or unfocus if it's the last field
    if (value.length == 1) {
      if (index < 3) {
        FocusScope.of(context).nextFocus();
      } else {
        FocusScope.of(context).unfocus();
      }
    } else if (value.isEmpty) {
      if (index > 0) {
        FocusScope.of(context).previousFocus();
      }
    }
  }

  void _hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _hideKeyboard(context); // Hide keyboard when tapped outside
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Verify Account",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 350,
                    child: Text(
                      "Code has been send to your phone number. Enter the code to verify your account.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  // Mobile Number TextField
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment:
                          Alignment.centerLeft, // Aligns child to the left
                      child: Text(
                        'Enter OTP',
                        style: TextStyle(fontSize: 16),
                        textAlign:
                            TextAlign.left, // Aligns text within its own bounds
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Container(
                        // width: 60,
                        width: (MediaQuery.of(context).size.width - 140) / 4,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextField(
                          controller: _otpControllers[index],
                          onChanged: (value) => _onChanged(value, index),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: '', // Hide counter text
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      );
                    }),
                  ),
                  // SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(top: 150, bottom: 150),
                    child: Column(
                      children: [
                        //   Text(
                        //     "Didn’t Receive Code? Resend Code",
                        //     style: TextStyle(color: Colors.grey), // Text color
                        //   ),
                        //   SizedBox(height: 10,),
                        // Text(
                        //   "Resend code in 00:59",
                        //   style: TextStyle(color: Colors.grey), // Text color
                        // ),
                      ],
                    ),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(74, 230, 50, 0.7),
                      // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        // side: BorderSide(color: Colors.black, width: 2.0),
                        // Rounded edges
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 100, vertical: 15), // Button size
                    ),
                    onPressed: () async {
                      // Verify OTP
                      String otp = _otpControllers
                          .map((controller) => controller.text)
                          .join('');
                      print("number " + widget.mobileNumber + ", otp: " + otp);

                      await controller.verifyOtp(widget.mobileNumber, otp);

                      // If OTP is verified successfully, navigate to HomePage
                      if (controller.isOtpVerified()) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => FarmHome()),
                          (Route<dynamic> route) =>
                              false, // This removes all the previous routes
                        );
                      }
                    },
                    child: Container(
                      width: 350,
                      child: Center(
                        child: Text(
                          "Verify Account",
                          style: TextStyle(color: Colors.white), // Text color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextFieldWithLabel extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const MyTextFieldWithLabel({
    Key? key,
    required this.label,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 20),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          width: 300,
          child: TextFormField(
            cursorColor: Colors.green,
            controller: controller,
            decoration: InputDecoration(
              focusColor: Colors.green,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
              hintText: 'Enter your text here',
            ),
          ),
        ),
      ],
    );
  }
}

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Widget widget;

  GradientButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff52DB22), Color(0xff2C7512)], // White to dark green
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        child: widget,
      ),
    );
  }
}
