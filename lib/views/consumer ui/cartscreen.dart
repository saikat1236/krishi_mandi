// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/views/consumer%20ui/homescreen.dart';

class CartListScreen extends StatefulWidget {
  @override
  _CartListScreenState createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  int? _rad; // The currently selected value

  int _quantity = 3; // Initial quantity

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // width: 428,
        // height: 926,
        clipBehavior: Clip.antiAlias,
        // decoration: BoxDecoration(color: Color(0xFFFAF8F8)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  //  SizedBox(height: 100),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        child: FlutterLogo(),
                      ),
                      const SizedBox(width: 125),
                      Text(
                        'My Carts',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      const SizedBox(width: 125),
                      Text(
                        'Delete',
                        style: TextStyle(
                          color: Color(0xFFD72E2E),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 384,
                        height: 100,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 384,
                                height: 100,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x66E5E5E5),
                                      blurRadius: 10,
                                      offset: Offset(10, 10),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 16,
                              top: 10,
                              child: Container(
                                width: 80,
                                height: 80,
                                child: Image.asset("assets/dairy.jpg"),
                              ),
                            ),
                            // Image.asset("assets/fruits.jpg"),
                            Positioned(
                              left: 117,
                              top: 12,
                              child: Text(
                                'Kurfi Chandramukhi Potatoes\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 117,
                              top: 50,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Quantity: ',
                                      style: TextStyle(
                                        color: Color(0xFFCACACA),
                                        fontSize: 10,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '1 Kg',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 117,
                              top: 73,
                              child: Text(
                                'Rs 49.00',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 346,
                              top: 12,
                              child: Container(
                                width: 20,
                                height: 20,
                                child: Radio<int>(
                                  value: 1,
                                  groupValue: _rad,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _rad = value;
                                    });
                                  },
                                ),
                              ),
                            ),

                            Positioned(
                              left: 250,
                              top: 60,
                              
                              child: Container(
                                height: 40,
                                width: 110,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: _decreaseQuantity,
                                      ),
                                    // Container(
                                    //   width: 21,
                                    //   height: 21,
                                    //   child: IconButton(
                                    //     icon: Icon(Icons.remove),
                                    //     onPressed: _decreaseQuantity,
                                    //   ),
                                    // ),
                                    Text(
                                      '$_quantity',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: _increaseQuantity,
                                      ),
                                    // Container(
                                    //   width: 21,
                                    //   height: 21,
                                    //   // padding: const EdgeInsets.all(6),
                                    //   child: IconButton(
                                    //     icon: Icon(Icons.add),
                                    //     onPressed: _increaseQuantity,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 384,
                        height: 100,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 384,
                                height: 100,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x66E5E5E5),
                                      blurRadius: 10,
                                      offset: Offset(10, 10),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 16,
                              top: 10,
                              child: Container(
                                width: 80,
                                height: 80,
                                child: Image.asset("assets/dairy.jpg"),
                              ),
                            ),
                            Positioned(
                              left: 117,
                              top: 12,
                              child: Text(
                                'Kurfi Bahar Potatoes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 117,
                              top: 50,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Quantity: ',
                                      style: TextStyle(
                                        color: Color(0xFFCACACA),
                                        fontSize: 10,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '1 Kg',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 117,
                              top: 73,
                              child: Text(
                                'Rs 39.00',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 346,
                              top: 12,
                              child: Container(
                                width: 20,
                                height: 20,
                                child: Radio<int>(
                                  value: 1,
                                  groupValue: _rad,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _rad = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              left: 250,
                              top: 60,
                              
                              child: Container(
                                height: 40,
                                width: 110,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: _decreaseQuantity,
                                      ),
                                    // Container(
                                    //   width: 21,
                                    //   height: 21,
                                    //   child: IconButton(
                                    //     icon: Icon(Icons.remove),
                                    //     onPressed: _decreaseQuantity,
                                    //   ),
                                    // ),
                                    Text(
                                      '$_quantity',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: _increaseQuantity,
                                      ),
                                    // Container(
                                    //   width: 21,
                                    //   height: 21,
                                    //   // padding: const EdgeInsets.all(6),
                                    //   child: IconButton(
                                    //     icon: Icon(Icons.add),
                                    //     onPressed: _increaseQuantity,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 384,
                        height: 100,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 384,
                                height: 100,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x66E5E5E5),
                                      blurRadius: 10,
                                      offset: Offset(10, 10),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 16,
                              top: 10,
                              child: Container(
                                width: 80,
                                height: 80,
                                child: Image.asset("assets/dairy.jpg"),
                              ),
                            ),
                            Positioned(
                              left: 117,
                              top: 12,
                              child: Text(
                                'Tomatoes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 117,
                              top: 50,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Quantity: ',
                                      style: TextStyle(
                                        color: Color(0xFFCACACA),
                                        fontSize: 10,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '1 Kg',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 117,
                              top: 73,
                              child: Text(
                                'Rs 49.00',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 346,
                              top: 12,
                              child: Container(
                                width: 20,
                                height: 20,
                                child: Radio<int>(
                                  value: 1,
                                  groupValue: _rad,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _rad = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              left: 250,
                              top: 60,
                              
                              child: Container(
                                height: 40,
                                width: 110,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: _decreaseQuantity,
                                      ),
                                    // Container(
                                    //   width: 21,
                                    //   height: 21,
                                    //   child: IconButton(
                                    //     icon: Icon(Icons.remove),
                                    //     onPressed: _decreaseQuantity,
                                    //   ),
                                    // ),
                                    Text(
                                      '$_quantity',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: _increaseQuantity,
                                      ),
                                    // Container(
                                    //   width: 21,
                                    //   height: 21,
                                    //   // padding: const EdgeInsets.all(6),
                                    //   child: IconButton(
                                    //     icon: Icon(Icons.add),
                                    //     onPressed: _increaseQuantity,
                                    //   ),
                                    // ),
                                  ],
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 386,
                  height: 45,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Positioned(
                          left: 1,
                          top: 0,
                          child: Container(
                            width: 244,
                            height: 45,
                            child: TextField(
                    // controller: _phoneController,
                    decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0), // Set border radius here
              ),
              hintText: 'Promo code',
            ),
                    keyboardType: TextInputType.phone,
                  ),
                           
                          ),
                        ),
                        // ignore: prefer_const_constructors
                  //       TextField(
                  //   // controller: _phoneController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     hintText: 'Promo code',
                  //   ),
                  //   keyboardType: TextInputType.phone,
                  // ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(74, 230, 50, 0.7),
                            // Background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              // side: BorderSide(color: Colors.black, width: 2.0),
                              // Rounded edges
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 4), // Button size
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                          child: Center(
                            child: Text(
                              "Apply",
                              style:
                                  TextStyle(color: Colors.white), // Text color
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Sub-total"), Text("Rs 245")],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Voucher"), Text("Rs 245")],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Delivery Fee"), Text("Rs 245")],
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
                            Text("Total",
                            style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),), 
                            Text("Rs 245",
                            style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),)],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 58, vertical: 14),
                  decoration: ShapeDecoration(
                    color: Color(0xFF2D2E2D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        'Checkout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
