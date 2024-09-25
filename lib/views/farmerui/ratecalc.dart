import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:dropdown_model_list/drop_down/select_drop_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class RateCalc extends StatefulWidget {
  const RateCalc();

  @override
  State<RateCalc> createState() => _RateCalcState();
}

class _RateCalcState extends State<RateCalc> {
  File? _image;
  String? _response;

  @override
  void initState() {
    super.initState();
    // _loadImageFromAssets();
  }

  // final ImagePicker _picker = ImagePicker();

  DropListModel dropListModel1 = DropListModel([
    OptionItem(id: "1", title: "abc", data: 'CSE Student'),
    OptionItem(id: "2", title: "abc2", data: 'CSE Student'),
    OptionItem(id: "3", title: "abc3", data: 'CSE Student'),
  ]);
  DropListModel dropListModel2 = DropListModel([
    OptionItem(id: "1", title: "xyz", data: 'CSE Student'),
    OptionItem(id: "2", title: "xyz2", data: 'CSE Student'),
    OptionItem(id: "3", title: "xyz3", data: 'CSE Student'),
  ]);
  OptionItem optionItemSelected = OptionItem(title: "Choose Crop Type");
  OptionItem optionItemSelected2 = OptionItem(title: "Choose Your Location");

  TextEditingController controller = TextEditingController();
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
            //   child: Image.asset('assets/krishi-logo.png'),
            // );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 800,
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
                  height: 30,
                ),
                Center(
                    child: Text(
                  "Mandi Rate Calculator",
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

                SelectDropRadio(
                  height: 70.0, // Example property for height
                  width: 330.0, // Example property for width
                  arrowColor: Colors.black,
                  hintColorTitle: Colors.black,
                  borderColor: Colors.green,
                  borderRadius: BorderRadius.circular(15.0),
                  defaultText: optionItemSelected,
                  dropListModel: dropListModel1,
                  showIcon: false,
                  showBorder: true,
                  paddingTop: 0,
                  enable: true,
                  submitText: "OK",
                  colorSubmitButton: Colors.green,
                  selectedRadioColor: Colors.amber,
                  suffixIcon: Icons.arrow_drop_down,
                  containerPadding: const EdgeInsets.all(10),
                  icon: const Icon(Icons.person, color: Colors.black),
                  onOptionListSelected: (data) {
                    print(data.title);
                    setState(() {});
                  },
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
                SelectDropRadio(
                  height: 70.0, // Example property for height
                  width: 330.0, // Example property for width
                  hintColorTitle: Colors.black,
                  borderColor: Colors.green,

                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [],
                  defaultText: optionItemSelected2,
                  dropListModel: dropListModel2,
                  showIcon: false,
                  showBorder: true,
                  paddingTop: 0,
                  enable: true,
                  submitText: "OK",
                  colorSubmitButton: Colors.green,
                  selectedRadioColor: Colors.amber,
                  suffixIcon: Icons.arrow_drop_down,
                  containerPadding: const EdgeInsets.all(10),
                  icon: const Icon(Icons.person, color: Colors.black),
                  onOptionListSelected: (data) {
                    print(data.title);
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 40,
                ),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Your button action here
                      print("button");
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(150, 50), // Same size as the Container
                      padding:
                          EdgeInsets.zero, // Remove padding to match exact size
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15.0), // Rounded corners
                      ),
                      // Use a gradient as background using a decoration box with Ink
                      backgroundColor: Colors
                          .transparent, // Set transparent background color
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
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                Center(
                  child: Container(
                      height: 150,
                      width: 250,
                      decoration: BoxDecoration(
                          // color:Colors.green[100],
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(color: Colors.white)),
                      child: Center(
                          child: Text(
                        '$_response',
                        style: TextStyle(fontSize: 40),
                      ))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         centerTitle: true,
//         title: const Text('AI Quality Grading', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//         leading: Builder(
//           builder: (BuildContext context) {
//             return IconButton(
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             );
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               _image != null
//                   ? Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                           width: double.infinity,
//                           height: 300,
//                           child: Image.file(_image!, height: 200, width: 200, fit: BoxFit.cover)),
//                     )
//                   : Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                           width: double.infinity,
//                           height: 300,
//                           decoration: BoxDecoration(),
//                           child: Center(
//                             child: Image.asset("assets/fileupload.png", height: 300, width: 600,),
//                           ),
//                       ),
//                     ),
//               SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color.fromRGBO(74, 230, 50, 0.961),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30.0),
//                           side: BorderSide(color: Color.fromRGBO(74, 230, 50, 0.961), width: 2.0),
//                         ),
//                         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                       ),
//                       onPressed: _loadImageFromAssets,
//                       child: Text("Pick Image", style: TextStyle(color: Colors.black)),
//                     ),
//                     Spacer(),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color.fromRGBO(74, 230, 50, 0.961),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30.0),
//                           side: BorderSide(color: Color.fromRGBO(74, 230, 50, 0.961), width: 2.0),
//                         ),
//                         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                       ),
//                       onPressed: _uploadImage,
//                       child: Text("Upload Image", style: TextStyle(color: Colors.black)),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 30),
//               if (_response != null)
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     "Response: $_response",
//                     style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               // Rest of your UI components...
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
