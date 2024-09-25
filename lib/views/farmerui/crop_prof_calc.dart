import 'dart:convert';

import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:dropdown_model_list/drop_down/select_drop_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const List<String> fertilizerList = <String>[
  'Organic',
  'Chemical',
  'Vermicompost',
  'Others'
];

class CropProfCalc extends StatefulWidget {
  const CropProfCalc();

  @override
  State<CropProfCalc> createState() => _RateCalcState();
}

class _RateCalcState extends State<CropProfCalc> {
  File? _image;
  String? _response;

  String selectedFertilizer = fertilizerList.first;

  DropListModel dropListModel2 = DropListModel([
    OptionItem(id: "1", title: "Organic", data: 'CSE Student'),
    OptionItem(id: "2", title: "Chemical", data: 'CSE Student'),
    OptionItem(id: "3", title: "Vermicompost", data: 'CSE Student'),
    OptionItem(id: "4", title: "Others", data: 'CSE Student'),
  ]);
  OptionItem optionItemSelected = OptionItem(title: "Choose Fertilizer Used");

  final _formKey = GlobalKey<FormState>();
  // Text editing controllers for each field
  final TextEditingController _expectedYieldController =
      TextEditingController();
  final TextEditingController _marketPriceController = TextEditingController();
  final TextEditingController _seedCostController = TextEditingController();
  final TextEditingController _fertilizerCostController =
      TextEditingController();
  final TextEditingController _pesticideCostController =
      TextEditingController();
  final TextEditingController _laborCostController = TextEditingController();
  final TextEditingController _otherInputCostController =
      TextEditingController();
  final TextEditingController _irrigationCostController =
      TextEditingController();
  final TextEditingController _crop = TextEditingController();

  // Function to handle the API call
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Collecting all form data
      final double expectedYield =
          double.tryParse(_expectedYieldController.text) ?? 0;
      final double marketPrice =
          double.tryParse(_marketPriceController.text) ?? 0;
      final double seedCost = double.tryParse(_seedCostController.text) ?? 0;
      final double fertilizerCost =
          double.tryParse(_fertilizerCostController.text) ?? 0;
      final double pesticideCost =
          double.tryParse(_pesticideCostController.text) ?? 0;
      final double laborCost = double.tryParse(_laborCostController.text) ?? 0;
      final double otherInputCost =
          double.tryParse(_otherInputCostController.text) ?? 0;

      // Call the API to calculate profit
      try {
        final response = await _calculateProfit(
          cropName: 'Wheat', // Replace with your crop name field if dynamic
          expYield: expectedYield,
          mktPrice: marketPrice,
          seedCost: seedCost,
          fertilizerCost: fertilizerCost,
          pesticideCost: pesticideCost,
          labourCost: laborCost,
          otherInputCost: otherInputCost,
        );

        if (response['status']) {
          final profit = response['payload']['profit'];
          final profitPercentage = response['payload']['profitPercentage'];
          final advice = response['payload']['advice'];

          // Show the result in a dialog box
          _showDialog("Profitability Calculation", "$profit",
              "$profitPercentage", "$advice"
              // "Profit: ₹$profit\n"
              // "Profit Percentage: $profitPercentage%\n"
              // "Advice: $advice",
              );

          setState(() {
            _response = profit.toString();
          });
        } else {
          _showDialog("Error", response['message'], response['message'],
              response['message']);
        }
      } catch (e) {
        _showDialog("Error", "$e", "$e", "$e");
      }
    }
  }

  // Function to show the dialog box
  void _showDialog(String title, String a, String b, String c) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          // content: Text(content),
          content: Container(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Profit: ₹$a",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),), 
                Text("Profit Percentage: $b%",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),), 
                Text("Advice: $c",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('farmer') ??
        ''; // Default to empty string if token is not found
  }

  // API call to calculate profit
  Future<Map<String, dynamic>> _calculateProfit({
    required String cropName,
    required double expYield,
    required double mktPrice,
    required double seedCost,
    required double fertilizerCost,
    required double pesticideCost,
    required double labourCost,
    required double otherInputCost,
  }) async {
    final url =
        Uri.parse('http://54.159.124.169:3000/farmers/calculate-profits');

    // Request body
    final body = jsonEncode({
      "cropName": cropName,
      "expYield": expYield,
      "mktPrice": mktPrice,
      "seedCost": seedCost,
      "fertilizerCost": fertilizerCost,
      "pesticideCost": pesticideCost,
      "labourCost": labourCost,
      "otherInputCost": otherInputCost,
    });
    // final token = await _getToken();
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIwOWI0MjAxNS00NTRkLTRiZDEtOWZjYS1lMTBjNDg3ODEzNTgiLCJ1c2VyVHlwZSI6ImZhcm1lciIsImlhdCI6MTcyNzE4OTk2MH0.ljNuHRrpr5dSIAHiZljqhNsg_sjzH6sjP8pwAqhwBUA";
    // Sending POST request
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': token},
      body: body,
    );

    // Handling the response
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to calculate profit. Server error: ${response.statusCode}');
    }
  }
  // This function can handle API calls to send the form data
  // void _submitForm() {
  //   if (_formKey.currentState!.validate()) {
  //     // Collecting all form data
  //     final double expectedYield =
  //         double.tryParse(_expectedYieldController.text) ?? 0;
  //     final double marketPrice =
  //         double.tryParse(_marketPriceController.text) ?? 0;
  //     final double seedCost = double.tryParse(_seedCostController.text) ?? 0;
  //     final double fertilizerCost =
  //         double.tryParse(_fertilizerCostController.text) ?? 0;
  //     final double pesticideCost =
  //         double.tryParse(_pesticideCostController.text) ?? 0;
  //     final double laborCost = double.tryParse(_laborCostController.text) ?? 0;
  //     final double otherInputCost =
  //         double.tryParse(_otherInputCostController.text) ?? 0;
  //     final double irriCost =
  //         double.tryParse(_irrigationCostController.text) ?? 0;

  //     // Calculate profitability
  //     double profitability = (expectedYield * marketPrice) -
  //         seedCost -
  //         fertilizerCost -
  //         pesticideCost -
  //         laborCost -
  //         otherInputCost;
  //      // Show the result in a dialog box
  //     _showDialog("Profitability Calculation", "Profitability: ₹${profitability.toStringAsFixed(2)}");
  //     // Update the response variable to show the result
  //     setState(() {
  //       _response =
  //           profitability.toStringAsFixed(2); // Limit to 2 decimal places
  //     });

  //     // Get.snackbar("Form Submitted. Profitability: ", "$profitability");  // replace this with dialouge box
  //     // Handle the API call here if needed with formData
  //     print("Form Submitted. Profitability: $profitability");
  //   }
  // }

  //   // Function to show the dialog box
  // void _showDialog(String title, String content) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: Text(content),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text("OK"),
  //             onPressed: () {
  //               Navigator.of(context).pop();  // Close the dialog
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();
    // _loadImageFromAssets();
  }

  // final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var qty = 1;
    String? _selectedValue; // Variable to hold the selected value
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,

        title: const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Krishi ',
                style: TextStyle(
                    color: Colors.black, // Color for 'Krishi'
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
              TextSpan(
                text: 'Mandi',
                style: TextStyle(
                    color: Colors.green, // Color for 'Mandi'
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
            ],
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        );
            // return Padding(
            //   padding: const EdgeInsets.only(left: 10),
            //   child: Image.asset('assets/krishi_logo.png'),
            // );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 900,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, // 180 degrees equivalent
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF), // White (#FFF)
                Color(0xFF83D561), // Green (#83D561)
              ],
              stops: [0.1232, 1.0], // Percentage stops (12.32%, 100%)
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align children to the left
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  "Crop Profitability Calculator",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                )),

                SizedBox(
                  height: 30,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     "Select A crop:",
                //     style: TextStyle(
                //       fontSize: 20,
                //       color: Colors.black,
                //       fontWeight: FontWeight.w500,
                //     ),
                //     maxLines: 2,
                //     textAlign: TextAlign.left,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Form(
                      key:
                          _formKey, // Associating the Form widget with _formKey
                      child: Column(
                        children: [
                           Row(
                            children: [
                              Container(
                                width:
                                    150, // Fixed width for the label to ensure alignment
                                child: Text(
                                  "Crop Used",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white, // Background color
                                    borderRadius: BorderRadius.circular(
                                        15.0), // Rounded corners
                                    border: Border.all(
                                      color: Color.fromARGB(
                                          200, 131, 221, 93), // Border color
                                      width: 2.0, // Border width
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.5), // Shadow color
                                        spreadRadius: 1, // Shadow spread
                                        blurRadius: 6, // Shadow blur
                                        offset: Offset(0, 1), // Shadow position
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: TextFormField(
                                      // controller: controller,
                                      decoration: InputDecoration(
                                        border: InputBorder
                                            .none, // Removes the underline
                                        hintText: 'Crop Used',
                                      ),
                                      // keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Crop Used';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                width:
                                    150, // Fixed width for the label to ensure alignment
                                child: Text(
                                  "Area",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white, // Background color
                                    borderRadius: BorderRadius.circular(
                                        15.0), // Rounded corners
                                    border: Border.all(
                                      color: Color.fromARGB(
                                          200, 131, 221, 93), // Border color
                                      width: 2.0, // Border width
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.5), // Shadow color
                                        spreadRadius: 1, // Shadow spread
                                        blurRadius: 6, // Shadow blur
                                        offset: Offset(0, 1), // Shadow position
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: TextFormField(
                                      // controller: controller,
                                      decoration: InputDecoration(
                                        border: InputBorder
                                            .none, // Removes the underline
                                        hintText: 'Area',
                                      ),
                                      // keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Crop Used';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                width:
                                    150, // Fixed width for the label to ensure alignment
                                child: Text(
                                  "Fertilizer Used",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),

                              Expanded(
                                child: Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white, // Background color
                                    borderRadius: BorderRadius.circular(
                                        15.0), // Rounded corners
                                    border: Border.all(
                                      color: Color.fromARGB(
                                          200, 131, 221, 93), // Border color
                                      width: 2.0, // Border width
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.5), // Shadow color
                                        spreadRadius: 1, // Shadow spread
                                        blurRadius: 6, // Shadow blur
                                        offset: Offset(0, 1), // Shadow position
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: DropdownButton<String>(
                                      value: selectedFertilizer,
                                      icon: const Icon(
                                          Icons.arrow_drop_down_sharp),
                                      elevation: 16,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      underline: Container(
                                        height: 0, // Removes default underline
                                      ),
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedFertilizer = value!;
                                        });
                                      },
                                      items: fertilizerList
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                              // ),
                            ],
                          ),
                          SizedBox(height: 10),
                          buildRowWithTextFormField("Expected Yield in Kg.",
                              _expectedYieldController),
                          SizedBox(height: 10),
                          buildRowWithTextFormField(
                              "Market Price in Rs.", _marketPriceController),
                          SizedBox(height: 10),
                          buildRowWithTextFormField(
                              "Seed Cost in Rs.", _seedCostController),
                          SizedBox(height: 10),
                          buildRowWithTextFormField("Fertilizer Cost in Rs.",
                              _fertilizerCostController),
                          SizedBox(height: 10),
                          buildRowWithTextFormField("Pesticide Cost in Rs.",
                              _pesticideCostController),
                          SizedBox(height: 10),
                          buildRowWithTextFormField(
                              "Labor Cost in Rs.", _laborCostController),
                          SizedBox(height: 10),
                          buildRowWithTextFormField("Irrigation Cost in Rs.",
                              _irrigationCostController),
                          SizedBox(height: 10),
                          buildRowWithTextFormField("Other Input Cost in Rs.",
                              _otherInputCostController),
                          SizedBox(height: 20),
                         
                          ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(150, 50), // Same size as the Container
                              padding: EdgeInsets
                                  .zero, // Remove padding to match exact size
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15.0), // Rounded corners
                              ),
                              // Use a gradient as background using a decoration box with Ink
                              backgroundColor: Colors
                                  .transparent, // Set transparent background color
                              shadowColor: Colors
                                  .transparent, // Remove button's default shadow
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment
                                      .centerRight, // Start from the right (270deg equivalent)
                                  end: Alignment
                                      .centerLeft, // End towards the left
                                  colors: [
                                    Color(0xFF362A84), // Hex color #362A84
                                    Color(0xFF84D761), // Hex color #84D761
                                  ],
                                  stops: [
                                    0.0023,
                                    0.942,
                                  ], // Percentage stops 0.23% and 94.2%
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                width: 150,
                                height: 50,
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Get Rate",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),

                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 20,
                ),

                // Center(
                //   child: Container(
                //       height: 150,
                //       width: 250,
                //       decoration: BoxDecoration(
                //           // color:Colors.green[100],
                //           borderRadius: BorderRadius.circular(30.0),
                //           border: Border.all(color: Colors.white)),
                //       child: Center(
                //           child: Text(
                //         '$_response',
                //         style: TextStyle(fontSize: 40),
                //       ))),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRowWithTextFormField(
      String label, TextEditingController controller) {
    return Row(
      children: [
        Container(
          width: 150, // Fixed width for the label to ensure alignment
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Container(
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.white, // Background color
              borderRadius: BorderRadius.circular(15.0), // Rounded corners
              border: Border.all(
                color: Color.fromARGB(200, 131, 221, 93), // Border color
                width: 2.0, // Border width
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color
                  spreadRadius: 1, // Shadow spread
                  blurRadius: 6, // Shadow blur
                  offset: Offset(0, 1), // Shadow position
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none, // Removes the underline
                  hintText: '$label',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter $label';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
