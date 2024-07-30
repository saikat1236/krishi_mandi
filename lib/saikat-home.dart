import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SaikatHome extends StatefulWidget {
  const SaikatHome();
  //     {super.key, required this.initialScreen, required this.farmerscreen});
  // final Widget initialScreen;
  // final Widget farmerscreen;
  @override
  State<SaikatHome> createState() => _SaikatHomeState();
}

class _SaikatHomeState extends State<SaikatHome> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          // width: 390,
          height: 844,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFFF4F8FC)),
          child: Stack(
            children: [
              Positioned(
                left: 222,
                top: 475,
                child: Container(
                  // width: 145,
                  height: 188,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 254,
                top: 162,
                child: Container(
                  width: 105,
                  height: 107,
                  decoration: ShapeDecoration(
                    color: Color(0xFFD7EAF8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 6,
                top: 112,
                child: Container(
                  width: 377,
                  height: 38,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50, color: Color(0xFF909090)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 354,
                top: 14,
                child: Container(width: 22, height: 22, child: Stack()),
              ),
              Positioned(
                left: 21,
                top: 329,
                child: Container(
                  width: 348,
                  height: 123,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/348x123"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 261.23,
                top: 167,
                child: Container(
                  width: 91.77,
                  height: 71.78,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/92x72"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 222,
                top: 475,
                child: Container(
                  width: 145,
                  height: 114,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/145x114"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 41,
                top: 85,
                child: SizedBox(
                  width: 103,
                  height: 16,
                  child: Text(
                    'Search',
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 52,
                top: 282,
                child: Container(
                  width: 56,
                  height: 16,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 56,
                          height: 16,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.65, color: Color(0xCC6A994E)),
                              borderRadius: BorderRadius.circular(3.88),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 13,
                        top: 3,
                        child: SizedBox(
                          width: 30,
                          height: 11,
                          child: Text(
                            'See all',
                            style: TextStyle(
                              color: Color(0xFF6A994E),
                              fontSize: 9,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 166,
                top: 282,
                child: Container(
                  width: 56,
                  height: 16,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 56,
                          height: 16,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.65, color: Color(0xCC6A994E)),
                              borderRadius: BorderRadius.circular(3.88),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 13,
                        top: 3,
                        child: SizedBox(
                          width: 30,
                          height: 11,
                          child: Text(
                            'See all',
                            style: TextStyle(
                              color: Color(0xFF6A994E),
                              fontSize: 9,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 279,
                top: 282,
                child: Container(
                  width: 56,
                  height: 16,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 56,
                          height: 16,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.65, color: Color(0xCC6A994E)),
                              borderRadius: BorderRadius.circular(3.88),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 13,
                        top: 3,
                        child: SizedBox(
                          width: 30,
                          height: 11,
                          child: Text(
                            'See all',
                            style: TextStyle(
                              color: Color(0xFF6A994E),
                              fontSize: 9,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 307,
                top: 135,
                child: Container(
                  width: 56,
                  height: 16,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 56,
                          height: 16,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.65, color: Color(0xCC6A994E)),
                              borderRadius: BorderRadius.circular(3.88),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 13,
                        top: 3,
                        child: SizedBox(
                          width: 30,
                          height: 11,
                          child: Text(
                            'See all',
                            style: TextStyle(
                              color: Color(0xFF6A994E),
                              fontSize: 9,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 134,
                child: SizedBox(
                  width: 105,
                  height: 18,
                  child: Text(
                    'Shop by variety',
                    style: TextStyle(
                      color: Color(0xFF3C3C3C),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 162,
                child: Container(
                  width: 308,
                  height: 107,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 105,
                          height: 107,
                          decoration: ShapeDecoration(
                            color: Color(0xFFD7EAF8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 7,
                        top: 5,
                        child: Container(
                          width: 91.77,
                          height: 71.78,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://via.placeholder.com/92x72"),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 6,
                        top: 82,
                        child: SizedBox(
                          width: 73,
                          height: 14,
                          child: Text(
                            'Vegetables',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 113,
                        top: 0,
                        child: Container(
                          width: 105,
                          height: 107,
                          decoration: ShapeDecoration(
                            color: Color(0xFFD7EAF8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 119.66,
                        top: 5,
                        child: Container(
                          width: 92.67,
                          height: 71.78,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://via.placeholder.com/93x72"),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 122,
                        top: 82,
                        child: SizedBox(
                          width: 73,
                          height: 14,
                          child: Text(
                            'Fruits',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 235,
                        top: 82,
                        child: SizedBox(
                          width: 73,
                          height: 14,
                          child: Text(
                            'Exotic',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 38,
                top: 474,
                child: Container(
                  width: 329,
                  height: 391,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 145,
                          height: 189,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 184,
                        top: 202,
                        child: Container(
                          width: 145,
                          height: 189,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 145,
                          height: 114,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://via.placeholder.com/145x114"),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 184,
                        top: 202,
                        child: Container(
                          width: 145,
                          height: 114,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://via.placeholder.com/145x114"),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 14,
                        top: 123,
                        child: SizedBox(
                          width: 82,
                          height: 20,
                          child: Text(
                            'Potato(Aloo)',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 198,
                        top: 325,
                        child: SizedBox(
                          width: 82,
                          height: 20,
                          child: Text(
                            'Potato(Aloo)',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 199,
                        top: 123,
                        child: SizedBox(
                          width: 82,
                          height: 20,
                          child: Text(
                            'Potato(Aloo)',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 38,
                top: 676,
                child: Container(
                  width: 145,
                  height: 189,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 145,
                          height: 189,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 145,
                          height: 114,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://via.placeholder.com/145x114"),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 53,
                top: 617,
                child: SizedBox(
                  width: 57,
                  height: 15,
                  child: Text(
                    '1 kg',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6100000143051147),
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 237,
                top: 819,
                child: SizedBox(
                  width: 57,
                  height: 15,
                  child: Text(
                    '1 kg',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6100000143051147),
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 238,
                top: 617,
                child: SizedBox(
                  width: 57,
                  height: 15,
                  child: Text(
                    '1 kg',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6100000143051147),
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 58,
                top: 640,
                child: SizedBox(
                  width: 43,
                  height: 18,
                  child: Text(
                    '49',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 242,
                top: 842,
                child: SizedBox(
                  width: 43,
                  height: 18,
                  child: Text(
                    '49',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 243,
                top: 640,
                child: SizedBox(
                  width: 43,
                  height: 18,
                  child: Text(
                    '49',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 112,
                top: 629,
                child: Container(
                  width: 56.73,
                  height: 23,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 56.73,
                          height: 23,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.93, color: Color(0xFF2C7B3E)),
                              borderRadius: BorderRadius.circular(5.57),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 13.17,
                        top: 4.31,
                        child: SizedBox(
                          width: 30.39,
                          height: 15.81,
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Color(0xFF6A994E),
                              fontSize: 12.94,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 296,
                top: 831,
                child: Container(
                  width: 56.73,
                  height: 23,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 56.73,
                          height: 23,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.93, color: Color(0xFF2C7B3E)),
                              borderRadius: BorderRadius.circular(5.57),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 13.17,
                        top: 4.31,
                        child: SizedBox(
                          width: 30.39,
                          height: 15.81,
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Color(0xFF6A994E),
                              fontSize: 12.94,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 297,
                top: 629,
                child: Container(
                  width: 56.73,
                  height: 23,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 56.73,
                          height: 23,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.93, color: Color(0xFF2C7B3E)),
                              borderRadius: BorderRadius.circular(5.57),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 13.17,
                        top: 4.31,
                        child: SizedBox(
                          width: 30.39,
                          height: 15.81,
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Color(0xFF6A994E),
                              fontSize: 12.94,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 53,
                top: 790,
                child: SizedBox(
                  width: 82,
                  height: 20,
                  child: Text(
                    'Potato(Aloo)',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 54,
                top: 810,
                child: SizedBox(
                  width: 57,
                  height: 15,
                  child: Text(
                    '1 kg',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6100000143051147),
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 59,
                top: 833,
                child: SizedBox(
                  width: 43,
                  height: 18,
                  child: Text(
                    '49',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 113,
                top: 822,
                child: Container(
                  width: 56.73,
                  height: 23,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 56.73,
                          height: 23,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.93, color: Color(0xFF2C7B3E)),
                              borderRadius: BorderRadius.circular(5.57),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 13.17,
                        top: 4.31,
                        child: SizedBox(
                          width: 30.39,
                          height: 15.81,
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Color(0xFF6A994E),
                              fontSize: 12.94,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 63,
                top: 359,
                child: SizedBox(
                  width: 231,
                  height: 40,
                  child: Text(
                    'Get 50% OFF \non your purchase !',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 331,
                top: 16,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: ShapeDecoration(
                    color: Color(0xFFFF2A2E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(360),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}