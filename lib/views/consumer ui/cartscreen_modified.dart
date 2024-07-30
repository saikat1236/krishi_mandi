// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CartListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         // width: 428,
//         // height: 926,
//         clipBehavior: Clip.antiAlias,
//         // decoration: BoxDecoration(color: Color(0xFFFAF8F8)),
//         child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Positioned(
//               left: 21,
//               top: 25,
//               child: Container(
//                 width: 391,
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
  
//                     Container(
//                       height: 14.24,
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Container(
//                             width: 21,
//                             height: 14.24,
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
                              
//                               ],
//                             ),
//                           ),
//                           const SizedBox(width: 11),
//                           Container(
//                             width: 14,
//                             height: 14,
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
                              
//                               ],
//                             ),
//                           ),
//                           const SizedBox(width: 11),
//                           Container(
//                             width: 24,
//                             height: 12,
//                             child: FlutterLogo(),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 21,
//               top: 75,
//               child: Container(
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 35,
//                       height: 35,
//                       child: FlutterLogo(),
//                     ),
//                     const SizedBox(width: 125),
//                     Text(
//                       'My Carts',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w700,
//                         height: 0,
//                       ),
//                     ),
//                     const SizedBox(width: 125),
//                     Text(
//                       'Delete',
//                       style: TextStyle(
//                         color: Color(0xFFD72E2E),
//                         fontSize: 12,
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w400,
//                         height: 0,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 22,
//               top: 147,
//               child: Container(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 384,
//                       height: 100,
//                       child: SingleChildScrollView(
//         child: Column(
//                         children: [
//                           Positioned(
//                             left: 0,
//                             top: 0,
//                             child: Container(
//                               width: 384,
//                               height: 100,
//                               decoration: ShapeDecoration(
//                                 color: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 shadows: [
//                                   BoxShadow(
//                                     color: Color(0x66E5E5E5),
//                                     blurRadius: 10,
//                                     offset: Offset(10, 10),
//                                     spreadRadius: 0,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 16,
//                             top: 10,
//                             child: Container(
//                               width: 80,
//                               height: 80,
//                               decoration: ShapeDecoration(
//                                 image: DecorationImage(
//                                   image: NetworkImage("https://via.placeholder.com/80x80"),
//                                   fit: BoxFit.cover,
//                                 ),
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 117,
//                             top: 12,
//                             child: Text(
//                               'Kurfi Chandramukhi Potatoes\n',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w500,
//                                 height: 0,
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 117,
//                             top: 50,
//                             child: Text.rich(
//                               TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: 'Quantity: ',
//                                     style: TextStyle(
//                                       color: Color(0xFFCACACA),
//                                       fontSize: 10,
//                                       fontFamily: 'Inter',
//                                       fontWeight: FontWeight.w400,
//                                       height: 0,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: '1 Kg',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 10,
//                                       fontFamily: 'Inter',
//                                       fontWeight: FontWeight.w400,
//                                       height: 0,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 117,
//                             top: 73,
//                             child: Text(
//                               'Rs 49.00',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w700,
//                                 height: 0,
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 346,
//                             top: 12,
//                             child: Container(
//                               width: 20,
//                               height: 20,
//                               child: FlutterLogo(),
//                             ),
//                           ),
//                           Positioned(
//                             left: 290.50,
//                             top: 65,
//                             child: Container(
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     width: 21,
//                                     height: 21,
//                                     padding: const EdgeInsets.symmetric(horizontal: 5.25, vertical: 9.62),
//                                     decoration: ShapeDecoration(
//                                       color: Colors.white,
//                                       shape: RoundedRectangleBorder(
//                                         side: BorderSide(width: 0.88, color: Color(0xFFD9D9D9)),
//                                         borderRadius: BorderRadius.circular(4.38),
//                                       ),
//                                       shadows: [
//                                         BoxShadow(
//                                           color: Color(0x33FAF8F8),
//                                           blurRadius: 3.50,
//                                           offset: Offset(0, 3.50),
//                                           spreadRadius: 0,
//                                         )
//                                       ],
//                                     ),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
                                      
//                                       ],
//                                     ),
//                                   ),
//                                   Text(
//                                     '2',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 16,
//                                       fontFamily: 'Inter',
//                                       fontWeight: FontWeight.w500,
//                                       height: 0,
//                                     ),
//                                   ),
//                                   Container(
//                                     padding: const EdgeInsets.all(6),
//                                     decoration: ShapeDecoration(
//                                       color: Colors.white,
//                                       shape: RoundedRectangleBorder(
//                                         side: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
//                                         borderRadius: BorderRadius.circular(5),
//                                       ),
//                                       shadows: [
//                                         BoxShadow(
//                                           color: Color(0x33FAF8F8),
//                                           blurRadius: 4,
//                                           offset: Offset(0, 4),
//                                           spreadRadius: 0,
//                                         )
//                                       ],
//                                     ),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
                                      
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Container(
//                       width: 384,
//                       height: 100,
//                       child: SingleChildScrollView(
//         child: Column(
//                         children: [
//                           Positioned(
//                             left: 0,
//                             top: 0,
//                             child: Container(
//                               width: 384,
//                               height: 100,
//                               decoration: ShapeDecoration(
//                                 color: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 shadows: [
//                                   BoxShadow(
//                                     color: Color(0x66E5E5E5),
//                                     blurRadius: 10,
//                                     offset: Offset(10, 10),
//                                     spreadRadius: 0,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 16,
//                             top: 10,
//                             child: Container(
//                               width: 80,
//                               height: 80,
//                               decoration: ShapeDecoration(
//                                 image: DecorationImage(
//                                   image: NetworkImage("https://via.placeholder.com/80x80"),
//                                   fit: BoxFit.cover,
//                                 ),
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 117,
//                             top: 12,
//                             child: Text(
//                               'Kurfi Bahar Potatoes',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w500,
//                                 height: 0,
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 117,
//                             top: 50,
//                             child: Text.rich(
//                               TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: 'Quantity: ',
//                                     style: TextStyle(
//                                       color: Color(0xFFCACACA),
//                                       fontSize: 10,
//                                       fontFamily: 'Inter',
//                                       fontWeight: FontWeight.w400,
//                                       height: 0,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: '1 Kg',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 10,
//                                       fontFamily: 'Inter',
//                                       fontWeight: FontWeight.w400,
//                                       height: 0,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 117,
//                             top: 73,
//                             child: Text(
//                               'Rs 39.00',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w700,
//                                 height: 0,
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 346,
//                             top: 12,
//                             child: Container(
//                               width: 20,
//                               height: 20,
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     width: 20,
//                                     height: 20,
//                                     decoration: ShapeDecoration(
//                                       color: Colors.white,
//                                       shape: OvalBorder(
//                                         side: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
//                                       ),
//                                       shadows: [
//                                         BoxShadow(
//                                           color: Color(0x3FE5E5E5),
//                                           blurRadius: 4,
//                                           offset: Offset(0, 4),
//                                           spreadRadius: 0,
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 290.50,
//                             top: 65,
//                             child: Container(
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     width: 21,
//                                     height: 21,
//                                     padding: const EdgeInsets.symmetric(horizontal: 5.25, vertical: 9.62),
//                                     decoration: ShapeDecoration(
//                                       color: Colors.white,
//                                       shape: RoundedRectangleBorder(
//                                         side: BorderSide(width: 0.88, color: Color(0xFFD9D9D9)),
//                                         borderRadius: BorderRadius.circular(4.38),
//                                       ),
//                                       shadows: [
//                                         BoxShadow(
//                                           color: Color(0x33FAF8F8),
//                                           blurRadius: 3.50,
//                                           offset: Offset(0, 3.50),
//                                           spreadRadius: 0,
//                                         )
//                                       ],
//                                     ),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
                                      
//                                       ],
//                                     ),
//                                   ),
//                                   Text(
//                                     '2',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 16,
//                                       fontFamily: 'Inter',
//                                       fontWeight: FontWeight.w500,
//                                       height: 0,
//                                     ),
//                                   ),
//                                   Container(
//                                     padding: const EdgeInsets.all(6),
//                                     decoration: ShapeDecoration(
//                                       color: Colors.white,
//                                       shape: RoundedRectangleBorder(
//                                         side: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
//                                         borderRadius: BorderRadius.circular(5),
//                                       ),
//                                       shadows: [
//                                         BoxShadow(
//                                           color: Color(0x33FAF8F8),
//                                           blurRadius: 4,
//                                           offset: Offset(0, 4),
//                                           spreadRadius: 0,
//                                         )
//                                       ],
//                                     ),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
                                      
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Container(
//                       width: 384,
//                       height: 100,
//                       child: SingleChildScrollView(
//         child: Column(
//                         children: [
//                           Positioned(
//                             left: 0,
//                             top: 0,
//                             child: Container(
//                               width: 384,
//                               height: 100,
//                               decoration: ShapeDecoration(
//                                 color: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 shadows: [
//                                   BoxShadow(
//                                     color: Color(0x66E5E5E5),
//                                     blurRadius: 10,
//                                     offset: Offset(10, 10),
//                                     spreadRadius: 0,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 16,
//                             top: 10,
//                             child: Container(
//                               width: 80,
//                               height: 80,
//                               decoration: ShapeDecoration(
//                                 image: DecorationImage(
//                                   image: NetworkImage("https://via.placeholder.com/80x80"),
//                                   fit: BoxFit.cover,
//                                 ),
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 117,
//                             top: 12,
//                             child: Text(
//                               'Tomatoes',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w400,
//                                 height: 0,
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 117,
//                             top: 50,
//                             child: Text.rich(
//                               TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: 'Quantity: ',
//                                     style: TextStyle(
//                                       color: Color(0xFFCACACA),
//                                       fontSize: 10,
//                                       fontFamily: 'Inter',
//                                       fontWeight: FontWeight.w400,
//                                       height: 0,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: '1 Kg',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 10,
//                                       fontFamily: 'Inter',
//                                       fontWeight: FontWeight.w400,
//                                       height: 0,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 117,
//                             top: 73,
//                             child: Text(
//                               'Rs 49.00',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w700,
//                                 height: 0,
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 346,
//                             top: 12,
//                             child: Container(
//                               width: 20,
//                               height: 20,
//                               child: FlutterLogo(),
//                             ),
//                           ),
//                           Positioned(
//                             left: 290.50,
//                             top: 65,
//                             child: Container(
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     width: 21,
//                                     height: 21,
//                                     padding: const EdgeInsets.symmetric(horizontal: 5.25, vertical: 9.62),
//                                     decoration: ShapeDecoration(
//                                       color: Colors.white,
//                                       shape: RoundedRectangleBorder(
//                                         side: BorderSide(width: 0.88, color: Color(0xFFD9D9D9)),
//                                         borderRadius: BorderRadius.circular(4.38),
//                                       ),
//                                       shadows: [
//                                         BoxShadow(
//                                           color: Color(0x33FAF8F8),
//                                           blurRadius: 3.50,
//                                           offset: Offset(0, 3.50),
//                                           spreadRadius: 0,
//                                         )
//                                       ],
//                                     ),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
                                      
//                                       ],
//                                     ),
//                                   ),
//                                   Text(
//                                     '2',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 16,
//                                       fontFamily: 'Inter',
//                                       fontWeight: FontWeight.w500,
//                                       height: 0,
//                                     ),
//                                   ),
//                                   Container(
//                                     padding: const EdgeInsets.all(6),
//                                     decoration: ShapeDecoration(
//                                       color: Colors.white,
//                                       shape: RoundedRectangleBorder(
//                                         side: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
//                                         borderRadius: BorderRadius.circular(5),
//                                       ),
//                                       shadows: [
//                                         BoxShadow(
//                                           color: Color(0x33FAF8F8),
//                                           blurRadius: 4,
//                                           offset: Offset(0, 4),
//                                           spreadRadius: 0,
//                                         )
//                                       ],
//                                     ),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
                                      
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 21,
//               top: 532,
//               child: Container(
//                 width: 386,
//                 height: 226,
//                 child: SingleChildScrollView(
//         child: Column(
//                   children: [
//                     Positioned(
//                       left: 1,
//                       top: 0,
//                       child: Container(
//                         width: 244,
//                         height: 45,
//                         child: SingleChildScrollView(
//         child: Column(
//                           children: [
//                             Positioned(
//                               left: 0,
//                               top: 0,
//                               child: Container(
//                                 width: 244,
//                                 height: 45,
//                                 decoration: ShapeDecoration(
//                                   color: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     side: BorderSide(
//                                       width: 1,
//                                       color: Colors.black.withOpacity(0.2199999988079071),
//                                     ),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               left: 14.64,
//                               top: 15.30,
//                               child: Text(
//                                 'Promo Code',
//                                 style: TextStyle(
//                                   color: Color(0xFFCACACA),
//                                   fontSize: 14,
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w400,
//                                   height: 0,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       left: 263,
//                       top: 0,
//                       child: Container(
//                         width: 122,
//                         height: 45,
//                         padding: const EdgeInsets.symmetric(horizontal: 58, vertical: 14),
//                         decoration: ShapeDecoration(
//                           color: Color(0xFF6BF52E),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Apply',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w700,
//                                 height: 0,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       left: 0,
//                       top: 78,
//                       child: Container(
//                         width: 94,
//                         height: 97,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Sub-total',
//                               style: TextStyle(
//                                 color: Colors.black.withOpacity(0.5),
//                                 fontSize: 16,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w400,
//                                 height: 0,
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Text(
//                               'Voucher',
//                               style: TextStyle(
//                                 color: Colors.black.withOpacity(0.5),
//                                 fontSize: 16,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w400,
//                                 height: 0,
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Text(
//                               'Delivery Fee',
//                               style: TextStyle(
//                                 color: Colors.black.withOpacity(0.5),
//                                 fontSize: 16,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w400,
//                                 height: 0,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       left: 1,
//                       top: 207,
//                       child: Text(
//                         'Total',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16,
//                           fontFamily: 'Inter',
//                           fontWeight: FontWeight.w700,
//                           height: 0,
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       left: 329,
//                       top: 207,
//                       child: Text(
//                         'Rs 244',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16,
//                           fontFamily: 'Inter',
//                           fontWeight: FontWeight.w700,
//                           height: 0,
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       left: 332,
//                       top: 78,
//                       child: Text(
//                         'Rs 274',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16,
//                           fontFamily: 'Inter',
//                           fontWeight: FontWeight.w500,
//                           height: 0,
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       left: 333,
//                       top: 117,
//                       child: Text(
//                         '-Rs 50',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16,
//                           fontFamily: 'Inter',
//                           fontWeight: FontWeight.w500,
//                           height: 0,
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       left: 341,
//                       top: 156,
//                       child: Text(
//                         'Rs 20',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16,
//                           fontFamily: 'Inter',
//                           fontWeight: FontWeight.w500,
//                           height: 0,
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       left: 2,
//                       top: 191,
//                       child: Container(
//                         width: 384,
//                         height: 1,
//                         decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 88,
//               top: 790,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 58, vertical: 14),
//                 decoration: ShapeDecoration(
//                   color: Color(0xFF2D2E2D),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Checkout Rs 244',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w700,
//                         height: 0,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }