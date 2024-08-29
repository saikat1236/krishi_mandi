import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/controller/customer_apis/product_controller.dart';
import 'package:krishi_customer_app/controller/customer_apis/user_controller.dart';
import 'package:krishi_customer_app/views/consumer%20ui/product_details_page.dart';

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
        centerTitle: true,
        title: const Text('Favorite', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    controller.getFavoriteProducts(); // Fetch favorite products when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.favoriteProducts.isEmpty) {
        return Center(child: Text('No favorite products available.'));
      }
      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(), // Prevents GridView from scrolling independently
        children: List.generate(controller.favoriteProducts.length, (index) {
          final product = controller.favoriteProducts[index];
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
               "Product",
              "\$0.00",
               "\$0.00",
              'assets/photo.png',
              product['_id'],
              product
            ),
          );
        }),
      );
    });
  }

  Widget _offerItemdemo(
      String name, String newPrice, String oldPrice, String imageUrl, String Pid, Map<String, dynamic> product) {
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
