import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/views/consumer%20ui/final_order.dart';
import 'package:krishi_customer_app/views/consumer%20ui/homescreen.dart';
import '../../controller/customer_apis/profile_controller.dart'; // Import your controller

class CartListScreen extends StatefulWidget {
  @override
  _CartListScreenState createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  final UserProfileController userProfileController = Get.put(UserProfileController());

  int? _rad; // The currently selected value

  @override
  void initState() {
    super.initState();
    // Fetch the user profile on initialization
    userProfileController.getUserProfile();
  }

  void _increaseQuantity(int index) {
    setState(() {
      userProfileController.cartItems[index]['ProductQuantityAddedToCart']++;
      tot = userProfileController.getCartSubtotal() + vouch; 
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (userProfileController.cartItems[index]['ProductQuantityAddedToCart'] > 1) {
        userProfileController.cartItems[index]['ProductQuantityAddedToCart']--;
        tot = userProfileController.getCartSubtotal() + vouch; 
      }
    });
  }

  var vouch = 0;
  double tot = 0.0; // Initialize tot as double

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
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
        if (userProfileController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (userProfileController.cartItems.isEmpty) {
          return Center(child: Text('Your cart is empty.'));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: userProfileController.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = userProfileController.cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x66E5E5E5),
                              blurRadius: 10,
                              offset: Offset(10, 10),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              margin: const EdgeInsets.all(8.0),
                              child: Image.network(cartItem['productImages'][0]), // Load the image dynamically
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            cartItem['productName'],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Quantity: ',
                                                  style: TextStyle(
                                                    color: Color(0xFFCACACA),
                                                    fontSize: 12,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '${cartItem['ProductQuantityAddedToCart']} ${cartItem['productUnitType']}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Rs ${cartItem['pricePerUnit']}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        // Spacer(),
                                        
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Icon(Icons.delete)
                                    // child: Radio<int>(
                                    //   value: index,
                                    //   groupValue: _rad,
                                    //   onChanged: (int? value) {
                                    //     setState(() {
                                    //       _rad = value;
                                    //     });
                                    //   },
                                    // ),
                                  ),
                                    Positioned(
                                    bottom: 8,
                                    right: 8,
                                    child:  Row(
                                         
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.remove),
                                              onPressed: () => _decreaseQuantity(index),
                                            ),
                                            Text(
                                              '${cartItem['ProductQuantityAddedToCart']}',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.add),
                                              onPressed: () => _increaseQuantity(index),
                                            ),
                                          ],
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    // child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Expanded(
                    //       child: Container(
                    //         height: 45,
                    //         child: TextField(
                    //           decoration: InputDecoration(
                    //             border: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(15.0),
                    //             ),
                    //             hintText: 'Promo code',
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 10),
                    //     ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: Color.fromRGBO(74, 230, 50, 0.7),
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(15.0),
                    //         ),
                    //         padding: EdgeInsets.symmetric(horizontal: 40, vertical: 4),
                    //       ),
                    //       onPressed: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => HomePage(),
                    //           ),
                    //         );
                    //       },
                    //       child: Center(
                    //         child: Text(
                    //           "Apply",
                    //           style: TextStyle(color: Colors.white),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Sub-total"),
                              Obx(() => Text("Rs ${userProfileController.getCartSubtotal().toStringAsFixed(2)}")),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Voucher"),
                              Text("Rs $vouch"),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          height: 1.0,
                          width: double.infinity,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                              Text(
                                "Rs $tot",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 110, vertical: 8),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FinalOrderScreen(cartItems: userProfileController.getCartItems(),),
                            ),
                          );
                        },
                        child: Center(
                          child: Text(
                            "Place Order",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
