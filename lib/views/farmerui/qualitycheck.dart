import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:dropdown_model_list/drop_down/select_drop_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/AppConstants.dart';

class Uploadpage2 extends StatefulWidget {
  const Uploadpage2();

  @override
  State<Uploadpage2> createState() => _UploadpageState();
}

class _UploadpageState extends State<Uploadpage2> {
  File? _image;
  String? _grade;
  String? _type;
  String? _freshness;

  @override
  void initState() {
    super.initState();
    _loadImageFromAssets();
  }

  final ImagePicker _picker = ImagePicker();

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
      final byteData = await rootBundle.load('assets/potato.png');
      final file = File('${(await getTemporaryDirectory()).path}/potato.png');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      setState(() {
        _image = file;
      });
    } catch (e) {
      setState(() {
        _grade = 'Error loading image: $e';
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    try {
      final uri =
          Uri.parse('${AppContants.baseUrl}/common/predict-product');
      final request = http.MultipartRequest('POST', uri);
      request.files
          .add(await http.MultipartFile.fromPath('files', _image!.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final decodedResponse = json.decode(responseData);
        final payload = json.decode(decodedResponse['payload']['response']);
        setState(() {
          _grade = payload['grade'];
          _type = payload['type'];
          _freshness = payload['freshness'];
        });
      } else {
        final responseData = await response.stream.bytesToString();
        setState(() {
          _grade =
              'Failed to upload image. Status code: ${response.statusCode}. Response: $responseData';
        });
      }
    } catch (e) {
      setState(() {
        _grade = 'Failed to upload image. Error: $e';
      });
    }
  }

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
  OptionItem optionItemSelected = OptionItem(title: "Select Crop");
  OptionItem optionItemSelected2 = OptionItem(title: "Select Fertilizer");

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('AI Quality Grading',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _image != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: double.infinity,
                          height: 300,
                          child: Image.file(_image!,
                              height: 200, width: 200, fit: BoxFit.cover)),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(),
                        child: Center(
                          child: Image.asset(
                            "assets/fileupload.png",
                            height: 300,
                            width: 600,
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(74, 230, 50, 0.961),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(
                              color: Color.fromRGBO(74, 230, 50, 0.961),
                              width: 2.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      onPressed: _pickImage,
                      child: Text("Pick Image",
                          style: TextStyle(color: Colors.black)),
                    ),
                    Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(74, 230, 50, 0.961),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(
                              color: Color.fromRGBO(74, 230, 50, 0.961),
                              width: 2.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      onPressed: _uploadImage,
                      child: Text("Upload Image",
                          style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Container(
              //       width: double.infinity,
              //       height: 300,
              //       decoration: BoxDecoration(
              //           color: Colors.grey,
              //       ),
              //       // here the uploaded image will be shown
              //       ),
              // ),
              SizedBox(
                height: 20,
              ),

              // in column

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
              // SelectDropRadio(
              //   defaultText: optionItemSelected,
              //   dropListModel: dropListModel1,
              //   showIcon: false,
              //   showBorder: true,
              //   paddingTop: 0,
              //   enable: true,
              //   submitText: "OK",
              //   colorSubmitButton: Colors.amber,
              //   selectedRadioColor: Colors.amber,
              //   suffixIcon: Icons.arrow_drop_down,
              //   containerPadding: const EdgeInsets.all(10),
              //   icon: const Icon(Icons.person, color: Colors.black),
              //   onOptionListSelected: (data) {
              //     print(data.title);
              //     setState(() {});
              //   },
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     "Select A Fertilizer:",
              //     style: TextStyle(
              //       fontSize: 20,
              //       color: Colors.black,
              //       fontWeight: FontWeight.w500,
              //     ),
              //     maxLines: 2,
              //     textAlign: TextAlign.left,
              //   ),
              // ),
              // SelectDropRadio(
              //   defaultText: optionItemSelected2,
              //   dropListModel: dropListModel2,
              //   showIcon: false,
              //   showBorder: true,
              //   paddingTop: 0,
              //   enable: true,
              //   submitText: "OK",
              //   colorSubmitButton: Colors.amber,
              //   selectedRadioColor: Colors.amber,
              //   suffixIcon: Icons.arrow_drop_down,
              //   containerPadding: const EdgeInsets.all(10),
              //   icon: const Icon(Icons.person, color: Colors.black),
              //   onOptionListSelected: (data) {
              //     print(data.title);
              //     setState(() {});
              //   },
              // ),

              Row(
                children: [
                  Container(
                    width: 200,
                    child:Column(
                      children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Select A crop:",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SelectDropRadio(
                      defaultText: optionItemSelected,
                      dropListModel: dropListModel1,
                      showIcon: false,
                      showBorder: true,
                      paddingTop: 0,
                      enable: true,
                      submitText: "OK",
                      colorSubmitButton: Colors.amber,
                      selectedRadioColor: Colors.amber,
                      suffixIcon: Icons.arrow_drop_down,
                      containerPadding: const EdgeInsets.all(10),
                      icon: const Icon(Icons.person, color: Colors.black),
                      onOptionListSelected: (data) {
                        print(data.title);
                        setState(() {});
                      },
                    ),
                ])),
                                    Container(
                    width: 200,
                    child:Column(
                      children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Select A Fertilizer:",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SelectDropRadio(
                      defaultText: optionItemSelected2,
                      dropListModel: dropListModel2,
                      showIcon: false,
                      showBorder: true,
                      paddingTop: 0,
                      enable: true,
                      submitText: "OK",
                      colorSubmitButton: Colors.amber,
                      selectedRadioColor: Colors.amber,
                      suffixIcon: Icons.arrow_drop_down,
                      containerPadding: const EdgeInsets.all(10),
                      icon: const Icon(Icons.person, color: Colors.black),
                      onOptionListSelected: (data) {
                        print(data.title);
                        setState(() {});
                      },
                    ),
                ])),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Result",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              if (_grade != null && _type != null && _freshness != null)
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Quality Grade:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                        height: 60,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Center(
                            child: Text(
                          '$_grade',
                          style: TextStyle(fontSize: 40),
                        )))
                  ],
                ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Variety:",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    child: Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Center(
                            child: Text(
                          "$_type",
                          style: TextStyle(fontSize: 16),
                        ))),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "About:",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                // decoration: BoxDecoration(color: Colors.orange[50]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$_freshness',
                    // "The Chandramukhi potato is a prominent variety of potato known for its excellent quality and adaptability. It is widely cultivated in India, particularly in the northern regions, due to its high yield and resistance to various diseases. The tubers of the Chandramukhi potato are medium to large in size, with a smooth, light brown skin and a creamy white flesh that is perfect for a variety of culinary uses. This variety is particularly favored for its good storage properties, making it a reliable choice for both farmers and consumers. Its versatility in cooking, from boiling and frying to baking, makes the Chandramukhi potato a staple in many households and an essential ingredient in numerous traditional Indian dishes.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    // maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                ),
              )
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Grade: $_grade",
              //         style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
              //       ),
              //       SizedBox(height: 10),
              //       Text(
              //         "Type: $_type",
              //         style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
              //       ),
              //       SizedBox(height: 10),
              //       Text(
              //         "Freshness: $_freshness",
              //         style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
              //       ),
              //     ],
              //   ),
              // ),
              // Rest of your UI components...
            ],
          ),
        ),
      ),
    );
  }
}
