// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/controller/customer_apis/product_controller.dart';
import 'package:krishi_customer_app/views/address.dart';
import 'package:krishi_customer_app/views/checkoutscreen1.dart';
import 'package:krishi_customer_app/views/item.dart';
import 'package:krishi_customer_app/views/orderscren.dart';
import 'package:krishi_customer_app/views/settingspage.dart';

import '../controller/customer_apis/profile_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    _children.add(HomePage2());
    _children.add(CategoriesScreen());
    _children.add(MyBagScreen());
    _children.add(FavoritesScreen());
    _children.add(ProfileScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Bag',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class FavoritesScreen extends StatelessWidget {
  final UserProfileController userProfileController =
      Get.put(UserProfileController());

  FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Adding Shipping Address',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
      ),
      body: Obx(() {
        if (userProfileController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          var favorites = userProfileController.userProfile.value['payload']
              ['userProfile']['favorites'];
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              var favorite = favorites[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(favorite['productImage']),
                ),
                title: Text(favorite['productName']),
                subtitle: Text(favorite['productInfo']),
                trailing: Text(
                    '${favorite['pricePerUnit']} per ${favorite['productUnitType']}'),
              );
            },
          );
        }
      }),
    );
  }
}

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<String> categories = [
    'Fruits',
    'Vegetables',
    'Diary Products',
  ];

  TextEditingController searchController = TextEditingController();
  List<String> filteredCategories = [];

  @override
  void initState() {
    super.initState();
    filteredCategories = categories; // Initially display all categories
    searchController.addListener(() {
      filterCategories();
    });
  }

  void filterCategories() {
    List<String> results = [];
    if (searchController.text.isEmpty) {
      results = categories;
    } else {
      results = categories
          .where((item) =>
              item.toLowerCase().contains(searchController.text.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredCategories = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar:AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Adding Shipping Address',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: filteredCategories.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(4.0),
            child: ListTile(
              title: Text(filteredCategories[index],
                  style: TextStyle(fontSize: 16)),
              onTap:
                  () {}, // Add navigation or functionality on tap if necessary
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<String> categories;
  final Function filterCategories;
  final TextEditingController searchController;

  CustomSearchDelegate(
      this.categories, this.filterCategories, this.searchController);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          filterCategories();
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(categories[index]),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = categories
        .where((c) => c.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}

class HomePage2 extends StatefulWidget {
  HomePage2({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  final int _currentIndex = 0;

  final List<String> imgList = [
    'assets/Small banner.png',
    'assets/Small banner.png',
    'assets/Small banner.png',
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Adding Shipping Address',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: imgList
                .map((item) => Container(
                      child: Center(
                        child:
                            Image.asset(item, fit: BoxFit.cover, width: 1000),
                      ),
                    ))
                .toList(),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Category',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  child: Text('View All',
                      style: TextStyle(color: Colors.green)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _categoryItem('Fruits', 'assets/fruits.jpg'),
                _categoryItem('Vegetables', 'assets/vegetables.jpg'),
                _categoryItem('Dairy Products', 'assets/dairy.jpg'),
              ],
            ),
          ),
          _sectionTitle('Offers', 'View All'),
          ProductListViewdemo(),
          _sectionTitle('Fresh', 'View All'),
          ProductListView2()
        ],
      ),
    );
  }

  Widget _categoryItem(String title, String imageUrl) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imageUrl),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black),
            ),
            child: Text(title),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, String viewAllText) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextButton(
            onPressed: () {},
            child:
                Text(viewAllText, style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }
}

class MyBagScreen extends StatefulWidget {
  MyBagScreen({super.key});

  @override
  _MyBagScreenState createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen> {
  final UserProfileController _userProfileController =
      Get.put(UserProfileController());

  List<CartItem> items = [
    CartItem(name: 'Potato', quantity: 1, price: 51),
    CartItem(name: 'Potato', quantity: 1, price: 51),
    CartItem(name: 'Potato', quantity: 1, price: 51),
  ];

  @override
  void initState() {
    super.initState();
    _userProfileController
        .getUserProfile(); // Fetch user profile on screen initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar:AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Adding Shipping Address',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
      ),
      body: Obx(() {
        if (_userProfileController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          // Render screen content once user profile data is fetched
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _userProfileController
                      .userProfile["payload"]["userProfile"]["cartItems"]
                      .length,
                  itemBuilder: (context, index) => CartItemWidget(
                    item: _userProfileController.userProfile["payload"]
                        ["userProfile"]["cartItems"][index],
                    onQuantityChanged: (newQuantity) {
                      setState(() {
                        items[index].quantity = int.parse(_userProfileController
                                .userProfile["payload"]["userProfile"]
                            ["cartItems"][index]["ProductQuantityAddedToCart"]);
                      });
                    },
                  ),
                ),
              ),
              TotalAmountSection(
                  items: _userProfileController.userProfile["payload"]
                      ["userProfile"]["cartItems"]),
              GradientButton(label: 'Check Out'),
              SizedBox(height: 10)
            ],
          );
        }
      }),
    );
  }
}

class CartItem {
  String name;
  int quantity;
  double price;

  CartItem({required this.name, required this.quantity, required this.price});
}

class CartItemWidget extends StatelessWidget {
  final dynamic item;
  final Function(int) onQuantityChanged;

  CartItemWidget(
      {super.key, required this.item, required this.onQuantityChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/photo.png',
                width: 100), // Replace with your asset image
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item["productName"],
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Quantity: ${item["ProductQuantityAddedToCart"]} Kg'),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (item.quantity > 1) {
                          onQuantityChanged(item.quantity - 1);
                        }
                      },
                    ),
                    Text(item["ProductQuantityAddedToCart"].toString()),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        onQuantityChanged(item.quantity + 1);
                      },
                    ),
                  ],
                ),
                Text('${item['pricePerUnit']}\$'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TotalAmountSection extends StatelessWidget {
  final List<dynamic> items;

  TotalAmountSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    double total = items.fold(
        0,
        (sum, item) =>
            sum +
            item["ProductQuantityAddedToCart"] *
                double.parse(
                    item['pricePerUnit'].toString().replaceAll('\$', "")));
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total amount:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('$total\$',
              style: TextStyle(fontSize: 18, color: Colors.green)),
        ],
      ),
    );
  }
}

class GradientButton extends StatefulWidget {
  final String label;

  GradientButton({super.key, required this.label});

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff52DB22), Color(0xff2C7512)], // White to dark green
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Get.to(CheckoutScreen());
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final UserProfileController userProfileController =
      Get.put(UserProfileController());

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Adding Shipping Address',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
      ),
      body: Obx(() {
        if (userProfileController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          var userProfile =
              userProfileController.userProfile.value['payload']['userProfile'];
          return ListView(
            children: [
              _buildProfileHeader(userProfile),
              _buildProfileOption(
                'My Orders',
                'Already have ${userProfile['orders'].length} orders',
                Icons.shopping_cart,
                () {},
              ),
              _buildProfileOption(
                'Shipping addresses',
                '${userProfile['Address'].length} addresses',
                Icons.location_on,
                () {
                  Get.to(ShippingAddressesScreen());
                },
              ),
              _buildProfileOption(
                'Payment methods',
                'Visa **${userProfile['previousEmails'].length}',
                Icons.payment,
                () {},
              ),
              _buildProfileOption(
                'My Orders',
                'You have ${userProfile['orders'].length} orders',
                Icons.list,
                () {
                  Get.to(MyOrdersScreen());
                },
              ),
              _buildProfileOption(
                'Settings',
                'Notifications, Email',
                Icons.settings,
                () {
                  Get.to(SettingsScreen());
                },
              ),
            ],
          );
        }
      }),
    );
  }

  Widget _buildProfileHeader(Map<String, dynamic> userProfile) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              userProfile['imageProfile'] ?? 'https://via.placeholder.com/150',
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userProfile['userName'] ?? 'Username',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userProfile['email'] ?? 'Email',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    userProfile['mobileNumber'] ?? 'Mobile Number',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Implement edit profile functionality
            },
            child: Text(
              'Edit',
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProfileOption(
      String title, String subtitle, IconData icon, VoidCallback action) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.chevron_right),
      onTap: action,
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
        return Center(child: CircularProgressIndicator());
      }

      return SizedBox(
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 2,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return _offerItem(
              product['name'] ?? "Product",
              '\$${product["pricePerUnit"] ?? "0"}',
              '\$${product["pricePerUnit"] ?? "0"}',
              product['image'] ??
                  'assets/photo.png', // Assuming your API has an 'image' field
            );
          },
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
              SizedBox(height: 80, child: Image.asset(imageUrl)),
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
            child:
                Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
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

class ProductListView2 extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());


  ProductListView2({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getAllProducts(2); // Fetch products when the widget is built

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      return SizedBox(
        height: 240,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 2,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return _productItem(
              product['name'] ?? "Product",
              '\$${product["pricePerUnit"] ?? "0"}',
              '\$${product["pricePerUnit"] ?? "0"}',
              product['image'] ??
                  'assets/photo.png', // Assuming your API has an 'image' field
            );
          },
        ),
      );
    }
    );
  }

  Widget _productItem(String name, String description, String imageUrl,Map<dynamic, dynamic> data) {
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
                    padding: EdgeInsets.all(5),
                    color: Colors.green,
                    child: Text('NEW',
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
                            Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(name,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(description),
            ),
          ],
        ),
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
      'image': 'assets/photo1.png',
      'newPrice': '\$20.00',
      'oldPrice': '\$25.00',
    },
    {
      'name': 'Product 2',
      'category': 'Category 2',
      'image': 'assets/photo2.png',
      'newPrice': '\$15.00',
      'oldPrice': '\$20.00',
    },
    {
      'name': 'Product 3',
      'category': 'Category 3',
      'image': 'assets/photo3.png',
      'newPrice': '\$10.00',
      'oldPrice': '\$15.00',
    },
  ];

  ProductListViewdemo();

  @override
  Widget build(BuildContext context) {
    controller.getAllProducts(1); // Fetch products when the widget is built

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      return SizedBox(
        height: 250,
       child: products.isNotEmpty
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _offerItemdemo(
                    product['name'] ?? "product",
                    product['newPrice'] ?? "\$0.00",
                    product['oldPrice'] ?? "\$0.00",
                    product['image'] ?? 'assets/photo.png', // Assuming your API has an 'image' field
                  );
                },
              )
            : Center(
                child: Text('No products available'),
              ),

      );
    });
  }

  Widget _offerItemdemo(
      String name, String newPrice, String oldPrice, String imageUrl) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(height: 80, child: Image.asset(imageUrl)),
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
            child:
                Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
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