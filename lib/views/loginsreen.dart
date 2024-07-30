import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:krishi_customer_app/controller/customer_apis/authcontroller.dart';
import 'package:krishi_customer_app/views/signupscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());
  bool _isChecked = false;
  bool _isButtonDisabled = false;
  int _timerCount = 60;
  Timer? _timer;

  void _hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Future<void> _startTimer() async {
    const oneSec = Duration(seconds: 1);
    setState(() {
      _isButtonDisabled = true; // Disable button while timer is running
      _timerCount = 60; // Reset timer count
    });

    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_timerCount == 0) {
        setState(() {
          timer.cancel();
          _isButtonDisabled = false; // Enable button after timer ends
        });
      } else {
        setState(() {
          _timerCount--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _hideKeyboard(context); // Hide keyboard when tapped outside
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset('assets/krishi_farm_logo.png', fit: BoxFit.cover),
                ),
                Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(height: 50),
                MyTextFieldWithLabel(
                  label: "Mobile Number",
                  controller: _passwordController,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
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
                          fillColor: MaterialStateProperty.resolveWith<Color?>(
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
                GradientButton(
                  label: _timerCount > 0 ? '$_timerCount seconds' : 'Resend OTP',
                  onPressed: _isButtonDisabled
                      ? null
                      : () {
                          if (_passwordController.text.isEmpty) {
                            Get.snackbar("Error", "Please fill in all fields.");
                            return;
                          } else if (!_isChecked) {
                            Get.snackbar("Error", "Please select terms and conditions");
                            return;
                          }
                          setState(() {
                            _isButtonDisabled = true;
                          });

                          // Start the timer and proceed with login
                          _startTimer().then((_) async {
                            await _authController.signIn(_passwordController.text, context);
                            if (_authController.isSignedIn.value) {
                              showDialog(
                                context: context,
                                builder: (context) => OTPDialog(
                                  onClose: () {
                                    Navigator.pop(context); // Close the OTP dialog
                                  },
                                  mobileNumber: _passwordController.text,
                                ),
                              );
                            }
                          }).catchError((error) {
                            print("Error starting timer: $error");
                            setState(() {
                              _isButtonDisabled = false; // Reset button state on error
                            });
                          });
                        },
                  widget: _authController.isLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: 180,
                    child: Row(
                      children: [
                        Text(
                          'New User ?  ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(SignUpScreen());
                          },
                          child: Text(
                            'SIGN UP',
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
  final VoidCallback? onPressed;
  final Widget widget;

  const GradientButton({
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

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isRegistered = false.obs;
  var isSignedIn = false.obs;
  var isOtpVerified = false.obs;

  final String baseUrl = 'http://43.204.188.100:3000/auth'; // Replace with your base URL

  // Sign in a user
  Future<void> signIn(String mobileNumber, BuildContext context) async {
    isLoading(true);
    final url = Uri.parse('$baseUrl/sign-in');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'mobileNumber': mobileNumber});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        var respo = jsonDecode(response.body);
        if (respo["status"] == true) {
          isSignedIn(true);
        } else {
          Get.snackbar("Error", respo["message"]);
          isSignedIn(false);
        }
      } else {
        isSignedIn(false);
      }
    } catch (e) {
      print('Error: $e');
      isSignedIn(false);
    } finally {
      isLoading(false);
    }
  }
}

class OTPDialog extends StatelessWidget {
  final Function onClose;
  final String mobileNumber;

  const OTPDialog({Key? key, required this.onClose, required this.mobileNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Enter OTP"),
      content: TextField(
        decoration: InputDecoration(hintText: "Enter OTP here"),
      ),
      actions: [
        TextButton(
          onPressed: onClose(), // Corrected function call
          child: Text("Close"),
        ),
        TextButton(
          onPressed: () {},
          child: Text("Verify"),
        ),
      ],
    );
  }
}
