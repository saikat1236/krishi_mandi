import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/controller/customer_apis/product_controller.dart';
import 'package:krishi_customer_app/controller/customer_apis/user_controller.dart';
import 'package:krishi_customer_app/views/consumer%20ui/product_details_page.dart';

import '../../controller/customer_apis/profile_controller.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  _FavPageState createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
              backgroundColor: Color(0xFF2E2E2E),
        centerTitle: true,
        title: const Text('Favourite', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
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
                  children: [
                    // Additional UI elements can be added here
                  ],
                ),
              ),
              FavoriteProductListView(),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteProductListView extends StatefulWidget {
  @override
  _FavoriteProductListViewState createState() => _FavoriteProductListViewState();
}

class _FavoriteProductListViewState extends State<FavoriteProductListView> {
  final ProductController controller = Get.put(ProductController());
  final UserProfileController userController = Get.put(UserProfileController());

  @override
  void initState() {
    super.initState();
    controller.getFavoriteProducts(); // Fetch favorite products when the widget is initialized
    userController.getFavorites();
    controller.getFavoriteProductsOnly(1);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      // if (controller.favoriteProducts.isEmpty) {
      //   return Center(child: Text('No favorite products available.'));
      // }
      if(controller.favoriteProducts.isEmpty){
     return Center(child: Text('No favorite products available.'));
      }
      return SingleChildScrollView(
        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // Prevents GridView from scrolling independently
          children: List.generate(controller.favoriteProducts.length, (index) {
            final product = controller.favoriteProducts[index];
                print("fav---products $product");
                   // Convert double to string for display
             // Convert values to String
            String productId = product['productId'].toString();
            String productName = product['name'].toString();
            String productImage = product['images'][0].toString();
              // Handle price conversion for both int and double types
            double pricePerUnit;
            if (product['pricePerUnit'] is int) {
              pricePerUnit = (product['pricePerUnit'] as int).toDouble();
            } else if (product['pricePerUnit'] is double) {
              pricePerUnit = product['pricePerUnit'];
            } else {
              pricePerUnit = double.tryParse(product['pricePerUnit'].toString()) ?? 0.0;
            }
            return InkWell(
              onTap: () {
        
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ProductDetailsPage(product: product),
                //   ),
                // );
              },
              child: _offerItemdemo(
                productName,
                pricePerUnit,
                productImage,
                productId,
                // product['productName'],
                // pricePerUnit,
                // // double.parse(product['pricePerUnit']),
                // // "₹ ${product['pricePerUnit']}",
                // product['productImage'],
                // product['productId']
                // product
              ),
            );
          }),
        ),
      );
    });
  }

  Widget _offerItemdemo(
      String name, double newPrice, String imageUrl, String Pid) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double containerHeight = screenWidth * 0.8;
        double containerWidth = screenWidth * 0.9;

        return Container(
          height: containerHeight,
          width: containerWidth,
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
                      child: IconButton(
                        icon: Icon(
                          controller.isProductFavorite(Pid)
                              ? Icons.favorite
                              : Icons.favorite_rounded,
                           color: controller.isProductFavorite(Pid)
                              ? Colors.red
                              : Colors.red,
                        ),
                        onPressed: () {
                              controller.toggleFavorite(Pid);
                          // controller.isProductFavorite(Pid);
                          // Map<String, dynamic> favItem = {
                          //   'productId': product['productId'],
                          //   'productName': product['name'],
                          //   'productInfo': product['about'],
                          //   'productImage': product['images'][0],
                          //   'pricePerUnit': product['pricePerUnit'],
                          //   'productUnitType': product['unit'],
                          // };

                          // controller.addToFavorites(favItem);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: containerWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "$newPrice",
                            style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 8),
                        //   child: Text(
                        //     ' $oldPrice',
                        //     style: TextStyle(
                        //       color: Colors.red,
                        //     ),
                        //   ),
                        // ),
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
