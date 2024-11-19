import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/constants/AppConstants.dart';
import 'package:krishi_customer_app/global_auth.dart';
// import 'package:krishi_customer_app/saikat-home.dart';
import 'package:krishi_customer_app/splashscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/categoryscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/favorite.dart';
import 'package:krishi_customer_app/views/consumer%20ui/final_order.dart';
import 'package:krishi_customer_app/views/consumer%20ui/orderdetailspage%201.dart';
import 'package:krishi_customer_app/views/consumer%20ui/orderscren.dart';
import 'package:krishi_customer_app/views/consumer%20ui/otpscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/product_details_page.dart';
import 'package:krishi_customer_app/views/consumer%20ui/products.dart';
import 'package:krishi_customer_app/views/consumer%20ui/profile.dart';
import 'package:krishi_customer_app/views/consumer%20ui/signupscreen%201.dart';
// import 'package:krishi_customer_app/views/consumer%20ui/signupscreen.dart';
import 'package:krishi_customer_app/views/farmerui/entrypage.dart';
import 'package:krishi_customer_app/views/farmerui/menubar.dart';
import 'package:krishi_customer_app/views/farmerui/qualitycheck.dart';
import 'package:krishi_customer_app/views/farmerui/upload.dart';
// import 'package:krishi_customer_app/views/signupscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:krishi_customer_app/views/consumer%20ui/homescreen.dart'; // Uncomment this if HomeScreen is available
import 'package:krishi_customer_app/views/consumer%20ui/loginsreen.dart';
import 'package:flutter/foundation.dart';
import 'controller/customer_apis/profile_controller.dart';
import 'views/consumer ui/order_success.dart';
import 'views/farmerui/crop_prof_calc.dart';
import 'views/farmerui/f-homepage.dart';
import 'views/farmerui/loginsreen.dart';
import 'package:dotenv/dotenv.dart';

// import 'views/consumer ui/signupscreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Retrieve the token from SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  AppContants.apptoken = token.toString();

  final farmertoken = prefs.getString('farmertoken');
  AppContants.apptoken = farmertoken.toString();
  // Determine the initial route based on the token


  Widget initialScreen;

  // if (token != null && token.isNotEmpty) {
  //       await prefs.remove('farmertoken');
  //   initialScreen = HomePage(); // Uncomment this if HomeScreen is available
  // } else {
  //   initialScreen = LoginScreen();
  // }
  // Widget farmerscreen;
  // // if (farmertoken != null && farmertoken.isNotEmpty) {
  // //   farmerinitialScreen = FarmHome(); // Uncomment this if HomeScreen is available
  // // } else {
  // //   farmerinitialScreen = FarmHome();
  // // }
  //   if (farmertoken != null && farmertoken.isNotEmpty) {
  //         await prefs.remove('token');
  //   farmerscreen = FarmHome(); // Uncomment this if HomeScreen is available
  // } else {
  //     print("farmertoken: $farmertoken");
  //   farmerscreen = LoginScreenfarm();
  // }

  if (token != null && token.isNotEmpty) {
    // If user token is available, open HomePage and remove farmertoken
    await prefs.remove('farmertoken');
    initialScreen = HomePage();
  } else if (farmertoken != null && farmertoken.isNotEmpty) {
    // If farmer token is available, open FarmHome and remove user token
    await prefs.remove('token');
    initialScreen = FarmHome();
  } else {
    // If no token is available, show login screen (or splash screen if needed)
    initialScreen = SplashScreen(
      initialScreen: LoginScreen(),
      farmerscreen: LoginScreenfarm(),
    );
  }
  // Get.put(GlobalController());
    Get.put(UserProfileController()); 

  // runApp(MyApp(initialScreen: initialScreen,farmerscreen: farmerscreen,));


    runApp(MyApp(initialScreen: initialScreen));
}

class MyApp extends StatelessWidget {
  // final Widget initialScreen;
  // final Widget farmerscreen;

  // const MyApp({Key? key, required this.initialScreen, required this.farmerscreen}) : super(key: key);

   final Widget initialScreen;

  const MyApp({Key? key, required this.initialScreen}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
   scaffoldBackgroundColor: Colors.white,
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      // home: MyOrdersScreen()
      // home: OrderDetailsScreen()
      // home: SaikatHome()
      // home: HomePage()
      // home: OtpScreen2()
      // home: ProductsPage()
      // home: FinalOrderScreen()
      // home: MainScreen()
      // home: ProfileScreenmain()
      // home: ProductDetailsPage(),
      // home: Uploadpage()
      // home: Uploadpage2()
      // home: FavPage()
      // home: CategoryScreen()
      // home: SignUpScreen()
      // home: FarmHome()
      // home: CropProfCalc(),
      // home: SplashScreen(initialScreen: initialScreen, farmerscreen: farmerscreen,), // Use the initialScreen determined in main()
      // home: OtpScreen2(mobileNumber: "7085959167")
      home: initialScreen,
    );
  }
}