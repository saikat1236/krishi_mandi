import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/controller/customer_apis/product_controller.dart';
import 'package:krishi_customer_app/global_auth.dart';
import 'package:krishi_customer_app/splashscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/address.dart';
import 'package:krishi_customer_app/views/consumer%20ui/cartscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/categoryscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/checkoutscreen1.dart';
import 'package:krishi_customer_app/views/consumer%20ui/favorite.dart';
import 'package:krishi_customer_app/views/consumer%20ui/item.dart';
import 'package:krishi_customer_app/views/consumer%20ui/loginsreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/orderscren.dart';
import 'package:krishi_customer_app/views/consumer%20ui/product_details_page.dart';
import 'package:krishi_customer_app/views/consumer%20ui/products.dart';
import 'package:krishi_customer_app/views/consumer%20ui/profile.dart';
import 'package:krishi_customer_app/views/consumer%20ui/settingspage.dart';
import 'package:krishi_customer_app/views/farmerui/upload.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/AppConstants.dart';
import '../../controller/customer_apis/profile_controller.dart';
import '../../controller/customer_apis/user_controller.dart';
import '../farmerui/f-homepage.dart';
import '../farmerui/loginsreen.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final ProductController controller = Get.put(ProductController());
  final UserProfileController userProfileController =
      Get.find<UserProfileController>();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    // _checkTokenAndNavigate;
    print("here");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchAllProducts();
      // _showLoadingDialog();
          // userController.getFavorites();
    controller.getFavoriteProductsOnly(1);
    print(controller.favoriteProducts);
    controller.loadFavoriteProducts();

      // Fetch user profile and close the dialog after a 2-second delay
      // userProfileController.getUserProfile().then((_) {
      //   Future.delayed(Duration(seconds: 2), () {
      //     if (mounted) {
      //       Get.back(); // Close the loading dialog after a 2-second delay
      //     }
      //   });
      // });
    });
  }

  Future<void> _checkTokenAndNavigate() async {
    // Retrieve the token from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final farmertoken = prefs.getString('farmertoken');

    // Set the token in AppContants
    // AppContants.apptoken = farmertoken ?? ''; // Ensure token is not null

    Widget farmerscreen;
    // if (farmertoken != null && farmertoken.isNotEmpty) {
    //   farmerinitialScreen = FarmHome(); // Uncomment this if HomeScreen is available
    // } else {
    //   farmerinitialScreen = FarmHome();
    // }
    if (farmertoken != null && farmertoken.isNotEmpty) {
      farmerscreen = FarmHome(); // Uncomment this if HomeScreen is available
    } else {
      print("farmertoken: $farmertoken");
      farmerscreen = LoginScreenfarm();
    }

    await prefs.remove('token');

    // Navigate to SplashScreen with the determined initialScreen
    Get.offAll(() => SplashScreen(
          initialScreen:
              LoginScreen(), // Redirect to login screen or any other screen as needed
          farmerscreen:
              farmerscreen, // This can be adjusted based on your requirements
        ));
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _hasFocus = false;
    });
    controller
        .clearSearchResults(); // Assuming this method clears the search results
  }

  void fetchAllProducts() {
    controller.getAllProducts(1); // Method to fetch all products
  }

  ImageProvider _getNetworkImage(String url) {
    try {
      return NetworkImage(url);
    } catch (e) {
      // Return a fallback image if an error occurs
      return const AssetImage('assets/avatar2.svg');
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // Schedule the loading dialog to show after the first frame is rendered
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _showLoadingDialog();
  //     userProfileController.getUserProfile().then((_) {
  //       Get.back(); // Close the loading dialog once the profile is loaded
  //     });
  //   });
  // }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(20), // Add padding around content
          content: SizedBox(
            width: 200, // Set a fixed width for the dialog
            height: 100, // Set a fixed height for the dialog
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center content vertically
              children: [
                Text(
                  "Home page is Loading...",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20), // Space between spinner and text
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
    void _launchURL(BuildContext context, String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Show a SnackBar or some indication of failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController());
    final UserController userController = Get.put(UserController());
    Future<String> _getToken() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('token') ??
          ''; // Default to empty string if token is not found
    }

    final token = _getToken();
    print(token);
    // // controller.getAllcategories();
    return Obx(() {
      //  final user = userController.user; // Assuming `user` is an RxMap
      // final categories = controller.categories; // Assuming `categories` is an RxList

      String userName = userController.user['userName'] ?? '';
      String mobileNumber = userController.user['mobileNumber'] ?? '';
      String email = userController.user['email'] ?? '';

      bool cart = userProfileController.cartItems.isNotEmpty;

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF2E2E2E),
          // elevation : 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Image.asset(
            'assets/krishi_logo.png',
            height: 50,
          ),
          // title: const Text('Dashboard',
          // style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),

          actions: [
            Stack(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartListScreen(),
                      ),
                    );
                  },
                ),
                // Conditionally show the red dot if the cart is not empty
                if (cart) // Replace `cartItems.isNotEmpty` with your cart-check logic
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 10,
                        minHeight: 10,
                      ),
                    ),
                  ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
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
                // color: Color.fromARGB(255, 9, 223, 120),
                color: Color(0xFF2E2E2E),
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
                        Container(
                          width: 104, // 2 * radius of 52
                          height: 104, // 2 * radius of 52
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: Image.network(
                              userController.user['imageProfile'] != null &&
                                      userController
                                          .user['imageProfile'].isNotEmpty
                                  ? userController.user['imageProfile']
                                  : '',
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Image.asset(
                                  'assets/avatar3.jpg',
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
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
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
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
                            side:
                                BorderSide(color: Colors.white), // Border color
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
                        MaterialPageRoute(
                            builder: (context) => MyOrdersScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.contact_page),
                    title: Text('Contact Us'),
                    onTap: () async {
                      const url =
                          'https://krishimandi.in/'; // Replace with the actual URL
                      Uri uri = Uri.parse(url);

                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                 ListTile(
          leading: Icon(Icons.contact_page),
          title: Text('Contact Us'),
          onTap: () => _launchURL(context, 'https://krishimandi.in/'),
        ),
        ListTile(
          leading: Icon(Icons.group),
          title: Text('About Us'),
          onTap: () => _launchURL(context, 'https://krishimandi.in/about-us'),
        ),
        ListTile(
          leading: Icon(Icons.privacy_tip),
          title: Text('Privacy Policy'),
          onTap: () => _launchURL(context, 'https://krishimandi.in/privacy-policy'),
        ),
        ListTile(
          leading: Icon(Icons.document_scanner),
          title: Text('Terms and Conditions'),
          onTap: () => _launchURL(context, 'https://krishimandi.in/terms'),
        ),
        ListTile(
          leading: Icon(Icons.money_off),
          title: Text('Refund and Cancellation Policy'),
          onTap: () => _launchURL(context, 'https://krishimandi.in/refund-and-cancellation-policy'),
        ),
        ListTile(
          leading: Icon(Icons.delivery_dining),
          title: Text('Shipping and Delivery Policy'),
          onTap: () => _launchURL(context, 'https://krishimandi.in/shipping-and-delivery-policy'),
        ),
        const Divider(color: Colors.black45),
        ListTile(
          title: Text('Logout'),
          onTap: _checkTokenAndNavigate, // Assuming this method is defined elsewhere
        ),
        ListTile(
          leading: Icon(Icons.delete),
          title: Text('Delete User',style: TextStyle(color: Colors.red),),
          onTap: () => _launchURL(context, 'https://krishimandi.in/delete-user'),
        ),
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
          // backgroundColor:Colors.white;
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                // Search bar
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      setState(() {
                        _hasFocus = hasFocus;
                      });
                    },
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: _clearSearch,
                              )
                            : Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                if (_hasFocus &&
                    _searchController.text.isNotEmpty &&
                    controller.searchResults.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.searchResults.length,
                    itemBuilder: (context, index) {
                      var product = controller.searchResults[index];
                      return ListTile(
                        title: Text(product['name']),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailsPage(product: product),
                            ),
                          );
                        },
                      );
                    },
                  ),
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
                            ),
                          ).then((_) {
                            // Refresh data or handle navigation return if needed
                            fetchAllProducts();
                          });
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductsPage(),
                              ));
                        },
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
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: _offerItemdemo(
                    product['name'] ?? "Product",
                    product['newPrice'] ?? "\0.00",
                    product['pricePerUnit'] ?? 0.00,
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

  Widget _offerItemdemo(String name, String newPrice, String oldPrice,
      String imageUrl, String Pid) {
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
                         child: Obx(() =>IconButton(
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
                            "pricePerUnit": double.parse(oldPrice),
                            "productUnitType": "kg"
                            // "productInfo":""
                          };
                          controller.toggleFavorite(Pid);
                          setState(() {}); 
                        },
                      ),
                         )
                    ),
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
                          child: Text("$name",
                              style: TextStyle(fontWeight: FontWeight.bold)),
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
                    builder: (context) =>
                        CategoryScreen(category: product['value']
                            // product: product,
                            ),
                  ),
                );
              },
              child: _categoryItem(
                  product['value'] ??
                      "Fruits", // Assuming 'value' key is correct
                  product['image'] ??
                      'assets/fruits.jpg' // Assuming API has an 'image' field
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
