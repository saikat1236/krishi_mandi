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


class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CategoryScreen> {
  final int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final List<String> imgList = [
    'assets/Small banner.png',
    'assets/Small banner.png',
    'assets/Small banner.png',
  ];
  final ProductController controller = Get.put(ProductController());
  final List<Map<String, String>> products = [
    {
      'name': 'Product 1',
      'category': 'Category 1',
      'image': 'assets/fruits.jpg',
      'newPrice': '\$20.00',
      'oldPrice': '\$25.00',
    },
    {
      'name': 'Product 2',
      'category': 'Category 2',
      'image': 'assets/fruits.jpg',
      'newPrice': '\$15.00',
      'oldPrice': '\$20.00',
    },
    {
      'name': 'Product 3',
      'category': 'Category 3',
      'image': 'assets/fruits.jpg',
      'newPrice': '\$10.00',
      'oldPrice': '\$15.00',
    },
    {
      'name': 'Product 4',
      'category': 'Category 3',
      'image': 'assets/fruits.jpg',
      'newPrice': '\$10.00',
      'oldPrice': '\$15.00',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(255, 235, 232, 232),
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        // title: const Text('Home Page',
        // style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.shopping_cart),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => CartListScreen(),
        //         ),
        //       );
        //     },
        //   ),
        //   IconButton(
        //     icon: Icon(Icons.person),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => ProfileScreenmain(),
        //         ),
        //       );
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              // Search bar
       
              // Other content
              // Expanded(
              //   child: Center(
              //     // child: Text('Content goes here'),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Category',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: const Text('View All',
                    //       style: TextStyle(color: Colors.green)),
                    // ),
                  ],
                ),
              ),
              Container(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _categoryItem('Fruits', 'assets/fruits.jpg'),
                    _categoryItem('Vegetables', 'assets/vegetables.jpg'),
                    _categoryItem('Dairy', 'assets/dairy.jpg'),
                    _categoryItem('Dairy', 'assets/dairy.jpg'),
                  ],
                ),
              ),
              // CarouselSlider(
              //   options: CarouselOptions(
              //     autoPlay: true,
              //     aspectRatio: 2.0,
              //     enlargeCenterPage: true,
              //   ),
              //   items: imgList
              //       .map((item) => Container(
              //             child: Center(
              //               child:
              //                   Image.asset(item, fit: BoxFit.cover, width: 1000),
              //             ),
              //           ))
              //       .toList(),
              // ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Products',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: const Text('View All',
                    //       style: TextStyle(color: Colors.green)),
                    // ),
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

  Widget _categoryItem(String title, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imageUrl),
          ),
          Container(
            width: 100,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black),
            ),
            child: Center(child: Text(title)),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, String viewAllText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextButton(
            onPressed: () {},
            child:
                Text(viewAllText, style: const TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }
}



class ProductListViewdemo extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());
  final List<Map<String, String>> products = [
    {
      'name': 'Product 1',
      'category': 'Category 1',
      'image': 'assets/fruits.jpg',
      'newPrice': '\$20.00',
      'oldPrice': '\$25.00',
    },
    {
      'name': 'Product 2',
      'category': 'Category 2',
      'image': 'assets/fruits.jpg',
      'newPrice': '\$15.00',
      'oldPrice': '\$20.00',
    },
    {
      'name': 'Product 3',
      'category': 'Category 3',
      'image': 'assets/fruits.jpg',
      'newPrice': '\$10.00',
      'oldPrice': '\$15.00',
    },
    {
      'name': 'Product 4',
      'category': 'Category 3',
      'image': 'assets/fruits.jpg',
      'newPrice': '\$10.00',
      'oldPrice': '\$15.00',
    },
    {
      'name': 'Product 5',
      'category': 'Category 3',
      'image': 'assets/fruits.jpg',
      'newPrice': '\$10.00',
      'oldPrice': '\$15.00',
    },
    {
      'name': 'Product 6',
      'category': 'Category 3',
      'image': 'assets/fruits.jpg',
      'newPrice': '\$10.00',
      'oldPrice': '\$15.00',
    },
  ];

  // ProductListViewdemo();

  @override
  Widget build(BuildContext context) {
    controller.getAllProducts(1); // Fetch products when the widget is built

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
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
          children: List.generate(products.length, (index) {
            final product = products[index];

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsPage(
                        // product: product,
                        ),
                  ),
                );
              },
              child: _offerItemdemo(
                product['name'] ?? "Product",
                product['newPrice'] ?? "\$0.00",
                product['oldPrice'] ?? "\$0.00",
                product['image'] ?? 'assets/photo.png',
              ),
            );
          }),
        ),
      );
    });
  }

  Widget _offerItemdemo(
      String name, String newPrice, String oldPrice, String imageUrl) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(height: 100, child: Image.asset(imageUrl)),
              Positioned(
                left: 0,
                child: Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.red,
                  child: Text('-15%',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(newPrice,
                    style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(' $oldPrice',
                    style: TextStyle(
                      color: Colors.red,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class demo extends StatelessWidget {
  // final ProductController controller = Get.put(ProductController());
  final List<Map<String, String>> products = [
    {
      'name': 'Product 1',
      'category': 'Category 1',
      'image': 'assets/fruits.jpg',
      'newPrice': '\$20.00',
      'oldPrice': '\$25.00',
    },
    {
      'name': 'Product 2',
      'category': 'Category 2',
      'image': 'assets/fruits.jpg',
      'newPrice': '\$15.00',
      'oldPrice': '\$20.00',
    },
    {
      'name': 'Product 3',
      'category': 'Category 3',
      'image': 'assets/fruits.jpg',
      'newPrice': '\$10.00',
      'oldPrice': '\$15.00',
    },
    {
      'name': 'Product 4',
      'category': 'Category 3',
      'image': 'assets/fruits.jpg',
      'newPrice': '\$10.00',
      'oldPrice': '\$15.00',
    },
  ];

  // ProductListViewdemo();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
    );
  }
}
