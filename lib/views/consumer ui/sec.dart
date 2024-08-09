// import 'package:flutter/material.dart';
// import 'package:krishi_customer_app/models/address.dart';
// class SecondPage extends StatelessWidget {
//   final Address address;

//   SecondPage({required this.address});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Second Page'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: TextEditingController(text: address.street),
//               decoration: InputDecoration(labelText: 'Street'),
//             ),
//             TextField(
//               controller: TextEditingController(text: address.city),
//               decoration: InputDecoration(labelText: 'City'),
//             ),
//             TextField(
//               controller: TextEditingController(text: address.state),
//               decoration: InputDecoration(labelText: 'State'),
//             ),
//             TextField(
//               controller: TextEditingController(text: address.zipCode),
//               decoration: InputDecoration(labelText: 'Zip Code'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
