import 'dart:convert';

import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:dropdown_model_list/drop_down/select_drop_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Uploadpage extends StatefulWidget {
  const Uploadpage({Key? key}) : super(key: key);

  @override
  State<Uploadpage> createState() => _UploadpageState();
}

class _UploadpageState extends State<Uploadpage> {
  File? _image;
  String? _response;

  final ImagePicker _picker = ImagePicker();
  final DropListModel dropListModel1 = DropListModel([
  OptionItem(id: "1", title: "Potato (आलू)"),
  OptionItem(id: "2", title: "Tomato (टमाटर)"),
  OptionItem(id: "3", title: "Onion (प्याज़)"),
  OptionItem(id: "4", title: "Ginger (अदरक)"),
  OptionItem(id: "5", title: "Chilli (मिर्च)"), // Assuming you still want to keep this item
  ]);

  final DropListModel dropListModel2 = DropListModel([
    OptionItem(id: "1", title: "Organic fertilizer"),
    OptionItem(id: "2", title: "Vermi compost"),
    OptionItem(id: "3", title: "Compost"),
    OptionItem(id: "4", title: "Chemical fertilizer"),
    OptionItem(id: "5", title: "Others"),
  ]);

  OptionItem optionItemSelected = OptionItem(title: "Select Crop");
  OptionItem optionItemSelected2 = OptionItem(title: "Select Fertilizer");

  @override
  void initState() {
    super.initState();
    _loadImageFromAssets();
  }

// Modify your showResultDialog to accept the parsed response
void showResultDialog(Map<String, dynamic> innerResponse) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: 300,
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "Result",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildResultSection(
                label: "Quality Grade:",
                result: innerResponse['grade'] ?? 'N/A', // Extract grade from inner response
              ),
              const SizedBox(height: 30),
              _buildResultSection(
                label: "Type:",
                result: innerResponse['type'] ?? 'N/A', // Extract type from inner response
              ),
              const SizedBox(height: 30),
              _buildResultSection(
                label: "Freshness:",
                result: innerResponse['freshness'] ?? 'N/A', // Extract freshness from inner response
              ),
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
// Example of how to call the dialog
// showResultDialog(context);



  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _loadImageFromAssets() async {
    try {
      final byteData = await rootBundle.load('assets/no_image.jpg');
      final file = File('${(await getTemporaryDirectory()).path}/no_image.jpg');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      setState(() {
        _image = file;
      });
    } catch (e) {
      setState(() {
        _response = 'Error loading image: $e';
      });
    }
  }

 Future<void> _uploadImage() async {
  if (_image == null) return;

  try {
    final uri = Uri.parse('http://54.159.124.169:3000/common/predict-product');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('files', _image!.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final Map<String, dynamic> jsonResponse = jsonDecode(responseData); // Decode the JSON response
      
      if (jsonResponse['status'] == true) {
        // Extract the payload and parse the inner response
        final payload = jsonResponse['payload'];
        final innerResponse = jsonDecode(payload['response']); // Decode the inner response

        // Show the dialog with the result
        showResultDialog(innerResponse); // Pass the inner response to the dialog

        setState(() {
          _response = innerResponse.toString(); // Store the inner response as a string for state
          print(_response);
        });
      } else {
        setState(() {
          _response = 'Failed to upload image. Response: $responseData';
        });
      }
    } else {
      final responseData = await response.stream.bytesToString();
      setState(() {
        _response = 'Failed to upload image. Status code: ${response.statusCode}. Response: $responseData';
      });
    }
  } catch (e) {
    setState(() {
      _response = 'Failed to upload image. Error: $e';
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2E2E2E),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'AI Quality Grading',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _image != null
                ? InkWell(
                    onTap: () {
                      // Handle tap event here
                      print('Container tapped!');
                      _pickImage();
                      // Add your action for tap, e.g., showing image details or navigating to another screen
                    },
// Your existing long press handler to pick an image
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: _image != null // Check if _image is not null
                            ? Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: Text(
                                  'No image selected', // Placeholder when no image is selected
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      // Handle tap event here
                      print('Container tapped 2!');
                      _pickImage();
                      // You can add your action for tap here, like navigating to another screen or showing a dialog
                    },
                    // Your existing long press handler
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          // Add additional styling if needed
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/fileupload.png",
                            height: 300,
                            width: 600,
                          ),
                        ),
                      ),
                    ),
                  ),

            const SizedBox(height: 20),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       // ElevatedButton(
            //       //   style: ElevatedButton.styleFrom(
            //       //     backgroundColor: const Color.fromRGBO(74, 230, 50, 0.961),
            //       //     shape: RoundedRectangleBorder(
            //       //       borderRadius: BorderRadius.circular(30.0),
            //       //       side: const BorderSide(
            //       //           color: Color.fromRGBO(74, 230, 50, 0.961),
            //       //           width: 2.0),
            //       //     ),
            //       //     padding: const EdgeInsets.symmetric(
            //       //         horizontal: 30, vertical: 15),
            //       //   ),
            //       //   onPressed: _pickImage,
            //       //   child: const Text(
            //       //     "Pick Image",
            //       //     style: TextStyle(color: Colors.black),
            //       //   ),
            //       // ),
            //        ElevatedButton(
            //                 onPressed: _pickImage,
            //                 style: ElevatedButton.styleFrom(
            //                   minimumSize:
            //                       Size(150, 50), // Same size as the Container
            //                   padding: EdgeInsets
            //                       .zero, // Remove padding to match exact size
            //                   shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(
            //                         15.0), // Rounded corners
            //                   ),
            //                   // Use a gradient as background using a decoration box with Ink
            //                   backgroundColor: Colors
            //                       .transparent, // Set transparent background color
            //                   shadowColor: Colors
            //                       .transparent, // Remove button's default shadow
            //                 ),
            //                 child: Ink(
            //                   decoration: BoxDecoration(
            //                     gradient: LinearGradient(
            //                       begin: Alignment
            //                           .centerRight, // Start from the right (270deg equivalent)
            //                       end: Alignment
            //                           .centerLeft, // End towards the left
            //                       colors: [
            //                         Color(0xFF362A84), // Hex color #362A84
            //                         Color(0xFF84D761), // Hex color #84D761
            //                       ],
            //                       stops: [
            //                         0.0023,
            //                         0.942,
            //                       ], // Percentage stops 0.23% and 94.2%
            //                     ),
            //                     borderRadius: BorderRadius.circular(15.0),
            //                   ),
            //                   child: Container(
            //                     width: 150,
            //                     height: 50,
            //                     alignment: Alignment.center,
            //                     child: Padding(
            //                       padding: const EdgeInsets.all(8.0),
            //                       child: Text(
            //                         "Pick Image",
            //                         style: TextStyle(
            //                           fontSize: 20,
            //                           color: Colors.white,
            //                           fontWeight: FontWeight.w700,
            //                         ),
            //                         maxLines: 2,
            //                         textAlign: TextAlign.left,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //       const Spacer(),
            //       // ElevatedButton(
            //       //   style: ElevatedButton.styleFrom(
            //       //     backgroundColor: const Color.fromRGBO(74, 230, 50, 0.961),
            //       //     shape: RoundedRectangleBorder(
            //       //       borderRadius: BorderRadius.circular(30.0),
            //       //       side: const BorderSide(
            //       //           color: Color.fromRGBO(74, 230, 50, 0.961),
            //       //           width: 2.0),
            //       //     ),
            //       //     padding: const EdgeInsets.symmetric(
            //       //         horizontal: 30, vertical: 15),
            //       //   ),
            //       //   onPressed: _uploadImage,
            //       //   child: const Text(
            //       //     "Upload Image",
            //       //     style: TextStyle(color: Colors.black),
            //       //   ),
            //       // ),
            //  ElevatedButton(
            //           onPressed: _uploadImage,
            //           style: ElevatedButton.styleFrom(
            //             minimumSize:
            //                 Size(150, 50), // Same size as the Container
            //             padding: EdgeInsets
            //                 .zero, // Remove padding to match exact size
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(
            //                   15.0), // Rounded corners
            //             ),
            //             // Use a gradient as background using a decoration box with Ink
            //             backgroundColor: Colors
            //                 .transparent, // Set transparent background color
            //             shadowColor: Colors
            //                 .transparent, // Remove button's default shadow
            //           ),
            //           child: Ink(
            //             decoration: BoxDecoration(
            //               gradient: LinearGradient(
            //                 begin: Alignment
            //                     .centerRight, // Start from the right (270deg equivalent)
            //                 end: Alignment
            //                     .centerLeft, // End towards the left
            //                 colors: [
            //                   Color(0xFF362A84), // Hex color #362A84
            //                   Color(0xFF84D761), // Hex color #84D761
            //                 ],
            //                 stops: [
            //                   0.0023,
            //                   0.942,
            //                 ], // Percentage stops 0.23% and 94.2%
            //               ),
            //               borderRadius: BorderRadius.circular(15.0),
            //             ),
            //             child: Container(
            //               width: 150,
            //               height: 50,
            //               alignment: Alignment.center,
            //               child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Text(
            //                   "Upload Image",
            //                   style: TextStyle(
            //                     fontSize: 20,
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.w700,
            //                   ),
            //                   maxLines: 2,
            //                   textAlign: TextAlign.left,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 10),
            _buildDropdownSection(
              title: "Select A Crop:",
              dropListModel: dropListModel1,
              selectedOption: optionItemSelected,
              onSelect: (data) {
                setState(() {
                  optionItemSelected = data;
                });
              },
            ),
            // const SizedBox(height: 10),
            _buildDropdownSection(
              title: "Select A Fertilizer:",
              dropListModel: dropListModel2,
              selectedOption: optionItemSelected2,
              onSelect: (data) {
                setState(() {
                  optionItemSelected2 = data;
                });
              },
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: _uploadImage,
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
                        "Upload Image",
                        style: TextStyle(
                          fontSize: 20,
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
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownSection({
    required String title,
    required DropListModel dropListModel,
    required OptionItem selectedOption,
    required Function(OptionItem) onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        SelectDropRadio(
          defaultText: selectedOption,
          dropListModel: dropListModel,
          showIcon: false,
          showBorder: true,
          enable: true,
          containerPadding: const EdgeInsets.all(10),
          onOptionListSelected: onSelect,
        ),
      ],
    );
  }

  Widget _buildResultSection({required String label, required String result}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          height: 40,
          width: 150,
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                result,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
