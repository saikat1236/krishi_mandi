import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/controller/customer_apis/authcontroller.dart';
import 'package:krishi_customer_app/views/consumer%20ui/loginsreen.dart' as log;
import 'package:krishi_customer_app/views/consumer%20ui/otpscreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController controller = Get.put(AuthController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Form key for validation
  bool _isChecked = false;

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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    SizedBox(height: 80),
                    // Name Field
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Name',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        } else if (value.length < 3) {
                          return 'Name must be at least 3 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // Email Field
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'E-mail',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        final emailRegex =
                            RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        } else if (!emailRegex.hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // Phone Number Field
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Phone Number',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your mobile number',
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone number is required';
                        } else if (value.length != 10) {
                          return 'Phone number must be exactly 10 digits';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // Terms and Conditions Checkbox
                    Row(
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
                                return Colors.green;
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text('I understood the ', style: TextStyle(fontSize: 12.0)),
                        Text(
                          'terms and conditions',
                          style: TextStyle(color: Colors.green, fontSize: 14.0),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(74, 230, 50, 0.961),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate() && _isChecked) {
                          // If form is valid and terms accepted
                          await controller.registerUser(
                            _nameController.text,
                            _emailController.text,
                            _phoneController.text,
                          );

                          // Navigate to the OTP screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpScreen2(
                                mobileNumber: _phoneController.text,
                              ),
                            ),
                          );
                        } else if (!_isChecked) {
                          // Show error if terms are not accepted
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please accept the terms and conditions'),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Create Account",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have an account? ',
                            style: TextStyle(fontSize: 12.0),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(log.LoginScreen());
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
