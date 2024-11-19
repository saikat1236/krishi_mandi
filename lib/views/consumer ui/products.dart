import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/controller/customer_apis/product_controller.dart';
import 'package:krishi_customer_app/views/consumer%20ui/address.dart';
import 'package:krishi_customer_app/views/consumer%20ui/cartscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/checkoutscreen1.dart';
import 'package:krishi_customer_app/views/consumer%20ui/item.dart';
import 'package:krishi_customer_app/views/consumer%20ui/orderscren.dart';
import 'package:krishi_customer_app/views/consumer%20ui/product_details_page.dart';
import 'package:krishi_customer_app/views/consumer%20ui/profile.dart';
import 'package:krishi_customer_app/views/consumer%20ui/settingspage.dart';

import '../../controller/customer_apis/profile_controller.dart';
import '../../controller/customer_apis/user_controller.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  final int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color(0xFF2E2E2E),
        title: const Text('Products',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              ProductListViewdemo(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductListViewdemo extends StatefulWidget {
  @override
  _ProductListViewdemoState createState() => _ProductListViewdemoState();
}

class _ProductListViewdemoState extends State<ProductListViewdemo> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  final ProductController controller = Get.put(ProductController());
  final UserController userController = Get.put(UserController());

  // ProductListViewdemo();

  @override
  Widget build(BuildContext context) {
    controller.getAllProducts(1); // Fetch products when the widget is built

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.categories.isEmpty) {
        return Center(child: Text('No Products available.'));
      }
      return SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true, // Important for nested scrollable widgets
          physics:
              NeverScrollableScrollPhysics(), // Prevents GridView from scrolling independently
          // children: List.generate(products.length, (index) {
          //   final product = products[index];
          //   // OnTap(
          //   //   NavigationBar(destinations: ProductDetailsPage())
          //   // ),
          //   return _offerItemdemo(
          //     product['name'] ?? "product",
          //     product['newPrice'] ?? "\$0.00",
          //     product['oldPrice'] ?? "\$0.00",
          //     product['image'] ?? 'assets/photo.png',
          //   );
          // }
          // ),
                childAspectRatio: 0.97, // Adjust this ratio as needed
          children: List.generate(controller.products.length, (index) {
            final product = controller.products[index] as Map<String, dynamic>;
            // print(product);

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsPage(
                      product: product,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: _offerItemdemo(
                    product['name'] ?? "Product",
                    // product['newPrice'] ?? 0,
                    // product['pricePerUnit'] ?? 0,
                    int.tryParse(product['newPrice'].toString()) ?? 0,
                    int.tryParse(product['pricePerUnit'].toString()) ?? 0,
                    product['images'][0],
                    // "https://img.freepik.com/free-vector/fruits-frame-realistic-background_1284-29853.jpg?t=st=1725091437~exp=1725095037~hmac=ea80e3414d604a39789ff08a09bea8f3151a0a283f2449352f1bf0609391ee6d&w=1060",
                    product['productId']),
              ),
            );
          }),
        ),
      );
    });
  }

  Widget _offerItemdemo(
      String name, int newPrice, int oldPrice, String imageUrl, String Pid) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double containerHeight =
            screenWidth * 0.8; // Adjust height ratio as needed
        double containerWidth =
            screenWidth * 0.9; // Adjust width ratio as needed

        return Container(
          height: containerHeight,
          width: containerWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Color(0x66E5E5E5),
                blurRadius: 5,
                offset: Offset(1, 1),
                spreadRadius: 5,
              )
            ],
            border: Border.all(
              color: Colors.grey, // Your border color
              width: 0.5, // Border width
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.network(
                      imageUrl,
                      width: containerWidth,
                      height: containerHeight *
                          0.8, // Adjust image height ratio as needed
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Image.asset(
                          'assets/no_image.jpg', // Path to your asset image
                          width: containerWidth,
                          height: containerHeight *
                              0.8, // Adjust image height ratio as needed
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                        height: 40,
                        width: 40,
                        // color: Colors.white,
                        child: Obx(
                          () => IconButton(
                            icon: Icon(
                              controller.isProductFavorite(Pid)
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_rounded,
                              color: controller.isProductFavorite(Pid)
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              // Create the favItem map
                              Map<String, dynamic> favItem = {
                                "productId": Pid,
                                "productName": name,
                                "productImage": imageUrl,
                                // "pricePerUnit": newPrice,
                                "pricePerUnit": oldPrice,
                                "productUnitType": "kg"
                                // "productInfo":""
                              };
                              controller.toggleFavorite(Pid);
                              setState(() {});
                            },
                          ),
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.red),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              "55% off",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            name.length > 15
                                ? '${name.substring(0, 15)}...'
                                : name, // Trim to 10 characters and add '...'
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    //  Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 8),
                    //       child: Text(
                    //         ' $oldPrice',
                    //         style: TextStyle(
                    //           color: Colors.red,
                    //         ),
                    //       ),
                    //     ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            "M.R.P",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          child: Text(
                            "₹ $newPrice",
                            style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '₹ $oldPrice',
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// class ProductListViewdemo extends StatefulWidget {
//   @override
//   _ProductListViewdemoState createState() => _ProductListViewdemoState();
// }

// class _ProductListViewdemoState extends State<ProductListViewdemo> {
//   final ProductController controller = Get.put(ProductController());
//   final UserController userController = Get.put(UserController());

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }

//   Future<void> fetchProducts() async {
//     await controller.getAllProducts(1); // Fetch products on init
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return Center(child: CircularProgressIndicator());
//       }
//       if (controller.products.isEmpty) {
//         return Center(child: Text('No Products available.'));
//       }
//       return GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.8,
//         ),
//         itemCount: controller.products.length,
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemBuilder: (context, index) {
//           final product = controller.products[index] as Map<String, dynamic>;
//           return InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ProductDetailsPage(product: product),
//                 ),
//               );
//             },
//             child: _offerItemdemo(
//               product['name'] ?? "Product",
//               int.tryParse(product['newPrice'].toString()) ?? 0,
//               int.tryParse(product['pricePerUnit'].toString()) ?? 0,
//               // product['newPrice'] ?? "\$0.00",
//               // product['pricePerUnit'] ?? "\$0.00",
//               product['images'][0] ?? 'assets/photo.png',
//               product['_id'],
//               product,
//               controller.favoriteProducts.contains(product['_id']),
//             ),
//           );
//         },
//       );
//     });
//   }

//   Widget _offerItemdemo(
//       String name,
//       int newPrice,
//       int oldPrice,
//       String imageUrl,
//       String Pid,
//       Map<String, dynamic> product,
//       bool isFavorite) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         double screenWidth = constraints.maxWidth;
//         double containerHeight = screenWidth * 0.9;
//         double containerWidth = screenWidth * 0.9;

//         return Container(
//           height: containerHeight,
//           width: containerWidth,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Stack(
//                 children: <Widget>[
//                   Image.network(
//                     imageUrl,
//                     width: containerWidth,
//                     height: containerHeight * 0.8,
//                     fit: BoxFit.cover,
//                   ),
//                   Positioned(
//                     right: 0,
//                     child: Container(
//                       height: 40,
//                       width: 40,
//                       child: IconButton(
//                         icon: Icon(
//                           isFavorite ? Icons.favorite : Icons.favorite_border,
//                           color: isFavorite ? Colors.red : Colors.white,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             if (isFavorite) {
//                               controller.removeFromFavorites(Pid);
//                             } else {
//                               controller.addToFavorites(product);
//                             }
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 width: containerWidth,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(5.0),
//                       child: Text(name,
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 8),
//                           child: Text(
//                             "$newPrice",
//                             style: TextStyle(
//                               color: Colors.grey,
//                               decoration: TextDecoration.lineThrough,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 8),
//                           child: Text(
//                             "$oldPrice",
//                             style: TextStyle(
//                               color: Colors.red,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
