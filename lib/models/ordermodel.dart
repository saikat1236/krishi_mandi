import 'package:krishi_customer_app/models/address.dart';
import 'package:krishi_customer_app/models/orderstatusmodel.dart';

class Order {
  final Address address;
  final String dateAndTimeOrderPlaced;
  final String orderId;
  final OrderStatus currentOrderStatus;
  final int orderType;
  final String paymentStatus;
  final String paymentType;
  final double totalAmount;
  // final List<StatusHistory> statusHistory;
  // final List<ProductsOrdered> productsOrdered;

  Order({
    required this.address,
    required this.dateAndTimeOrderPlaced,
    required this.orderId,
    required this.currentOrderStatus,
    required this.orderType,
    required this.paymentStatus,
    required this.paymentType,
    required this.totalAmount,
    // required this.statusHistory,
    // required this.productsOrdered,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      address: Address.fromJson(json['address']),
      dateAndTimeOrderPlaced: json['dateAndTimeOrderPlaced'],
      orderId: json['orderId'],
      currentOrderStatus: OrderStatus.fromJson(json['currentOrderStatus']),
      orderType: json['orderType'],
      paymentStatus: json['paymentStatus'],
      paymentType: json['paymentType'],
      totalAmount: json['totalAmount'].toDouble(),
      // statusHistory: (json['statusHistory'] as List).map((i) => StatusHistory.fromJson(i)).toList(),
      // productsOrdered: (json['productsOrdered'] as List).map((i) => ProductsOrdered.fromJson(i)).toList(),
    );
  }
}
