import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Icon(Icons.thunderstorm, size: 100),
            SizedBox(height: 20),
            Text(
              'Delhi',
              style: TextStyle(fontSize: 32),
            ),
            Text(
              '25.05`C',
              style: TextStyle(fontSize: 48),
            ),
            Text(
              'Haze',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Today · Thunderstorm'),
                Text('29° / 25°'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tomorrow · Cloudy'),
                Text('30° / 25°'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Fri · Thunderstorm'),
                Text('25° / 20°'),
              ],
            ),
            SizedBox(height: 20),
            // GestureDetector(
            //   onTap: () {
            //     // Navigate to more details screen
            //   },
            //   child: Text(
            //     'More details >',
            //     style: TextStyle(color: Colors.blue),
            //   ),
            // ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
