import 'dart:convert';

import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:dropdown_model_list/drop_down/select_drop_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:krishi_customer_app/splashscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/loginsreen.dart';
import 'package:krishi_customer_app/views/farmerui/crop_prof_calc.dart';
import 'package:krishi_customer_app/views/farmerui/farmerorders.dart';
import 'package:krishi_customer_app/views/farmerui/loginsreen.dart';
import 'package:krishi_customer_app/views/farmerui/ratecalc.dart';
import 'package:krishi_customer_app/views/farmerui/sellproducts.dart';
import 'package:krishi_customer_app/views/farmerui/upload.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../../constants/AppConstants.dart';
import '../../controller/farmer_apis/farmer_controller.dart';
import '../../controller/farmer_apis/profile_controller.dart';
import '../consumer ui/homescreen.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmHome extends StatefulWidget {
  const FarmHome();

  @override
  State<FarmHome> createState() => _FarmHomeState();
}

class _FarmHomeState extends State<FarmHome> {
  // final FarmProfileController farmProfileController = Get.put(FarmProfileController());
  final FarmController farmerController = Get.put(FarmController());
  int? _temperature;
  String? cond;
  String? loc;
  int? htemp;
  int? ltemp;
  double? long;
  double? lati;

  @override
  void initState() {
    super.initState();
    _getLocationAndFetchWeather();
    // _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    // Retrieve the token from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // Set the token in AppContants
    // AppContants.apptoken = farmertoken ?? ''; // Ensure token is not null

    // Determine the initial route based on the token
    Widget initialScreen;
    if (token != null && token.isNotEmpty) {
      initialScreen = HomePage(); // Uncomment this if HomeScreen is available
    } else {
      initialScreen = LoginScreen();
    }

    await prefs.remove('farmertoken');

    // Navigate to SplashScreen with the determined initialScreen
    Get.offAll(() => SplashScreen(
          initialScreen: initialScreen, // Navigate to determined screen
          farmerscreen:
              FarmHome(), // Farmer home page or another page based on your need
        ));
  }

  // Replace with your API endpoint
  final String apiUrl = '${AppContants.baseUrl}/common/forecast-weather';

  Future<void> fetchWeatherData(double lat, double lon) async {
    try {
      // Fetch the token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('farmertoken');
      // String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIzMmUxZGViMi01YWQyLTRkNDQtYWJjOS1hZTAyMjU0Zjc4ZmYiLCJ1c2VyVHlwZSI6ImNvbnN1bWVyIiwiaWF0IjoxNzI1ODkzOTcyfQ.YoMldPlLkuWm3OZIHEdvAltMB4dLqVdCNmYiKdY6hxY";

      if (token == null) {
        // Handle the case where the token is missing
        print('Token is missing');
        return;
      }

      // Prepare the request body with lat and lon
      final body = json.encode({"lat": lat, "lan": lon});

      // Prepare the headers with Authorization
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token, // Add 'Bearer' before the token
      };

      // Make the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // Successfully received a response
        print('Weather data: ${response.body}');
        final jsonData = jsonDecode(response.body);
        setState(() {
          var payload = jsonData["payload"];
          var day = payload["days"];
          double? temperature = day[0]["temp"]?.toDouble();
          _temperature = ((temperature! - 32) * 5 / 9)
              .round(); // Celsius conversion with rounding
          cond = day[0]["conditions"];
          htemp = ((day[0]["tempmax"]?.toDouble() ?? 0 - 32) * 5 / 9)
              .round(); // Handle nullable and convert
          ltemp = ((day[0]["tempmin"]?.toDouble() ?? 0 - 32) * 5 / 9)
              .round(); // Handle nullable and convert

          lati = lat;
          long = lon;
          print(_temperature);
          print(cond);
        });
        // You can now handle the response and update the UI or state as needed
      } else {
        print(
            'Failed to fetch weather data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }
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

  Future<String?> _getCityName(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    // print(place.locality);
    return place.locality; // This gives you the city name
  }

  Future<void> _getLocationAndFetchWeather() async {
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          print('Location permissions are denied');
          return;
        }
      }

      // Get current location
      // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      // String? city = await _getCityName(position);
      // print(city);

      // Debug the position values
      print('Position: ${position.latitude}, ${position.longitude}');

      // Get the city name from the coordinates
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];
      loc = place.locality;
      // print(place.locality);

      // Fetch weather data with current location
      fetchWeatherData(position.latitude, position.longitude);
      // fetchWeatherData(23.253753,91.472856);
    } catch (e) {
      print('Error getting location: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final FarmController farmerController = Get.put(FarmController());
    Future<String> _getToken() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('farmertoken') ??
          ''; // Default to empty string if token is not found
    }

    final token = _getToken();
    print(token);
    // Variable to hold the selected value
    return Obx(() {
      //  final user = userController.user; // Assuming `user` is an RxMap
      // final categories = controller.categories; // Assuming `categories` is an RxList

      String userName = farmerController.farmer['userName'] ?? '';
      String mobileNumber = farmerController.farmer['mobileNumber'] ?? '';
      String email = farmerController.farmer['email'] ?? '';
      print("farmer details: $userName $mobileNumber $email");
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            // backgroundColor: Colors.transparent,
            backgroundColor: Color(0xFF2E2E2E),
            // elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,

            title: const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Krishi ',
                    style: TextStyle(
                        color: Colors.white, // Color for 'Krishi'
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                  TextSpan(
                    text: 'Mandi',
                    style: TextStyle(
                        color: Colors.green, // Color for 'Mandi'
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                ],
              ),
            ),
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
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            //           actions: [
            //   IconButton(
            //     icon: Icon(Icons.shopping_cart),
            //     onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => CartListScreen(),
            //       ),
            //     );
            //   },
            //   ),
            //   IconButton(
            //     icon: Icon(Icons.person),
            //     onPressed: () {
            //             Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => ProfileScreenmain(),
            //       ),
            //     );
            //     },
            //   ),
            // ],
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
                                // child: Image.network(
                                //   userController.user['imageProfile'] != null &&
                                //           userController
                                //               .user['imageProfile'].isNotEmpty
                                //       ? userController.user['imageProfile']
                                //       : '',
                                //   fit: BoxFit.cover,
                                //   errorBuilder: (BuildContext context,
                                //       Object exception, StackTrace? stackTrace) {
                                //     return Image.asset(
                                //       'assets/avatar3.jpg',
                                //       fit: BoxFit.cover,
                                //     );
                                //   },
                                // ),
                                child: Image.asset(
                              'assets/avatar3.jpg',
                              fit: BoxFit.cover,
                            )),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            // "Name",
                            '$userName',
                            style: TextStyle(fontSize: 28, color: Colors.white),
                          ),
                          Text(
                            // "Number",
                            '$mobileNumber',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          Text(
                            // "Email",
                            '$email',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          // OutlinedButton(
                          //   onPressed: () {
                          //     // Navigator.push(
                          //     //   context,
                          //     //   MaterialPageRoute(
                          //     //     builder: (context) => ProfileScreenmain(),
                          //     //   ),
                          //     // );
                          //   },
                          //   child: Text(
                          //     "Edit profile",
                          //     style:
                          //         TextStyle(color: Colors.white), // Text color
                          //   ),
                          //   style: OutlinedButton.styleFrom(
                          //     side: BorderSide(
                          //         color: Colors.white), // Border color
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),

                /// Header Menu items
                Column(
                  children: [
                    ListTile(
                      // leading: Icon(Icons.home_outlined),
                      title: Text('Calculator'),
                      onTap: () {
                        /// Close Navigation drawer before
                        // Navigator.pop(context);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()),);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CropProfCalc()), // Replace 'TargetScreen' with your screen
                        );
                      },
                    ),
                    ListTile(
                      // leading: Icon(Icons.favorite_border),
                      title: Text('Mandi Rate Fetcher'),
                      onTap: () {
                        /// Close Navigation drawer before
                        // Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => FavPage()),
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RateCalc()), // Replace 'TargetScreen' with your screen
                        );
                      },
                    ),
                    ListTile(
                      // leading: Icon(Icons.card_giftcard_outlined),
                      title: Text('Free AI Quality Analysis'),
                      onTap: () {
                        /// Close Navigation drawer before
                        // Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => MyOrdersScreen()),
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Uploadpage()), // Replace 'TargetScreen' with your screen
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.sell),
                      title: Text('Sell Products'),
                      onTap: () {
                       Navigator.push(context, 
                       MaterialPageRoute(
                              builder: (context) =>
                                  SellProducts()),
                       );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.favorite_border),
                      title: Text('Orders'),
                      onTap: () {
                        /// Close Navigation drawer before
                        // Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => FavPage()),
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FarmerOrders()), // Replace 'TargetScreen' with your screen
                        );
                      },
                      ),
                    ListTile(
                      leading: Icon(Icons.group),
                      title: Text('About Us'),
                      onTap: () => _launchURL(
                          context, 'https://krishimandi.in/about-us'),
                    ),
                    ListTile(
                      leading: Icon(Icons.privacy_tip),
                      title: Text('Privacy Policy'),
                      onTap: () => _launchURL(
                          context, 'https://krishimandi.in/privacy-policy'),
                    ),
                    ListTile(
                      leading: Icon(Icons.document_scanner),
                      title: Text('Terms and Conditions'),
                      onTap: () =>
                          _launchURL(context, 'https://krishimandi.in/terms'),
                    ),
                    ListTile(
                      leading: Icon(Icons.money_off),
                      title: Text('Refund and Cancellation Policy'),
                      onTap: () => _launchURL(context,
                          'https://krishimandi.in/refund-and-cancellation-policy'),
                    ),
                    ListTile(
                      leading: Icon(Icons.delivery_dining),
                      title: Text('Shipping and Delivery Policy'),
                      onTap: () => _launchURL(context,
                          'https://krishimandi.in/shipping-and-delivery-policy'),
                    ),
                    const Divider(color: Colors.black45),
                    ListTile(
                      title: Text('Logout'),
                      onTap:
                          _checkTokenAndNavigate, // Assuming this method is defined elsewhere
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.delete,
                        color: Colors.transparent,
                      ),
                      title: Text(
                        'Delete User',
                        style: TextStyle(color: Colors.transparent),
                      ),
                      onTap: () => _launchURL(
                          context, 'https://krishimandi.in/delete-user'),
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
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: double.infinity,
                          // height: 300,
                          decoration: BoxDecoration(
                              // color: Colors.grey[200],
                              ),
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/Rectangle 39.png"),
                                fit: BoxFit
                                    .contain, // Adjust the image fit as per your design
                              ),
                            ),
                            child: _temperature == null ||
                                    cond == null ||
                                    loc == null
                                ? Center(
                                    child:
                                        CircularProgressIndicator()) // Show a loading indicator while data is being fetched
                                : Stack(
                                    children: [
                                      Positioned(
                                          top: 30,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start, // To align all texts to the left
                                              children: [
                                                Text(
                                                  "$_temperature°",
                                                  style: TextStyle(
                                                    color: Colors
                                                        .white, // Text color
                                                    fontSize: 60, // Font size
                                                    fontWeight: FontWeight
                                                        .w500, // Font weight
                                                  ),
                                                ),
                                                Text(
                                                  "H: $htemp° L: $ltemp°",
                                                  style: TextStyle(
                                                    color: Colors
                                                        .white, // Text color
                                                    fontSize: 16, // Font size
                                                    fontWeight: FontWeight
                                                        .w400, // Medium weight
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "$loc",
                                                      style: TextStyle(
                                                        color: Colors
                                                            .white, // Text color
                                                        fontSize:
                                                            15, // Font size
                                                        fontWeight: FontWeight
                                                            .w500, // Regular weight
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            30), // Add some space between the two texts
                                                    Text(
                                                      "$cond",
                                                      style: TextStyle(
                                                        color: Colors
                                                            .white, // Text color
                                                        fontSize:
                                                            17, // Font size
                                                        fontWeight: FontWeight
                                                            .w400, // Regular weight
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )),
                                      Positioned(
                                        top: 0, // Places the image at the top
                                        right:
                                            0, // Places the image at the right
                                        child: Image.asset(
                                          'assets/Group 52.png',
                                          width:
                                              220, // Adjust the width as needed
                                          // height: 100, // Adjust the height as needed
                                        ),
                                      ),
                                    ],
                                  ),
                          )),
                    ),
                    // SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Overview",
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to another screen when tapped
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Uploadpage()), // Replace 'TargetScreen' with your screen
                            );
                          },
                          child: Center(
                            child: Container(
                              height: 100.0,
                              width: 400.0,
                              decoration: BoxDecoration(
                                color: Colors.white, // Background color
                                borderRadius: BorderRadius.circular(
                                    15.0), // Rounded corners
                                border: Border.all(
                                  color: Color.fromARGB(
                                      200, 131, 221, 93), // Border color
                                  width: 2.0, // Border width
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius: 1, // Shadow spread
                                    blurRadius: 6, // Shadow blur
                                    offset: Offset(0, 1), // Shadow position
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Free AI Quality Analysis',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'AI Powered Quality Monitoring',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Image.asset(
                                        'assets/streamline_ai-generate-landscape-image-spark-solid.png'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to another screen when tapped
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RateCalc()), // Replace 'TargetScreen' with your screen
                            );
                          },
                          child: Center(
                            child: Container(
                              height: 100.0,
                              width: 400.0,
                              decoration: BoxDecoration(
                                color: Colors.white, // Background color
                                borderRadius: BorderRadius.circular(
                                    15.0), // Rounded corners
                                border: Border.all(
                                  color: Color.fromARGB(
                                      200, 131, 221, 93), // Border color
                                  width: 2.0, // Border width
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius: 1, // Shadow spread
                                    blurRadius: 6, // Shadow blur
                                    offset: Offset(0, 1), // Shadow position
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Mandi Rates Fetcher',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Real time Price Updates',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Image.asset('assets/Vector (1).png'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to another screen when tapped
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CropProfCalc()), // Replace 'TargetScreen' with your screen
                            );
                          },
                          child: Center(
                              child: Container(
                            height: 100.0,
                            width: 400.0,
                            decoration: BoxDecoration(
                              color: Colors.white, // Background color
                              borderRadius: BorderRadius.circular(
                                  15.0), // Rounded corners
                              border: Border.all(
                                color: Color.fromARGB(
                                    200, 131, 221, 93), // Border color
                                width: 2.0, // Border width
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), // Shadow color
                                  spreadRadius: 1, // Shadow spread
                                  blurRadius: 6, // Shadow blur
                                  offset: Offset(0, 1), // Shadow position
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Calculator',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'Yield Estimate',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Image.asset('assets/Vector.png'),
                                ],
                              ),
                            ),
                          )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     "BLOG POSTS",
                    //     style: TextStyle(
                    //       fontSize: 23,
                    //       color: Colors.black,
                    //       fontWeight: FontWeight.w700,
                    //     ),
                    //     maxLines: 2,
                    //     textAlign: TextAlign.left,
                    //   ),
                    // ),
                  ],
                )),
          ));
    });
  }
}
