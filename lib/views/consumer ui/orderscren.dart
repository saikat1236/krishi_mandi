import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/views/consumer%20ui/orderdetailspage.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
      itemCount: 3, // Number of orders
      itemBuilder: (context, index) {
        return _buildOrderCard();
      },
    );
  }

  Widget _buildOrderCard() {
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order No: 1947034',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('05-12-2019', style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8.0),
            const Text('Tracking number: IW3475453455',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quantity: 3', style: TextStyle(color: Colors.grey)),
                Text('Total Amount: 112\$',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16.0),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  Get.to(const OrderDetailsScreen());
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
