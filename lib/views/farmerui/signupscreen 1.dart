import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/views/farmerui/loginsreen.dart' as log;
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

  final _formKey = GlobalKey<FormState>();

  // Function to hide the keyboard when tapped outside of text fields
  void _hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    } else if (value.length < 3) {
      return "Name must be at least 3 characters";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!RegExp(r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
        .hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    } else if (!RegExp(r"^\d{10}$").hasMatch(value)) {
      return "Enter a valid 10-digit phone number";
    }
    return null;
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
            child: Form(
              key: _formKey,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Farmer Sign Up",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
                      validator: validateName,
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
                      validator: validateEmail,
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
                      validator: validatePhone,
                    ),

                    // Terms and Conditions Checkbox
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
                                    return Colors.green;
                                  }
                                  return null;
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

                    // Sign-Up Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(74, 230, 50, 0.961),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate() && _isChecked) {
                          // Proceed with registration
                          await controller.registerUser(
                            _nameController.text,
                            _emailController.text,
                            _phoneController.text,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpScreenfarm(
                                mobileNumber: _phoneController.text,
                              ),
                            ),
                          );
                        } else if (!_isChecked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Please accept terms and conditions'),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Create Account",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),

                    // Redirect to Login
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have an account?  ',
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
