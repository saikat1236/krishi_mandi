import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/views/farmerui/cropcalculator.dart';

class CalculatorHomeScreen extends StatelessWidget {
  const CalculatorHomeScreen({super.key});

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFBBF9BD), Color(0xFFA0D997)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
                children: const [
                  CalculatorCard(
                    title: 'Crop Yield Calculator',
                    description:
                        'Calculate the expected yield for your crops based on various factors',
                    route: '/cropYield',
                  ),
                  CalculatorCard(
                    title: 'Fertilizer Calculator',
                    description:
                        'Determine the optimal amount of fertilizer required for your crops.',
                    route: '/fertilizer',
                  ),
                  CalculatorCard(
                    title: 'Land Area Calculator',
                    description:
                        'Calculate the area of your land in acres, hectares, or square feet',
                    route: '/landArea',
                  ),
                  CalculatorCard(
                    title: 'Irrigation Calculator',
                    description:
                        'Estimate the water requirements and irrigation schedule for your fields',
                    route: '/irrigation',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalculatorCard extends StatelessWidget {
  final String title;
  final String description;
  final String route;

  const CalculatorCard({
    super.key,
    required this.title,
    required this.description,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the corresponding calculator page
        Get.toNamed(route);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                    fontSize: 14, overflow: TextOverflow.ellipsis),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the corresponding calculator page
                    Get.to(const MainScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Use Calculator',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
