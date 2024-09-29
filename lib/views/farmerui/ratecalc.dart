import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';

class RateCalc extends StatefulWidget {
  const RateCalc();

  @override
  State<RateCalc> createState() => _RateCalcState();
}

class _RateCalcState extends State<RateCalc> {
  String? selectedDistrict;
  String? selectedCommodity;
  String? selectedVariety;

  List<String> districts = [];
  List<String> commodities = [];
  List<String> varieties = [];

  bool isLoadingDistricts = true;
  bool isLoadingCommodities = false;
  bool isLoadingVarieties = false;

  @override
  void initState() {
    super.initState();
    fetchDistricts(); // Load districts when the screen initializes
  }

  // Fetch Districts from API
  Future<void> fetchDistricts() async {
    setState(() {
      isLoadingDistricts = true;
    });
    final response = await http
        .post(Uri.parse('http://54.159.124.169:3000/common/get-districts'));
    if (response.statusCode == 200) {
      // print("ajkdbwifuer");
      var data = jsonDecode(response.body);
      print(data);
      setState(() {
        districts = List<String>.from(
            data['payload']); // Assuming 'districts' key contains the list
        isLoadingDistricts = false;
      });
    } else {
      // Handle error here
      setState(() {
        isLoadingDistricts = false;
      });
    }
  }

  // Fetch Commodities from API based on selected district
  Future<void> fetchCommodities(String district) async {
    setState(() {
      isLoadingCommodities = true;
      commodities = []; // Reset commodities list
      selectedCommodity = null;
    });
    final response = await http
        .post(Uri.parse('http://54.159.124.169:3000/common/get-comodities'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        commodities = List<String>.from(
            data['payload']); // Assuming 'commodities' key contains the list
        isLoadingCommodities = false;
      });
    } else {
      // Handle error here
      setState(() {
        isLoadingCommodities = false;
      });
    }
  }

  Future<void> fetchVarieties(String district, String commodity) async {
    setState(() {
      isLoadingVarieties = true;
      varieties = []; // Reset varieties list
      selectedVariety = null;
    });

    // Create a map for the request body
    final body = jsonEncode({
      'name': commodity,
      'district': district,
    });

    final response = await http.post(
      Uri.parse('http://54.159.124.169:3000/common/get-varieties'),
      headers: {
        'Content-Type': 'application/json', // Ensure you're sending JSON
      },
      body: body, // Pass the encoded body here
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        varieties = List<String>.from(
            data['payload']); // Assuming 'varieties' key contains the list
        isLoadingVarieties = false;
      });
    } else {
      // Handle error here
      setState(() {
        isLoadingVarieties = false;
      });
    }
  }

  String? state;
  String? district;
  String? market;
  String? commodity;
  String? grade;
  String? variety;
  String? arrivalDate;
  String? minPrice;
  String? maxPrice;
  String? modalPrice;



  Future<void> _showDialog(String dist, String commu, String vari) async {
    // Print for debugging
    print("here");

    // Fetch the varieties
    String distt=dist;
    String commuu=commu;
    String varii=vari;
    await fetchres(distt, commuu, varii);

    // Show the dialog after fetching data
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Market Details"),
          content: Container(
            width: 400,
            height: 300, // Adjust the height if necessary
            child: SingleChildScrollView(
              // Scroll if the content exceeds the container height
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "State: $state",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8), // Spacing
                  Text(
                    "District: $district",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Market: $market",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Commodity: $commodity",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Grade: $grade",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Variety: $variety",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Arrival Date: $arrivalDate",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Min Price: ₹$minPrice per Kg",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Max Price: ₹$maxPrice per Kg",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Modal Price: ₹$modalPrice per Kg",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
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

// Fetch varieties method
  Future<void> fetchres(String dist, String commu, String vari) async {
    print(
        "Fetching varieties for: District: $dist, Commodity: $commu, Variety: $vari");

    final body = jsonEncode({
      "name": commu,
      "variety": vari,
      "district": dist
      // "name": "Banana",
      // "variety": "Banana - Ripe",
      // "district": "Agra"
    });

    final response = await http.post(
      Uri.parse('http://54.159.124.169:3000/common/get-current-rates'),
          headers: {
        'Content-Type': 'application/json', // Ensure you're sending JSON
      },
      body: body,
    );

    print("res: ${body}");
    if (response.statusCode == 200) {
      var data2 = jsonDecode(response.body);
      // Assuming the payload contains market details
      // You can now assign values to the respective variables
      var data = data2["payload"];
      print("$data");
      setState(() {
        state = data[0]['state'];
        district = data[0]['district'];
        market = data[0]['market'];
        commodity = data[0]['commodity'];
        grade = data[0]['grade'];
        variety = data[0]['variety'];
        arrivalDate = data[0]['arrival_date'];
        minPrice = data[0]['min_price'];
        maxPrice = data[0]['max_price'];
        modalPrice = data[0]['modal_price'];
      });
    } else {
      print("Error fetching varieties: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2E2E2E),
        // elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,

        title: const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Krishi ',
                style: TextStyle(
                    color: Colors.white, // Color for 'Krishi'
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
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            );
            // return Padding(
            //   padding: const EdgeInsets.only(left: 10),
            //   child: Image.asset('assets/krishi_logo.png'),
            // );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                "Mandi rate Fetcher",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              )),
              SizedBox(
                height: 100,
              ),
              // District Dropdown
              isLoadingDistricts
                  ? CircularProgressIndicator()
                  : Container(
                      height: 60,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white, // Background color
                        borderRadius:
                            BorderRadius.circular(15.0), // Rounded corners
                        border: Border.all(
                          color:
                              Color.fromARGB(200, 131, 221, 93), // Border color
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
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedDistrict,
                            hint: Text("Select District"),
                            isExpanded: true,
                            items: districts.map((String district) {
                              return DropdownMenuItem<String>(
                                value: district,
                                child: Text(district),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                selectedDistrict = value!;
                                fetchCommodities(
                                    selectedDistrict!); // Fetch commodities when district is selected
                              });
                            },
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),

              // Commodities Dropdown
              isLoadingCommodities
                  ? CircularProgressIndicator()
                  : Container(
                      height: 60,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white, // Background color
                        borderRadius:
                            BorderRadius.circular(15.0), // Rounded corners
                        border: Border.all(
                          color:
                              Color.fromARGB(200, 131, 221, 93), // Border color
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
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedCommodity,
                            hint: Text("Select Commodity"),
                            isExpanded: true,
                            items: commodities.map((String commodity) {
                              return DropdownMenuItem<String>(
                                value: commodity,
                                child: Text(commodity),
                              );
                            }).toList(),
                            onChanged: selectedDistrict == null
                                ? null // Disable if district is not selected
                                : (String? value) {
                                    setState(() {
                                      selectedCommodity = value!;
                                      fetchVarieties(selectedDistrict!,
                                          selectedCommodity!); // Fetch varieties when commodity is selected
                                    });
                                  },
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),

              // Varieties Dropdown
              isLoadingVarieties
                  ? CircularProgressIndicator()
                  : Container(
                      height: 60,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white, // Background color
                        borderRadius:
                            BorderRadius.circular(15.0), // Rounded corners
                        border: Border.all(
                          color:
                              Color.fromARGB(200, 131, 221, 93), // Border color
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
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedVariety,
                            hint: Text("Select Variety"),
                            isExpanded: true,
                            items: varieties.map((String variety) {
                              return DropdownMenuItem<String>(
                                value: variety,
                                child: Text(variety),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                selectedVariety = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 50),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 50), // Same size as the Container
                  padding:
                      EdgeInsets.zero, // Remove padding to match exact size
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15.0), // Rounded corners
                  ),
                  // Use a gradient as background using a decoration box with Ink
                  backgroundColor:
                      Colors.transparent, // Set transparent background color
                  shadowColor:
                      Colors.transparent, // Remove button's default shadow
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment
                          .centerRight, // Start from the right (270deg equivalent)
                      end: Alignment.centerLeft, // End towards the left
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
                onPressed: () {
                  if (selectedDistrict != null &&
                      selectedCommodity != null &&
                      selectedVariety != null) {
                    // Perform action based on selected values
                    print('Selected District: $selectedDistrict');
                    print('Selected Commodity: $selectedCommodity');
                    print('Selected Variety: $selectedVariety');
                        fetchres("$selectedDistrict", "$selectedCommodity",
                        "$selectedVariety");
                    _showDialog("$selectedDistrict", "$selectedCommodity",
                        "$selectedVariety");
                  } else {
                    // Show an error message
                    print('Please select all fields');
                    // _showDialog("$selectedDistrict","$selectedCommodity","$selectedVariety");
                  }
                },
                // child: const Text('Get Rate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
