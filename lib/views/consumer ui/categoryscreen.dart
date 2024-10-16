import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/controller/customer_apis/product_controller.dart';
import 'package:krishi_customer_app/views/consumer%20ui/cartscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/product_details_page.dart';
import 'package:krishi_customer_app/views/consumer%20ui/profile.dart';

import '../../controller/customer_apis/user_controller.dart';

class CategoryScreen extends StatefulWidget {
    final String category;
  CategoryScreen({super.key, this.category='Fruit'}); // Added key for widget tree
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ProductController controller = Get.put(ProductController());
  late  String selectedCategory; // Default category


  @override
  void initState() {
    super.initState();
    selectedCategory = widget.category; // Initialize selectedCategory
    fetchProductsForCategory(selectedCategory); // Fetch products based on category
  }

    void fetchProductsForCategory(String category) {
    controller.filterProductsByCategory(category);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
                    backgroundColor: Color(0xFF2E2E2E),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Category',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart,color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartListScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person,color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreenmain(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              CategoriesList(onCategorySelected: (category) {
                setState(() {
                  selectedCategory = category;
                });
              }),
              SizedBox(height: 30,),
              ProductListView(selectedCategory: selectedCategory),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesList extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());
  final Function(String) onCategorySelected;

  CategoriesList({required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    controller.getAllCategories();

    return Obx(() {
      // if (controller.isLoading.value) {
      //   return Center(child: CircularProgressIndicator());
      // }
      if (controller.categories.isEmpty) {
        return Center(child: Text('No categories available.'));
      }
      return Container(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            return InkWell(
              onTap: () {
                onCategorySelected(category['value'] ?? "Fruit");
              },
              child: _categoryItem(
                category['value'] ?? "Fruit",
                category['image'] ?? 'assets/fruits.jpg',
              ),
            );
          },
        ),
      );
    });
  }

  Widget _categoryItem(String title, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imageUrl),
          ),
          Container(
            width: 100,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Color(0xFF7ED856),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white),
            ),
            child: Center(child: Text(title)),
          ),
        ],
      ),
    );
  }
}

class ProductListView extends StatefulWidget {
  final String selectedCategory;

  const ProductListView({required this.selectedCategory});

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final ProductController controller = Get.put(ProductController());
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    
    fetchProductsForCategory(widget.selectedCategory);
  }

  @override
  void didUpdateWidget(covariant ProductListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCategory != widget.selectedCategory) {
      fetchProductsForCategory(widget.selectedCategory);
    }
  }

  void fetchProductsForCategory(String category) {
    controller.filterProductsByCategory(category);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      else if (controller.filteredProducts.isEmpty) {
        return Center(child: Text('No ${widget.selectedCategory} available.'));
      }
      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(controller.filteredProducts.length, (index) {
          final product = controller.filteredProducts[index] as Map<String, dynamic>;

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(product: product),
                ),
              );
            },
            child: _offerItemdemo(
              product['name'] ?? "Product",
              product['newPrice'] ?? "\$0.00",
              product['pricePerUnit'] ?? "\$0.00",
              product['images'][0] ?? 'assets/photo.png',
              product['_id'],
              controller.favoriteProducts.contains(product['_id']),
            ),
          );
        }),
      );
    });
  }

  Widget _offerItemdemo(
      String name, String newPrice, String oldPrice, String imageUrl, String Pid,bool isFavorite) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double containerHeight = screenWidth * 0.9;
        double containerWidth = screenWidth * 0.9;

        return Container(
          height: containerHeight,
          width: containerWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.network(
                    imageUrl,
                    width: containerWidth,
                    height: containerHeight * 0.8,
                    fit: BoxFit.cover,
                  ),
                   Positioned(
                  right: 0,
                  child: Container(
                    height: 40,
                    width: 40,
                    // color: Colors.white,
                    child: IconButton(
                      icon: Icon(
                          userController.isFavorite.value
                            ? Icons.favorite
                            : Icons.favorite_rounded,
                        color: userController.isFavorite.value
                            ? Colors.red
                            : Colors.white,
                      ),
                      onPressed: () {
                        userController.toggleFavorite(Pid); // Pass the product ID
                      },
                    ),
                  ),
                ),
                ],
              ),
              Container(
                width: containerWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            newPrice,
                            style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            ' $oldPrice',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
