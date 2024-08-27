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
    bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  final int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final ProductController controller = Get.put(ProductController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(255, 235, 232, 232),
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Products',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
               onPressed: () {
                    /// Close Navigation drawer before
                    Navigator.pop(context);
                  }
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
                  children: [
                    // const Text('Favorite Products',
                    //     style: TextStyle(
                    //         fontSize: 20, fontWeight: FontWeight.bold))
                  ],
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
  final ProductController controller = Get.put(ProductController());
  final UserController userController = Get.put(UserController());

@override
void initState() {
  super.initState();
  fetchProducts();
}

Future<void> fetchProducts() async {
  await controller.getAllProducts(1); // Fetch products on init
}


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.products.isEmpty) {
        return Center(child: Text('No Products available.'));
      }
      return SingleChildScrollView(
        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(controller.products.length, (index) {
            final product = controller.products[index] as Map<String, dynamic>;
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsPage(product: product),
                  ),
                );
              },
              child: _offerItemdemo(
                product['name'] ?? "Product",
                product['newPrice'] ?? "\$0.00",
                product['pricePerUnit'] ?? "\$0.00",
                product['image'] ?? 'assets/photo.png',
                product['_id'],
              ),
            );
          }),
        ),
      );
    });
  }

  Widget _offerItemdemo(
      String name, String newPrice, String oldPrice, String imageUrl, String Pid) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double containerHeight = screenWidth * 0.9;
        double containerWidth = screenWidth * 0.9;

        return Container(
          height: containerHeight,
          width: containerWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.asset(
                    imageUrl,
                    width: containerWidth,
                    height: containerHeight * 0.8,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        icon: Icon(
                          userController.isFavorite.value
                              ? Icons.favorite
                              : Icons.favorite_rounded,
                          color: userController.isFavorite.value
                              ? Colors.red
                              : Colors.white,
                        ),
                        onPressed: () {
                          userController.toggleFavorite(Pid);
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
                            newPrice,
                            style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            ' $oldPrice',
                            style: TextStyle(
                              color: Colors.red,
                            ),
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


