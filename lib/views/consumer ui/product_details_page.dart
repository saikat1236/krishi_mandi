import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/constants/AppConstants.dart';
import 'package:krishi_customer_app/views/consumer%20ui/cartscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/profile.dart';
import 'package:krishi_customer_app/views/consumer%20ui/signupscreen%201.dart';
import 'package:krishi_customer_app/views/farmerui/menubar.dart';

import '../../controller/customer_apis/product_controller.dart';

class ProductDetailsPage extends StatefulWidget {
 final Map<String, dynamic> product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key); // Added key for widget tree


  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
late int qty;
  @override
  void initState() {
    super.initState();
    // Initialize qty with product['minQuantity']
    qty = widget.product['minQuantity'] ?? 1; 
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        // elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
    
        title: const Text('',
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
                  actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
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
            icon: Icon(Icons.person),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: double.infinity,
                  child: Image.asset("assets/krishi-logo.png")),
              // SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product['name'],
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Rs "+product['pricePerUnit'],
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.w800,
                  ),
                  // maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Select Quantity",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),),
              ),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    child: Row(
                      children: [
                       InkWell(
        onTap: () {
           setState(() {
                              int minQuantity = widget.product['minQuantity'] ?? 1;
                              if (qty > minQuantity) {
                                qty--; // Decrease qty
                              }
                            });
        },
        child: Container(
          padding: EdgeInsets.all(8.0), // Add padding around the icon
          child: Icon(
            Icons.remove_circle,
            size: 40.0, // Increase icon size
            color: Colors.red, // Optional: change icon color
          ),
        ),
      ),
      SizedBox(width: 10.0), // Add space between icon and text
      Text(
        qty.toString(),
        style: TextStyle(
          fontSize: 30.0, // Increase text size
          fontWeight: FontWeight.bold, // Optional: make text bold
        ),
      ),
      SizedBox(width: 10.0), // Add space between text and icon
      InkWell(
        onTap: () {
          setState(() {
            qty++; // Increase qty
          });
        },
        child: Container(
          padding: EdgeInsets.all(8.0), // Add padding around the icon
          child: Icon(
            Icons.add_circle,
            size: 40.0, // Increase icon size
            color: Colors.green, // Optional: change icon color
          ),
        ),
      ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(74, 230, 50, 0.961), // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30.0), // Rounded edges
                        side: BorderSide(
                            color: Color.fromRGBO(74, 230, 50, 0.961),
                            width: 2.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 70, vertical: 15), // Button size
                    ),
                    onPressed: () {
                      AppContants.isfarmer = false;
                      // Get.to(widget.initialScreen);
                      // Add navigation or functionality here for consumer
                    },
                    child: Text(
                      "Add to cart",
                      style: TextStyle(color: Colors.black), // Text color
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Description:",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.orange[50]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product['about'],
                    // "Elevate your culinary creations with our premium Kufri Chandramukhi potatoes, organically grown to deliver superior taste and quality.\n\n🌱 Organic Quality: Our Kufri Chandramukhi potatoes are grown using organic farming practices, ensuring they are free from harmful chemicals. Each potato is selected for its quality and freshness.\n\n🍲 Versatile Use: Kufri Chandramukhi potatoes are ideal for boiling, baking, and adding to salads. Their mild, nutty flavor and creamy texture make them the perfect choice for a variety of dishes.\n\n😋 Mild and Creamy: Enjoy the mild, nutty flavor and creamy texture of Kufri Chandramukhi potatoes. They enhance the taste and consistency of your recipes, making them a favorite among potato varieties.\n\n💪 Nutritional Benefits: These potatoes are high in essential nutrients and dietary fiber, making them a healthy addition to your diet. Enjoy the benefits of nutritious, delicious potatoes.\n\n🌾 Sustainably Farmed: We use sustainable farming practices to grow our Kufri Chandramukhi potatoes, ensuring they are environmentally friendly. Enjoy the fresh taste of responsibly farmed produce.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    // maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
