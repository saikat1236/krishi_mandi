import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/controller/customer_apis/product_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<dynamic, dynamic> data;

  const ProductDetailsScreen({super.key, required this.data});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductController productController = Get.put(ProductController());
  bool isFavorite = false;
  bool addedToCart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Product Details',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: widget.data["_id"],
                  child: Image.asset(
                    'assets/photo.png',
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.black,
                      ),
                      onPressed: _addToFavorites,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "In Stock: ${widget.data["totalAvailableQuantity"]}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Min Quantity: ${widget.data["minQuantity"]}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: _addToCart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              addedToCart ? Colors.green : Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        child: Text(
                          addedToCart ? 'Added' : 'Add to Cart',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${widget.data['pricePerUnit']}/${widget.data['unit']}",
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.data["name"],
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    widget.data["category"],
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: 5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      const SizedBox(width: 8),
                      const Text('(10)', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.data["about"],
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),

                  // Discount Matrix
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: const Text(
                        'Discount Matrix',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          _showBottomSheet(context,
                              widget.data["discountMatrix"], "Discount Matrix");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        child: const Text(
                          'View',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  // Bulk Discount Matrix
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: const Text(
                        'Bulk Discount Matrix',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          _showBottomSheet(
                              context,
                              widget.data["bulkOrderDiscounts"],
                              "Bulk Discount Matrix");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        child: const Text(
                          'View',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: _addToCart,
        backgroundColor: addedToCart ? Colors.green : Colors.orange,
        child: SizedBox(
            height: 20,
            width: 20,
            child: Center(
                child:
                    Icon(addedToCart ? Icons.check : Icons.add_shopping_cart))),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  // Build Discount Matrix Table
  Widget _buildDiscountMatrixTable(List<dynamic> matrix) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Min')),
        DataColumn(label: Text('Max')),
        DataColumn(label: Text('Discount')),
      ],
      rows: matrix.map((row) {
        return DataRow(
          cells: [
            DataCell(Text(row['minKg'].toString())),
            DataCell(Text(row['maxKg'].toString())),
            DataCell(Text('${row['discountPercentage']}%')),
          ],
        );
      }).toList(),
    );
  }

  // Method to add product to favorites
  void _addToFavorites() {
    final Map<String, dynamic> productDetails = {
      "productId": widget.data["_id"],
      "productName": widget.data["name"],
      "productInfo": widget.data["about"],
      "productImage": widget.data["images"]
          [0], // Replace with actual image URL if available
      "pricePerUnit": widget.data['pricePerUnit'], // Use actual price from data
      "productUnitType": widget.data['unit'] // Use actual unit type from data
    };

    setState(() {
      isFavorite = !isFavorite; // Toggle favorite state
    });
    productController.addToFavorites(productDetails);
  }

  // Method to add product to cart
  void _addToCart() {
    final Map<String, dynamic> cartItem = {
      "orderType": 1,
      "productId": widget.data["_id"],
      "productName": widget.data["name"],
      "ProductQuantityAddedToCart": 1, // Adjust quantity as needed
      "productInfo": widget.data["about"],
      "productImages":
          widget.data["images"], // Replace with actual images URLs if available
      "pricePerUnit": widget.data['pricePerUnit'], // Use actual price from data
      "productUnitType": widget.data['unit'] // Use actual unit type from data
    };

    productController.addToCart(cartItem).then((success) {
      setState(() {
        addedToCart = success; // Update state based on API response
      });
    });
  }

  // Method to show bottom sheet with discount matrix
  void _showBottomSheet(
      BuildContext context, List<dynamic> matrix, String title) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 16),
              _buildDiscountMatrixTable(matrix),
            ],
          ),
        );
      },
    );
  }
}
