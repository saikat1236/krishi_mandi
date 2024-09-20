import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/constants/AppConstants%201.dart';
import 'package:krishi_customer_app/views/farmerui/loginsreen.dart' as log;
import 'package:krishi_customer_app/views/consumer%20ui/otpdialog.dart';
import 'package:krishi_customer_app/views/consumer%20ui/otpscreen.dart';
import 'package:krishi_customer_app/views/farmerui/otpscreen.dart';

import '../../controller/farmer_apis/authcontroller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FarmAuthController controller = Get.put(FarmAuthController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isChecked = false;

  // Function to hide the keyboard when tapped outside of text fields
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
                    "Sign Up",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment:
                          Alignment.centerLeft, // Aligns child to the left
                      child: Text(
                        'Name',
                        style: TextStyle(fontSize: 16),
                        textAlign:
                            TextAlign.left, // Aligns text within its own bounds
                      ),
                    ),
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your name',
                    ),
                  ),
                  SizedBox(height: 16), // Spacing between fields

                  // Email TextField
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment:
                          Alignment.centerLeft, // Aligns child to the left
                      child: Text(
                        'E-mail',
                        style: TextStyle(fontSize: 16),
                        textAlign:
                            TextAlign.left, // Aligns text within its own bounds
                      ),
                    ),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter you email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16), // Spacing between fields

                  // Mobile Number TextField
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment:
                          Alignment.centerLeft, // Aligns child to the left
                      child: Text(
                        'Phone Number',
                        style: TextStyle(fontSize: 16),
                        textAlign:
                            TextAlign.left, // Aligns text within its own bounds
                      ),
                    ),
                  ),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your mobile number',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      width: 330,
                      child: Row(
                        children: [
                          Checkbox(
                            value: _isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value ?? false;
                              });
                            },
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Colors.green; // Checked color
                                }
                                return null; // Unchecked color
                              },
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'I understood the ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            'terms and conditions',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(74, 230, 50, 0.961),
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
                      // Register the user and get the success status
                      print(_nameController.text +
                          _emailController.text +
                          _phoneController.text);
                      await controller.registerUser(_nameController.text,
                          _emailController.text, _phoneController.text);

                      // Check if registration was successful
                      if (true) {
                        // Navigate to the OtpScreen2 and pass the mobile number
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpScreenfarm(
                              mobileNumber: _phoneController
                                  .text, // Pass the mobile number here
                            ),
                          ),
                        );
                      } else {
                        // Handle registration failure (e.g., show an error message)
                        // You can use a SnackBar or any other method to inform the user
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Registration failed. Please try again.'),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Create Account",
                      style: TextStyle(color: Colors.black), // Text color
                    ),
                  ),
                  //       GradientButton(
                  //         label: "Create Account",
                  //         onPressed: (){
                  //           controller.registerUser(_nameController.text,_emailController.text,_phoneController.text);

                  //             showDialog(
                  //   context: context,
                  //   builder: (context) => OTPDialog(

                  //     onClose: () {
                  //     Navigator.pop(context); // Close the OTP dialog
                  //   }, mobileNumber: _phoneController.text,),
                  // );

                  //         },
                  //         widget:  !controller.isLoading.value?
                  //          Text(
                  // "Login",
                  // style: TextStyle(
                  //   color: Colors.white,
                  //   fontSize: 16,
                  // ),
                  //         ):CircularProgressIndicator(color: Colors.white),
                  //       ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: 180,
                      child: Row(
                        children: [
                          Text(
                            'Have an account ?  ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(log.LoginScreenfarm());
                            },
                            child: Text(
                              'Login In',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
