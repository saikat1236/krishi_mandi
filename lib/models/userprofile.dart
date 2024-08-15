import 'package:krishi_customer_app/models/address.dart';
import 'package:krishi_customer_app/models/cartmodel.dart';
import 'package:krishi_customer_app/models/ordermodel.dart';

class UserProfile {
  final String userType;
  final String userName;
  final String email;
  final String mobileNumber;
  final List<Address> addresses;
  final List<CartItem> cartItems;
  final List<Order> orders;
  final String about;
  final String imageProfile;
  final bool verifiedProfile;

  UserProfile({
    required this.userType,
    required this.userName,
    required this.email,
    required this.mobileNumber,
    required this.addresses,
    required this.cartItems,
    required this.orders,
    required this.about,
    required this.imageProfile,
    required this.verifiedProfile,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userType: json['userType'],
      userName: json['userName'],
      email: json['email'],
      mobileNumber: json['mobileNumber'],
      addresses: (json['Address'] as List).map((i) => Address.fromJson(i)).toList(),
      cartItems: (json['cartItems'] as List).map((i) => CartItem.fromJson(i)).toList(),
      orders: (json['orders'] as List).map((i) => Order.fromJson(i)).toList(),
      about: json['about'],
      imageProfile: json['imageProfile'],
      verifiedProfile: json['verifiedProfile'],
    );
  }
}
