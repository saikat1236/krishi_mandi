import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishi_customer_app/views/farmerui/cropdetailsscreen.dart';
import 'package:krishi_customer_app/controller/farmer_apis/apicontroller.dart';

class CropGradingScreen extends StatefulWidget {
  const CropGradingScreen({super.key});

  @override
  _CropGradingScreenState createState() => _CropGradingScreenState();
}

class _CropGradingScreenState extends State<CropGradingScreen> {
  final ImagePicker _picker = ImagePicker();
  final ApiController apiController = Get.put(ApiController()); // Add this line
  List<XFile?> _images = [];

  Future<void> _pickImages() async {
    final List<XFile> pickedImages = await _picker.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      setState(() {
        _images = pickedImages.take(5).toList();
      });
    }
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
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: _pickImages,
              icon: const Icon(Icons.add, color: Colors.black),
              label: const Text(
                'New Crop',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Upload five images using the 'New Crop' button, then click 'Next' to trigger image analysis process and view results.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.grey[300],
                    child: _images[index] != null
                        ? Image.file(File(_images[index]!.path),
                            fit: BoxFit.cover)
                        : const Icon(Icons.add, size: 50),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: () async {
                if (_images.isNotEmpty) {
                  await apiController.predictByUploadingImage(
                      _images[0]!.path); // Call API method
                }

                Get.to(const CropDetailsScreen());
              },
              child: const Text('Next',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
