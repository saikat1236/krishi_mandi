import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/views/farmerui/calculatorhome.dart';
import 'package:krishi_customer_app/views/farmerui/contactus.dart';
import 'package:krishi_customer_app/views/farmerui/cropcalculator.dart';
//import 'package:krishi_customer_app/views/farmerui/cropgradinghome.dart';
import 'package:krishi_customer_app/views/farmerui/cropgradingscreen.dart';
import 'package:krishi_customer_app/views/farmerui/faq.dart';
import 'package:krishi_customer_app/views/farmerui/loginscreen.dart';
import 'package:krishi_customer_app/views/farmerui/meettheteam.dart';
import 'package:krishi_customer_app/views/farmerui/newshome.dart';
import 'package:krishi_customer_app/views/farmerui/weatherscreen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<Map<String, dynamic>> _menuItems = [
    {
      'title': 'Home',
      'icon': Icons.home,
      'action': () {
        Get.to(const WeatherScreen());
      }
    },
    {
      'title': 'Crop Grading',
      'icon': Icons.grading,
      'action': () {
        //  Get.to(GradingHome());
      }
    },
    {
      'title': 'Farm Helper Chat Bot',
      'icon': Icons.chat,
      'action': () {
        Get.to(const FaqScreen());
      }
    },
    {
      'title': 'Farming Calculations',
      'icon': Icons.calculate,
      'action': () {
        Get.to(const CalculatorHomeScreen());
      }
    },
    {
      'title': 'Tips and News',
      'icon': Icons.tips_and_updates,
      'action': () {
        Get.to(FarmingInsightsScreen());
      }
    },
    {
      'title': 'About Us',
      'icon': Icons.info,
      'action': () {
        Get.to(const MeetTheTeamScreen());
      }
    },
    {
      'title': 'Contact Us',
      'icon': Icons.contact_mail,
      'action': () {
        Get.to(const ContactUsScreen());
      }
    },
    {
      'title': 'Terms & Conditions',
      'icon': Icons.description,
      'action': () {
        Get.to(const WeatherScreen());
      }
    },
    {
      'title': 'Sign In',
      'icon': Icons.login,
      'action': () {
        Get.to(const FarmerLoginScreen());
      }
    },
    {
      'title': 'Weather Forecasting',
      'icon': Icons.wb_sunny,
      'action': () {
        Get.to(const WeatherScreen());
      }
    },
  ];

  late List<Map<String, dynamic>> _filteredMenuItems;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredMenuItems = _menuItems;
  }

  void _filterMenuItems(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredMenuItems = _menuItems;
      } else {
        _filteredMenuItems = _menuItems
            .where((item) =>
                item['title'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for anything',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.green[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: _filterMenuItems,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredMenuItems.isEmpty
                  ? const Center(
                      child: Text(
                        'No items found',
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredMenuItems.length,
                      itemBuilder: (context, index) {
                        final item = _filteredMenuItems[index];
                        return MenuItem(
                          title: item['title'],
                          icon: item['icon'],
                          action: item['action'],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback action;

  const MenuItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(title),
        onTap: action);
  }
}
