import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/controller/customer_apis/authcontroller.dart';
import 'package:krishi_customer_app/views/consumer%20ui/add_address.dart';

// import 'package:krishi_customer_app/views/consumer%20ui/address.dart';
import 'package:krishi_customer_app/views/consumer%20ui/otpdialog.dart';
import 'package:krishi_customer_app/views/consumer%20ui/otpscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/sec.dart';
import 'package:krishi_customer_app/views/consumer%20ui/signupscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/update_address.dart';
import 'package:krishi_customer_app/models/address.dart';

class ProfileScreenmain extends StatefulWidget {
  const ProfileScreenmain({Key? key}) : super(key: key);

  @override
  State<ProfileScreenmain> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreenmain> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final AuthController controller = Get.put(AuthController());
  bool _isChecked = false;

  // final Address address2 = Address(
  //   name: 'John Doe',
  //   mobile: '1234567890',
  //   email: 'john@example.com',
  //   addressLine1: '123 Main St',
  //   city: 'Springfield',
  //   pin: 12345,
  // );

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
        appBar: AppBar(
          // backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,

          title: const Text('Profile',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context); // Navigate back
                },
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      // Image.asset(
                      //   'assets/photo.png',
                      //   height: 100.0, // Set the desired height
                      //   width: 100.0, // Set the desired width
                      //   fit: BoxFit.cover,
                      //    // Optional: Define how the image should fit within its bounds
                      // ),
                      CircleAvatar(
                        radius: 40.0, // Radius of the circle
                        backgroundImage: AssetImage('assets/avatar.png'),
                      ),
                      Padding(
                        // padding: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Saikat Biswas",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text("saikat1236@gmail.com"),
                            Text("+91 7085959167")
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 200,
                            width: 550,
                            decoration: BoxDecoration(
                              // color: Colors.grey[200],
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: 2.0, // Border width
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0), // Radius for all corners
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text('Default'),
                                        // Spacer(),
                                        // Text('Delete'),
                                      ],
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(left: 30, top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Text("Saikat Biswas",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Text(
                                            "Boroj colony, Belonia, Tripura 799155"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Text("+91 7085959167"),
                                      ),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors
                                                  .green, // Background color
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        18.0), // Rounded edges
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 30,
                                                  vertical: 10), // Button size
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdShippingAddressScreen(
                                                          address: Address(
                                                    name: 'John Doe',
                                                    mobile: '1234567890',
                                                    email: 'john@example.com',
                                                    addressLine1: '123 Main St',
                                                    addressLine2: 'Apt 4B',
                                                    city: 'Springfield',
                                                    pin: 12345,
                                                  )),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Edit",
                                              style: TextStyle(
                                                  color: Colors
                                                      .white), // Text color
                                            ),
                                          ),
                                          SizedBox(width: 30),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      244,
                                                      67,
                                                      54,
                                                      1), // Background color
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        18.0), // Rounded edges
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 30,
                                                  vertical: 10), // Button size
                                            ),
                                            onPressed: () {
                                              // Get.to(widget.initialScreen);
                                              // Add navigation or functionality here for consumer
                                            },
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                  color: Colors
                                                      .white), // Text color
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 200,
                            width: 550,
                            decoration: BoxDecoration(
                              // color: Colors.grey[200],
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: 2.0, // Border width
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0), // Radius for all corners
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Default'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 30, top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Text("Saikat Biswas",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Text(
                                            "Boroj colony, Belonia, Tripura 799155"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Text("+91 7085959167"),
                                      ),
                                      Row(children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors
                                                .green, // Background color
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      18.0), // Rounded edges
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30,
                                                vertical: 10), // Button size
                                          ),
                                          onPressed: () {
                                            // Get.to(widget.initialScreen);
                                            // Add navigation or functionality here for consumer
                                          },
                                          child: Text(
                                            "Edit",
                                            style: TextStyle(
                                                color:
                                                    Colors.white), // Text color
                                          ),
                                        ),
                                        SizedBox(width: 30),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromRGBO(244, 67,
                                                    54, 1), // Background color
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      18.0), // Rounded edges
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30,
                                                vertical: 10), // Button size
                                          ),
                                          onPressed: () {
                                            // Get.to(widget.initialScreen);
                                            // Add navigation or functionality here for consumer
                                          },
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                                color:
                                                    Colors.white), // Text color
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 200,
                            width: 550,
                            decoration: BoxDecoration(
                              // color: Colors.grey[200],
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: 2.0, // Border width
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0), // Radius for all corners
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Default'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 30, top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Text("Saikat Biswas",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Text(
                                            "Boroj colony, Belonia, Tripura 799155"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Text("+91 7085959167"),
                                      ),
                                      Row(children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors
                                                .green, // Background color
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      18.0), // Rounded edges
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30,
                                                vertical: 10), // Button size
                                          ),
                                          onPressed: () {
                                            // Get.to(widget.initialScreen);
                                            // Add navigation or functionality here for consumer
                                          },
                                          child: Text(
                                            "Edit",
                                            style: TextStyle(
                                                color:
                                                    Colors.white), // Text color
                                          ),
                                        ),
                                        SizedBox(width: 30),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromRGBO(244, 67,
                                                    54, 1), // Background color
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      18.0), // Rounded edges
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30,
                                                vertical: 10), // Button size
                                          ),
                                          onPressed: () {
                                            // Get.to(widget.initialScreen);
                                            // Add navigation or functionality here for consumer
                                          },
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                                color:
                                                    Colors.white), // Text color
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  )

                  // Mobile Number TextField
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Align(
                  //     alignment:
                  //         Alignment.centerLeft, // Aligns child to the left
                  //     child: Text(
                  //       'Phone Number',
                  //       style: TextStyle(fontSize: 16),
                  //       textAlign:
                  //           TextAlign.left, // Aligns text within its own bounds
                  //     ),
                  //   ),
                  // ),
                  // TextField(
                  //   controller: _phoneController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     hintText: 'Enter your mobile number',
                  //   ),
                  //   keyboardType: TextInputType.phone,
                  // ),
                  // SizedBox(height: 30),
                  //         ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //             backgroundColor: Color.fromRGBO(74, 230, 50, 0.7),
                  //             // Background color
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(30.0),
                  //               // side: BorderSide(color: Colors.black, width: 2.0),
                  //               // Rounded edges
                  //             ),
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: 100, vertical: 15), // Button size
                  //           ),
                  //             // InkWell(
                  //             //       onTap: () {
                  //             //         Get.to(log.LoginScreen());
                  //             //       },
                  //             // ),
                  //           // onPressed: () {

                  //             // controller.signIn(_phoneController.text,context);

                  //             // showDialog(
                  //             //   context: context,
                  //             //   builder: (context) => OTPDialog(
                  //             //     onClose: () {
                  //             //       Navigator.pop(context); // Close the OTP dialog
                  //             //     },
                  //             //     mobileNumber: _phoneController.text,
                  //             //   ),
                  //             // );
                  //           // },
                  //            onPressed: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => OtpScreen2(),
                  //     ),
                  //   );
                  // },
                  //           child: Container(
                  //             width: 350,
                  //             child: Center(
                  //               child: Text(
                  //                 "Continue",
                  //                 style: TextStyle(color: Colors.white), // Text color
                  //               ),
                  //             ),
                  //           ),
                  //         ),
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
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10),
                  //   child: Container(
                  //     width: 140,
                  //     child: Row(
                  //       children: [
                  //         Text(
                  //           'New to here ?  ',
                  //           style: TextStyle(
                  //             color: Colors.black,
                  //             fontSize: 12.0,
                  //           ),
                  //         ),
                  //         InkWell(
                  //           onTap: () {
                  //             // Get.to(log.LoginScreen());
                  //           },
                  //           child: Text(
                  //             'Sign Up',
                  //             style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.green,
                  //               fontSize: 14.0,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 80,),
                  // Image.asset("assets/pana.png"),
                ],
              ),
            ),
          ),
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            // print('FAB pressed!'); AddShippingAddressScreen ShippingAddressesScreen
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddShippingAddressScreen(),
                ));
          },
          child: Icon(Icons.add, size: 30),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        // Other properties such as body go here
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       _hideKeyboard(context); // Hide keyboard when tapped outside
  //     },
  //     child: Scaffold(
  //       body: SingleChildScrollView(
  //         child: Container(
  //           height: MediaQuery.of(context).size.height,
  //           width: MediaQuery.of(context).size.width,

  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //                CircleAvatar(
  //                           radius: 50,
  //                           backgroundColor: Colors.transparent,
  //                           child: Container(
  //                             width: 150,
  //                             height: 150,
  //                             decoration: BoxDecoration(
  //                               shape: BoxShape.circle,
  //                               image: DecorationImage(
  //                                 fit: BoxFit.cover,
  //                                 image: AssetImage('assets/krishi_farm_logo.png'),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                SizedBox(height: 20),

  //               Text(
  //                 "Login",
  //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
  //               ),
  //               SizedBox(height: 50),
  //               // MyTextFieldWithLabel(
  //               //   label: "Name",
  //               //   controller: _usernameController,
  //               // ),
  //               MyTextFieldWithLabel(
  //                 label: "Mobile Number",
  //                 controller: _passwordController,
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 50),
  //                 child: Container(
  //                   width: 330,
  //                   child: Row(
  //                     children: [
  //                       Checkbox(
  //                         value: _isChecked,
  //                         onChanged: (bool? value) {
  //                           setState(() {
  //                             _isChecked = value ?? false;
  //                           });
  //                         },
  //                         checkColor: Colors.white,
  //                         fillColor: MaterialStateProperty.resolveWith<Color?>(
  //                           (Set<MaterialState> states) {
  //                             if (states.contains(MaterialState.selected)) {
  //                               return Colors.green; // Checked color
  //                             }
  //                             return null; // Unchecked color
  //                           },
  //                         ),
  //                         shape: RoundedRectangleBorder(
  //                           side: BorderSide(color: Colors.green),
  //                           borderRadius: BorderRadius.circular(4.0),
  //                         ),
  //                       ),
  //                       SizedBox(width: 8.0),
  //                       Text(
  //                         'I understood the ',
  //                         style: TextStyle(
  //                           color: Colors.black,
  //                           fontSize: 12.0,
  //                         ),
  //                       ),
  //                       Text(
  //                         'terms and conditions',
  //                         style: TextStyle(
  //                           color: Colors.green,
  //                           fontSize: 14.0,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               GradientButton(
  //                 label: "Login",
  //                 onPressed: () async {
  //                   if (_passwordController.text.isEmpty) {
  //                     Get.snackbar("Error", "Please fill in all fields.");
  //                     return;
  //                   } else if (!_isChecked) {
  //                     Get.snackbar(
  //                         "Error", "Please select terms and conditions");
  //                     return;
  //                   }
  //                   await _authController.signIn(_passwordController.text,context);
  //                  if( _authController.isSignedIn.value){
  //                     showDialog(
  //           context: context,
  //           builder: (context) => OTPDialog(

  //             onClose: () {
  //             Navigator.pop(context); // Close the OTP dialog
  //           }, mobileNumber: _passwordController.text,),
  //         );
  //                  }
  //                 },
  //                 widget:
  //                 !_authController.isLoading.value?
  //                  Text(
  //         "Login",
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontSize: 16,
  //         ),
  //       ):CircularProgressIndicator(color: Colors.white),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 20),
  //                 child: Container(
  //                   width: 180,
  //                   child: Row(
  //                     children: [
  //                       Text(
  //                         'New User ?  ',
  //                         style: TextStyle(
  //                           color: Colors.black,
  //                           fontSize: 12.0,
  //                         ),
  //                       ),
  //                       InkWell(
  //                         onTap: () {
  //                           Get.to(SignUpScreen());
  //                         },
  //                         child: Text(
  //                           'SIGN UP',
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.green,
  //                             fontSize: 14.0,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
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
