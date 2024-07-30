import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/views/farmerui/calculatorhome.dart';
import 'package:krishi_customer_app/views/farmerui/contactus.dart';
import 'package:krishi_customer_app/views/farmerui/cropcalculator.dart';
// import 'package:krishi_customer_app/views/farmerui/cropgradinghome.dart';
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
        Get.to(WeatherScreen());
      }
    },
    {
      'title': 'Crop Grading',
      'icon': Icons.grading,
      'action': () {
        // Get.to(GradingHome());
      }
    },
    {
      'title': 'Farm Helper Chat Bot',
      'icon': Icons.chat,
      'action': () {
        Get.to(FaqScreen());
      }
    },
    {
      'title': 'Farming Calculations',
      'icon': Icons.calculate,
      'action': () {
        Get.to(CalculatorHomeScreen());
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
        Get.to(MeetTheTeamScreen());
      }
    },
    {
      'title': 'Contact Us',
      'icon': Icons.contact_mail,
      'action': () {
        Get.to(ContactUsScreen());
      }
    },
    {
      'title': 'Terms & Conditions',
      'icon': Icons.description,
      'action': () {
        Get.to(WeatherScreen());
      }
    },
    {
      'title': 'Sign In',
      'icon': Icons.login,
      'action': () {
        Get.to(FarmerLoginScreen());
      }
    },
    {
      'title': 'Weather Forecasting',
      'icon': Icons.wb_sunny,
      'action': () {
        Get.to(WeatherScreen());
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/krishi_farm_logo.png', // Make sure to add your logo to the assets folder
            height: 50,
          ),
        ),
        title: const Text(
          'Krishi Mandi',
          style: TextStyle(color: Colors.green),
        ),
        centerTitle: true,
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
                  ? Center(
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
