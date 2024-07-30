import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CropDetailsScreen extends StatefulWidget {
  const CropDetailsScreen({super.key});

  @override
  _CropDetailsScreenState createState() => _CropDetailsScreenState();
}

class _CropDetailsScreenState extends State<CropDetailsScreen> {
  String? _cropType;
  String? _fertilizerUsed;
  String? _farmLandLocation;
  String? _duration;

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
            DropdownButtonFormField<String>(
              value: _cropType,
              hint: const Text('Select option'),
              decoration: const InputDecoration(
                labelText: 'Crop Type',
                border: OutlineInputBorder(),
              ),
              items: ['Wheat', 'Rice', 'Corn']
                  .map((crop) => DropdownMenuItem(
                        value: crop,
                        child: Text(crop),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _cropType = value;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _fertilizerUsed,
              hint: const Text('Select option'),
              decoration: const InputDecoration(
                labelText: 'Fertilizer Used',
                border: OutlineInputBorder(),
              ),
              items: ['Nitrogen', 'Phosphate', 'Potassium']
                  .map((fertilizer) => DropdownMenuItem(
                        value: fertilizer,
                        child: Text(fertilizer),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _fertilizerUsed = value;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _farmLandLocation,
              hint: const Text('Select option'),
              decoration: const InputDecoration(
                labelText: 'Farm Land Location',
                border: OutlineInputBorder(),
              ),
              items: ['North', 'South', 'East', 'West']
                  .map((location) => DropdownMenuItem(
                        value: location,
                        child: Text(location),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _farmLandLocation = value;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _duration,
              hint: const Text('Select option'),
              decoration: const InputDecoration(
                labelText: 'Duration',
                border: OutlineInputBorder(),
              ),
              items: ['3 Months', '6 Months', '1 Year']
                  .map((duration) => DropdownMenuItem(
                        value: duration,
                        child: Text(duration),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _duration = value;
                });
              },
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {
                  // Handle analyze button press
                },
                child: const Text('Analyze Your Crop',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
