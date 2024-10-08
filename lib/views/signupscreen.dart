import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/controller/customer_apis/authcontroller.dart';
import 'package:krishi_customer_app/views/loginsreen.dart'as log;
import 'package:krishi_customer_app/views/otpdialog.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController controller = Get.put(AuthController());
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

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
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create your account",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                log.MyTextFieldWithLabel(
                  label: "Name",
                  controller: _nameController,
                ),
                log.MyTextFieldWithLabel(
                  label: "Email",
                  controller: _emailController,
                ),
                log.MyTextFieldWithLabel(
                  label: "Mobile Number",
                  controller: _phoneController,
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
                  label: "Create Account",
                  onPressed: (){
                    controller.registerUser(_nameController.text,_emailController.text,_phoneController.text);
                    if( controller.isSignedIn.value){
                      showDialog(
            context: context,
            builder: (context) => OTPDialog(
             
              onClose: () {
              Navigator.pop(context); // Close the OTP dialog
            }, mobileNumber: _phoneController.text,),
          );
                   }
                  },
                  widget:  !controller.isLoading.value?
                   Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ):CircularProgressIndicator(color: Colors.white),
                ),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
