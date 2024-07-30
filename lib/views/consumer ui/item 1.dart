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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.black),
            onPressed: () {
              // Add share functionality here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/photo.png',
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
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
                      onPressed: () {
                        _addToFavorites();
                      },
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
                              "In Stock: ${widget.data["totalAvailableQuantity"]}"),
                          Text("Min Quantity: ${widget.data["minQuantity"]}"),
                        ],
                      ),
                      Spacer(),
                      OutlinedButton(
                        onPressed: () {
                          _addToCart();
                        },
                        child: Text(addedToCart ? 'Added✔️' : 'Add to Cart'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: addedToCart ? Colors.green : Colors.black,
                          side: BorderSide(color: addedToCart ? Colors.green : Colors.grey),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "${widget.data['pricePerUnit']}/${widget.data['unit']}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.data["name"],
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.data["category"],
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: 5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      SizedBox(width: 8),
                      Text('(10)', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.data["about"],
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Divider(),

                  // Discount Matrix Table
                  Text(
                    'Discount Matrix',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  _buildDiscountMatrixTable(widget.data["discountMatrix"]),

                  SizedBox(height: 16),
                  Divider(),

                  // Bulk Discount Matrix Table
                  Text(
                    'Bulk Discount Matrix',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  _buildDiscountMatrixTable(
                      widget.data["bulkOrderDiscounts"]), // Reusing the method for simplicity

                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build Discount Matrix Table
  Widget _buildDiscountMatrixTable(List<dynamic> matrix) {
    return DataTable(
      columns: [
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
      "productImage": widget.data["images"][0], // Replace with actual image URL if available
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
      "productImages": widget.data["images"], // Replace with actual images URLs if available
      "pricePerUnit": widget.data['pricePerUnit'], // Use actual price from data
      "productUnitType": widget.data['unit'] // Use actual unit type from data
    };

    productController.addToCart(cartItem).then((success) {
      setState(() {
        addedToCart = success; // Update state based on API response
      });
    });
  }
}
