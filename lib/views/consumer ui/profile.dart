import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/controller/customer_apis/user_controller.dart';
import 'package:krishi_customer_app/models/address.dart';
import 'package:krishi_customer_app/views/consumer%20ui/add_address.dart';
import 'package:krishi_customer_app/views/consumer%20ui/cartscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/update_address.dart';

import '../../controller/customer_apis/addresscontroller.dart';
import '../../controller/customer_apis/profile_controller.dart';

class ProfileScreenmain extends StatefulWidget {
  const ProfileScreenmain({Key? key}) : super(key: key);

  @override
  State<ProfileScreenmain> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreenmain> {
  final UserController userController = Get.put(UserController());
  final UserProfileController userProfileController =
      Get.find<UserProfileController>();

  void _hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  void initState() {
    super.initState();
    // Schedule the loading dialog to show after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _showLoadingDialog();

      // Fetch the user profile and close the dialog after a 2-second delay
      userProfileController.getUserProfile().then((_) {
        Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            // Get.back(); // Close the loading dialog after a 2-second delay
          }
        });
      });
    });
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(20), // Add padding around content
          content: SizedBox(
            width: 200, // Set a fixed width for the dialog
            height: 100, // Set a fixed height for the dialog
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center content vertically
              children: [
                Text(
                  "Profile page is Loading...",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20), // Space between spinner and text
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _hideKeyboard(context); // Hide keyboard when tapped outside
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
                backgroundColor: Color(0xFF2E2E2E),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Profile',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back,color: Colors.white),
                onPressed: () {
                  Navigator.pop(context); // Navigate back
                },
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart,color: Colors.white,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartListScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person,color: Colors.white,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreenmain(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Obx(() {
          if (userController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
            // _showLoadingDialog();
          } else {
            if (userController.user.isEmpty) {
              return Center(child: Text("No user data found."));
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 104, // 2 * radius of 52
                              height: 104, // 2 * radius of 52
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  userController.user['imageProfile'] != null &&
                                          userController
                                              .user['imageProfile'].isNotEmpty
                                      ? userController.user['imageProfile']
                                      : '',
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Image.asset(
                                      'assets/avatar3.jpg',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userController.user['userName'] ?? '',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(userController.user['email'] ?? ''),
                                  Text(userController.user['mobileNumber'] ??
                                      ''),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        AddressCard(userController: userController)
                        // Column(
                        //   children: List.generate(3, (index) {
                        //     return AddressCard(userController: userController);
                        //   }),
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddShippingAddressScreen(),
              ),
            );
          },
          child: Icon(Icons.add, size: 30),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  const AddressCard({
    Key? key,
    required this.userController,
  }) : super(key: key);

  final UserController userController;

  @override
  Widget build(BuildContext context) {
    // Extract the list of addresses from the user data
    List<dynamic> addressList = userController.user['Address'] ?? [];
    String userName = userController.user['userName'] ?? '';
    String mobileNumber = userController.user['mobileNumber'] ?? '';
    String email = userController.user['email'] ?? '';
    final ShippingAddressController shippingAddressController =
        Get.put(ShippingAddressController());

    if (addressList.isEmpty) {
      return SafeArea(child: Center(child: Text("Your haven't added any address")));
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('User Details',
            //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // SizedBox(height: 10),
            // Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: Text(
            //     'Name: $userName',
            //     style: TextStyle(fontWeight: FontWeight.w700),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: Text('Mobile: $mobileNumber'),
            // ),
            // SizedBox(height: 10),
            Text('Addresses',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            // Display all addresses with action buttons
            ...addressList.map((address) {
              if (address is Map) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$userName',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              Text('$mobileNumber'),
                              Text(
                                '${address['addressLine1'] ?? 'Address Line 1'}, '
                                '${address['addressLine2'] ?? 'Address Line 2'}, '
                                '${address['city'] ?? 'City'}, '
                                '${address['pin']?.toString() ?? 'PIN Code'}',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.green, // Background color
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10), // Button size
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UpdShippingAddressScreen(
                                                  address: Address(
                                                    name: '$userName' ?? '',
                                                    mobile:
                                                        '$mobileNumber' ?? '',
                                                    email: '$email' ?? '',
                                                    addressLine1: address[
                                                            'addressLine1'] ??
                                                        '',
                                                    addressLine2: address[
                                                            'addressLine2'] ??
                                                        '',
                                                    city: address['city'] ?? '',
                                                    // pin: address['pin'] ?? '',
                                                    // addressId: address['addressId']
                                                  ),
                                                  addressId:
                                                      address['addressId'] ??
                                                          ''),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromRGBO(
                                          244, 67, 54, 1), // Background color
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10), // Button size
                                    ),
                                    onPressed: () {
                                      // Add delete functionality here
                                      print(
                                          'Delete address with ID: ${address['addressId']}');
                                      shippingAddressController.deleteAddress(
                                          addressId: address['addressId']);
                                    },
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: Radio(
                          value: true,
                          groupValue: address["default"] ==
                              true, // Check if this address is default
                          onChanged: (value) {
                            if (value == true) {
                              shippingAddressController.setDefaultAddress(
                                addressId: address['addressId'],
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                //  if (userProfileController.cartItems.isEmpty) {
                return Center(child: Text('Your havent added any address'));
                // }
                // return SizedBox
                //     .shrink(); // Return an empty widget if address is not a map
              }
            }).toList(),
          ],
        ),
      );
    }
  }
}
