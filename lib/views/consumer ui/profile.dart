import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/controller/customer_apis/user_controller.dart';
import 'package:krishi_customer_app/models/address.dart';
import 'package:krishi_customer_app/views/consumer%20ui/add_address.dart';
import 'package:krishi_customer_app/views/consumer%20ui/update_address.dart';

class ProfileScreenmain extends StatefulWidget {
  const ProfileScreenmain({Key? key}) : super(key: key);

  @override
  State<ProfileScreenmain> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreenmain> {
  final UserController userController = Get.put(UserController());

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
        body: Obx(() {
          if (userController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
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
                            CircleAvatar(
                              radius: 40.0,
                              backgroundImage: NetworkImage(
                                  userController.user['imageProfile']),
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
                child: Container(
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
                          address['addressLine1'] ?? 'Address Line 1',
                          // style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(address['addressLine2'] ?? 'Address Line 2'),
                        Text(address['city'] ?? 'City'),
                        Text(address['pin']?.toString() ?? 'PIN Code'),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green, // Background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10), // Button size
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UpdShippingAddressScreen(
                                      address: Address(
                                        name: '$userName' ?? '',
                                        mobile: '$mobileNumber' ?? '',
                                        email: '$email' ?? '',
                                        addressLine1:
                                            address['addressLine1'] ?? '',
                                        addressLine2:
                                            address['addressLine2'] ?? '',
                                        city: address['city'] ?? '',
                                        pin: address['pin'] ?? 0,
                                      ),
                                    ),
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
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10), // Button size
                              ),
                              onPressed: () {
                                // Add delete functionality here
                                print(
                                    'Delete address with ID: ${address['addressId']}');
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
              );
            } else {
              return SizedBox
                  .shrink(); // Return an empty widget if address is not a map
            }
          }).toList(),
        ],
      ),
    );
  }
}
