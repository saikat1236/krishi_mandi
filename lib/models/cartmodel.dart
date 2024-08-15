class CartItem {
  final int orderType;
  final String productId;
  final String productName;
  final int quantityAddedToCart;
  final String productInfo;
  final List<String> productImages;
  final double pricePerUnit;
  final String productUnitType;

  CartItem({
    required this.orderType,
    required this.productId,
    required this.productName,
    required this.quantityAddedToCart,
    required this.productInfo,
    required this.productImages,
    required this.pricePerUnit,
    required this.productUnitType,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      orderType: json['orderType'],
      productId: json['productId'],
      productName: json['productName'],
      quantityAddedToCart: json['ProductQuantityAddedToCart'],
      productInfo: json['productInfo'],
      productImages: List<String>.from(json['productImages']),
      pricePerUnit: json['pricePerUnit'].toDouble(),
      productUnitType: json['productUnitType'],
    );
  }
}
