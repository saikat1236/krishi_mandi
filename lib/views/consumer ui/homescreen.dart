import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/controller/customer_apis/product_controller.dart';
import 'package:krishi_customer_app/global_auth.dart';
import 'package:krishi_customer_app/views/consumer%20ui/address.dart';
import 'package:krishi_customer_app/views/consumer%20ui/cartscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/categoryscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/checkoutscreen1.dart';
import 'package:krishi_customer_app/views/consumer%20ui/favorite.dart';
import 'package:krishi_customer_app/views/consumer%20ui/item.dart';
import 'package:krishi_customer_app/views/consumer%20ui/orderscren.dart';
import 'package:krishi_customer_app/views/consumer%20ui/product_details_page.dart';
import 'package:krishi_customer_app/views/consumer%20ui/profile.dart';
import 'package:krishi_customer_app/views/consumer%20ui/settingspage.dart';

import '../../controller/customer_apis/profile_controller.dart';
import '../../controller/customer_apis/user_controller.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  HomePage({super.key});
  // String token = Get.find<GlobalController>().getAuthToken();
  // final ProductController controller = Get.put(ProductController());
    // final UserController userController = Get.put(UserController());

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final List<String> imgList = [
    'assets/Small banner.png',
    'assets/Small banner.png',
    'assets/Small banner.png',
  ];
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
  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController());
    final UserController userController = Get.put(UserController());
    // // controller.getAllcategories();
    return Obx((){
      
      //  final user = userController.user; // Assuming `user` is an RxMap
    // final categories = controller.categories; // Assuming `categories` is an RxList
    
    String userName = userController.user['userName'] ?? '';
    String mobileNumber = userController.user['mobileNumber'] ?? '';
    String email = userController.user['email'] ?? '';


    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(255, 235, 232, 232),
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset(
          'assets/krishi-logo.png',
          height: 50,
        ),
        // title: const Text('Dashboard',
        // style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Material(
              color: Colors.blueAccent,
              child: InkWell(
                onTap: () {
                  /// Close Navigation drawer before
                  Navigator.pop(context);
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile()),);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top, bottom: 24),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 52,
                        // backgroundImage: NetworkImage(userController.user['imageProfile']),
                          backgroundImage: userController.user['imageProfile'] != null && userController.user['imageProfile'] != ''
      ? NetworkImage(userController.user['imageProfile'])
      : AssetImage('assets/avatar.png') as ImageProvider<Object>,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        '$userName',
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      ),
                       Text(
                        '$mobileNumber',
                        style: TextStyle(fontSize: 14, color: Colors.white),),
                      Text(
                        '$email',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreenmain(),
                            ),
                          );
                        },
                        child: Text(
                          "Edit profile",
                          style: TextStyle(color: Colors.white), // Text color
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.white), // Border color
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            /// Header Menu items
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.home_outlined),
                  title: Text('Home'),
                  onTap: () {
                    /// Close Navigation drawer before
                    Navigator.pop(context);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()),);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.favorite_border),
                  title: Text('Favourites'),
                  onTap: () {
                    /// Close Navigation drawer before
                    // Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.card_giftcard_outlined),
                  title: Text('Orders'),
                  onTap: () {
                    /// Close Navigation drawer before
                    // Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyOrdersScreen()),
                    );
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.update),
                //   title: Text('Updates'),
                //   onTap: () {},
                // ),
                // const Divider(
                //   color: Colors.black45,
                // ),
                // ListTile(
                //   leading: Icon(Icons.account_tree_outlined),
                //   title: Text('Plugins'),
                //   onTap: () {},
                // ),
                // ListTile(
                //   leading: Icon(Icons.notifications_outlined),
                //   title: Text('Notifications'),
                //   onTap: () {},
                // ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              // Search bar
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
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
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryScreen(),
                            ));
                      },
                      child: const Text('View All',
                          style: TextStyle(color: Colors.green)),
                    ),
                  ],
                ),
              ),
              CategoriesList(),
              // Container(
              //   height: 120,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: <Widget>[
              //       _categoryItem('Fruits', 'assets/fruits.jpg'),
              //       _categoryItem('Vegetables', 'assets/vegetables.jpg'),
              //       _categoryItem('Dairy', 'assets/dairy.jpg'),
              //       _categoryItem('Dairy', 'assets/dairy.jpg'),
              //     ],
              //   ),
              // ),
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
                    TextButton(
                      onPressed: () {},
                      child: const Text('View All',
                          style: TextStyle(color: Colors.green)),
                    ),
                  ],
                ),
              ),
              // _sectionTitle('Products', 'View All'),
              ProductListViewdemo(),
              // GridView.builder(
              //   itemCount: 6,
              //   shrinkWrap: true,
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              //   itemBuilder: (_,index)=>ProductListViewdemo()
              //   )
              // _sectionTitle('Fresh', 'View All'),
              // ProductListViewdemo()
            ],
          ),
        ),
      ),
    );
     });
  }

  // Widget _categoryItem(String title, String imageUrl) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Column(
  //       children: <Widget>[
  //         CircleAvatar(
  //           radius: 30,
  //           backgroundImage: AssetImage(imageUrl),
  //         ),
  //         Container(
  //           width: 100,
  //           margin: const EdgeInsets.only(top: 8),
  //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //           decoration: BoxDecoration(
  //             color: Color(0xFF7ED856),
  //             borderRadius: BorderRadius.circular(20),
  //             border: Border.all(color: Colors.white),
  //           ),
  //           child: Center(child: Text(title)),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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

class ProductListView extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getAllProducts(1); // Fetch products when the widget is built

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return SizedBox(
                width: 150,
                child: _offerItem(
                  product['name'] ?? "Product",
                  '\$${product["pricePerUnit"] ?? "0"}',
                  '\$${product["pricePerUnit"] ?? "0"}',
                  product['image'] ??
                      'assets/photo.png', // Assuming your API has an 'image' field
                ),
              );
            },
          ),
        ),
      );
    });
  }

  Widget _offerItem(
      String name, String newPrice, String oldPrice, String imageUrl) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                  height: 80,
                  width: 140,
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                  )),
              Positioned(
                left: 0,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  color: Colors.red,
                  child: const Text('-15%',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(newPrice,
                    style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough)),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(' $oldPrice',
                    style: const TextStyle(
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

class ProductListView2 extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  ProductListView2({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getAllProducts(2); // Fetch products when the widget is built

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return _productItem(
                  product['name'] ?? "product",
                  product["category"] ?? "category",
                  product['image'] ??
                      'assets/photo.png', // Assuming your API has an 'image' field
                  product);
            },
          ),
        ),
      );
    });
  }

  Widget _productItem(String name, String description, String imageUrl,
      Map<dynamic, dynamic> data) {
    return InkWell(
      onTap: () {
        Get.to(ProductDetailsScreen(data: data));
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                SizedBox(
                    height: 140,
                    child: Image.asset(
                      imageUrl,
                      fit: BoxFit.fitWidth,
                    )),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    color: Colors.green,
                    child: const Text('NEW',
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Row(
                    children: <Widget>[
                      RatingBar.builder(
                        itemSize: 20,
                        initialRating: 4.5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(description),
            ),
          ],
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
          children: List.generate(controller.products.length, (index) {
            final product = controller.products[index] as Map<String, dynamic>;

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
              child: _offerItemdemo(
                product['name'] ?? "Product",
                product['newPrice'] ?? "\$0.00",
                product['pricePerUnit'] ?? "\$0.00",
                product['image'] ?? 'assets/photo.png',
                product['productId']
              ),
            );
          }),
        ),
      );
    });
  }

  Widget _offerItemdemo(
      String name, String newPrice, String oldPrice, String imageUrl,String Pid) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(height: 100, child: Image.asset(imageUrl)),
             Positioned(
                right: 0,
                child: Container(
                  // padding: EdgeInsets.all(5),
                  height: 40,
                  width: 40,
                  color: Colors.white,
                  child: IconButton(
                     icon: Icon(
          userController.isFavorite.value ? Icons.favorite : Icons.favorite_border,
          color: userController.isFavorite.value ? Colors.red : Colors.grey,
        ),
                    onPressed: () {
          userController.toggleFavorite(Pid); // Pass the product ID
        },
                ),
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

class CategoriesList extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    controller.getAllCategories();

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
         // Check if the products list is empty
      if (controller.categories.isEmpty) {
        return Center(child: Text('No categories available.'));
      }
      return Container(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final product = controller.categories[index];
            return 
            // SizedBox(
            //   width: 150,
            //   child: _categoryItem(
            //     product['value'] ?? "Fruits", // Assuming 'value' key is correct
            //     product['image'] ?? 'assets/fruits.jpg' // Assuming API has an 'image' field
            //   ),
            // );
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(
                        // product: product,
                        ),
                  ),
                );
              },
           child: _categoryItem(
                product['value'] ?? "Fruits", // Assuming 'value' key is correct
                product['image'] ?? 'assets/fruits.jpg' // Assuming API has an 'image' field
              ),
            );
          },
        ),
      );
    });
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
              color: Color(0xFF7ED856),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white),
            ),
            child: Center(child: Text(title)),
          ),
        ],
      ),
    );
  }
}
