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
      home: const HomePage(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    _children.add(const HomePage());
    _children.add(const CategoriesScreen());
    _children.add(const MyBagScreen());
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
        items: const [
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

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final UserProfileController userProfileController =
      Get.put(UserProfileController());

  @override
  void initState() {
    super.initState();
    userProfileController.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Favorites',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding to the entire screen
        child: Obx(() {
          if (userProfileController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            var favorites = userProfileController.userProfile.value['payload']
                ['userProfile']['favorites'];
            if (favorites == null || favorites.isEmpty) {
              return const Center(
                child: Text(
                  'No favorites added yet!',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                var favorite = favorites[index];
                return InkWell(
                  onTap: () {},
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10), // Space between cards
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                    ),
                    elevation: 3, // Elevation for card shadow
                    child: Padding(
                      padding:
                          const EdgeInsets.all(8.0), // Padding inside the card
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30, // Increase the size of the avatar
                          backgroundImage:
                              NetworkImage(favorite['productImage']),
                        ),
                        title: Text(
                          favorite['productName'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          favorite['productInfo'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis, // Truncate long text
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: Text(
                          '${favorite['pricePerUnit']} per ${favorite['productUnitType']}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<String> categories = [
    'Fruits',
    'Vegetables',
    'Dairy Products',
    'Bakery',
    'Meat & Seafood',
    'Snacks',
    'Beverages',
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
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                    categories, filterCategories, searchController),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: filteredCategories.length,
          itemBuilder: (context, index) {
            return Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  filteredCategories[index],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Add navigation or functionality on tap if necessary
                },
              ),
            );
          },
        ),
      ),
    );
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
        icon: const Icon(Icons.clear),
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
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
                        backgroundImage: AssetImage('assets/avatar.png'),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Saikat Biswas',
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      ),
                      Text(
                        'saikat1236@gmailcom',
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
                          style: TextStyle(color: Colors.black), // Text color
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
                    Navigator.pop(context);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteScreen()),);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.workspaces),
                  title: Text('Workflow'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.update),
                  title: Text('Updates'),
                  onTap: () {},
                ),
                const Divider(
                  color: Colors.black45,
                ),
                ListTile(
                  leading: Icon(Icons.account_tree_outlined),
                  title: Text('Plugins'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.notifications_outlined),
                  title: Text('Notifications'),
                  onTap: () {},
                ),
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
                      onPressed: () {},
                      child: const Text('View All',
                          style: TextStyle(color: Colors.green)),
                    ),
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

class MyBagScreen extends StatefulWidget {
  const MyBagScreen({super.key});

  @override
  _MyBagScreenState createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen> {
  final UserProfileController _userProfileController =
      Get.put(UserProfileController());

  @override
  void initState() {
    super.initState();
    _userProfileController.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        if (_userProfileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          var cartItems = _userProfileController.userProfile["payload"]
              ["userProfile"]["cartItems"];
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) => CartItemWidget(
                    item: cartItems[index],
                    onQuantityChanged: (newQuantity) {
                      setState(() {
                        cartItems[index]["ProductQuantityAddedToCart"] =
                            newQuantity;
                      });
                    },
                  ),
                ),
              ),
              TotalAmountSection(items: cartItems),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GradientButton(label: 'Check Out'),
              ),
              const SizedBox(height: 20),
            ],
          );
        }
      }),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final dynamic item;
  final Function(int) onQuantityChanged;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/photo.png',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["productName"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Quantity: ${item["ProductQuantityAddedToCart"]} Kg',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (item["ProductQuantityAddedToCart"] > 1) {
                          onQuantityChanged(
                              item["ProductQuantityAddedToCart"] - 1);
                        }
                      },
                    ),
                    Text(item["ProductQuantityAddedToCart"].toString()),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        onQuantityChanged(
                            item["ProductQuantityAddedToCart"] + 1);
                      },
                    ),
                  ],
                ),
                Text(
                  '${item['pricePerUnit']}\$',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
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

  const TotalAmountSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    double total = items.fold(
      0,
      (sum, item) =>
          sum +
          item["ProductQuantityAddedToCart"] *
              double.parse(
                  item['pricePerUnit'].toString().replaceAll('\$', "")),
    );
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.green.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total Amount:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '$total\$',
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ],
      ),
    );
  }
}

class GradientButton extends StatefulWidget {
  final String label;

  const GradientButton({super.key, required this.label});

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
        gradient: const LinearGradient(
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
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Get.to(const CheckoutScreen());
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
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserProfileController userProfileController =
      Get.put(UserProfileController());

  @override
  void initState() {
    super.initState();
    userProfileController.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Profile',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Obx(() {
        if (userProfileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
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
                  Get.to(const ShippingAddressesScreen());
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
                  Get.to(const MyOrdersScreen());
                },
              ),
              _buildProfileOption(
                'Settings',
                'Notifications, Email',
                Icons.settings,
                () {
                  Get.to(const SettingsScreen());
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
      padding: const EdgeInsets.all(16),
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
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userProfile['userName'] ?? 'Username',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userProfile['email'] ?? 'Email',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    userProfile['mobileNumber'] ?? 'Mobile Number',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Implement edit profile functionality
            },
            child: const Text(
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
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
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
