import 'package:flutter/material.dart';
import 'package:krishi_customer_app/views/consumer%20ui/homescreen.dart';

class OrderSuccessScreen extends StatefulWidget {
  final Map<String, dynamic> order;

  OrderSuccessScreen({required this.order});

  @override
  _OrderSuccessScreenState createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  @override
  void initState() {
    super.initState();

    // Print the whole order object to check the data
    // print('Order Data: ${widget.order}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        // leading: Builder(
        //   builder: (BuildContext context) {
        //     return IconButton(
        //       icon: const Icon(Icons.arrow_back),
        //       onPressed: () {
        //         Navigator.pop(context); // Navigate back
        //       },
        //     );
        //   },
        // ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      "Yes, you’ve successfully ordered!",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Thank you for choosing Krishi Mandi for your agricultural needs. We appreciate your business and look forward to serving you again in the future.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Image.asset("assets/Check icon.png"),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 270,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0), // Radius for all corners
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Payment Details',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Order No."),
                                  Text("12345678"), // Replace with actual order number if available
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total"),
                                  Text(widget.order['totalAmount'].toString()),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Date & Time"),
                                  Text("12/12/2024"), // Replace with actual date and time if available
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Payment Method"),
                                  Text(widget.order['paymentType'] ?? "Online"),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Name"),
                                  Text(widget.order['userName'] ?? "Username"),

                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Email"),
                                  Text(widget.order['email'] ?? "saikat1236@gmail"),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          "Back to Shop",
                          style: TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
