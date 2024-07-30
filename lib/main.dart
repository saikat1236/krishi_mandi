import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/constants/AppConstants.dart';
import 'package:krishi_customer_app/saikat-home.dart';
import 'package:krishi_customer_app/splashscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/profile.dart';
import 'package:krishi_customer_app/views/farmerui/entrypage.dart';
import 'package:krishi_customer_app/views/farmerui/menubar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:krishi_customer_app/views/consumer%20ui/homescreen.dart'; // Uncomment this if HomeScreen is available
import 'package:krishi_customer_app/views/consumer%20ui/loginsreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/signupscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Retrieve the token from SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  AppContants.apptoken = token.toString();
  
  final farmertoken = prefs.getString('farmertoken');
  AppContants.farmertoken = farmertoken.toString();
  // Determine the initial route based on the token
  Widget initialScreen;
  if (token != null && token.isNotEmpty) {
    initialScreen = MainScreen(); // Uncomment this if HomeScreen is available
  } else {
    initialScreen = LoginScreen();
  }
  Widget farmerinitialScreen;
  if (farmertoken != null && farmertoken.isNotEmpty) {
    farmerinitialScreen = MenuScreen(); // Uncomment this if HomeScreen is available
  } else {
    farmerinitialScreen = LoginScreen();
  }

  runApp(MyApp(initialScreen: initialScreen,farmerscreen: farmerinitialScreen,));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  final Widget farmerscreen;

  const MyApp({Key? key, required this.initialScreen, required this.farmerscreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      // home: SaikatHome()
      // home: HomePage()
      // home: MainScreen()
      home: ProfileScreenmain()
      // home: SplashScreen(initialScreen: initialScreen, farmerscreen: farmerscreen,), // Use the initialScreen determined in main()
    );
  }
}