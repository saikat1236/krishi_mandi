import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/views/consumer%20ui/orderdetailspage.dart';

import '../../controller/customer_apis/profile_controller.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
    
  late UserProfileController userProfileController;

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    userProfileController = Get.find<UserProfileController>();

    // Fetch the latest orders
    // userProfileController.getUserProfile(); // Ensure this fetches from the API
        // Fetch the latest orders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userProfileController.getUserProfile();
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                     backgroundColor: Color(0xFF2E2E2E),
        elevation: 0,
                centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Orders',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
      ),
      body: Obx(() {
        if (userProfileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return TabBarView(
            controller: _tabController,
            children: [
              _buildOrderList(),
              // const Center(child: Text('Processing Orders')),
              // const Center(child: Text('Cancelled Orders')),
            ],
          );
        }
      }),
    );
  }

  Widget _buildOrderList() {
      //       if (userProfileController.orders.isEmpty) {
      //   return Center(child: CircularProgressIndicator());
      // }
      // if (controller.favoriteProducts.isEmpty) {
      //   return Center(child: Text('No favorite products available.'));
      // }
      if(userProfileController.orders.isEmpty){
     return Center(child: Text('No Orders available.'));
      }
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: userProfileController.orders.length,
      itemBuilder: (context, index) {
        return _buildOrderCard(userProfileController.orders[index]);
      },
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(color: Colors.green, width: 2),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order No: ${order['orderId']}',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8.0),
            // Text('Tracking number: Success',
            //     style: const TextStyle(color: Colors.grey)
            //     ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quantity: ${order['productsOrdered'].length}',
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  'Total Amount: ${order['totalAmount']} ₹',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  Get.to(OrderDetailsScreen(order: order)); // Pass order details
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.green),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                child: const Text(
                  'Details',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
