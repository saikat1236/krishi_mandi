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


  // final UserProfileController userProfileController = Get.find<UserProfileController>();
  // final orders = userProfileController.getOrders();


  late UserProfileController userProfileController; // Declare as late
  late List<Map<String, dynamic>> orders; // Declare orders




  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
        // Initialize the controller and fetch orders
    userProfileController = Get.find<UserProfileController>();
    orders = List<Map<String, dynamic>>.from(userProfileController.getOrders()); // Fetch orders
    print(orders); // Add this line
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
    appBar:AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Orders',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500)),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList(),
          const Center(child: Text('Processing Orders')),
          const Center(child: Text('Cancelled Orders')),
        ],
      ),
    );
  }

Widget _buildOrderList() {
  return ListView.builder(
    padding: const EdgeInsets.all(16.0),
    itemCount: orders.length, // Number of orders
    itemBuilder: (context, index) {
      return _buildOrderCard(orders[index]); // Pass the order to the card
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
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                '${DateTime.parse(order['dateAndTimeOrderPlaced']).toLocal()}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text('Tracking number: ${order['currentOrderStatus']['status']}',
              style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quantity: ${order['productsOrdered'].length}',
                style: const TextStyle(color: Colors.grey),
              ),
              Text(
                'Total Amount: \$${order['totalAmount']}',
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
