// class Address {
//   final String name;
//   final String mobile;
//   final String email;
//   final String addressLine1;
//   final String addressLine2;
//   final String city;
//   final int pin;

//   Address({
//     required this.name,
//     required this.mobile,
//     required this.email,
//     required this.addressLine1,
//     required this.addressLine2,
//     required this.city,
//     required this.pin,
//   });
// }

class Address {
  // final String addressId;
  final String? name;
  final String? mobile;
  final String? email;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final int? pin;

  Address({
    // required this.addressId,
    this.name,
    this.mobile,
    this.email,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.pin,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      // addressId: json['addressId'],
      name: json['name'],
      mobile: json['mobile'],
      email: json['email'],
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      city: json['city'],
      pin: json['pin'],
    );
  }
}
