import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/constants/AppConstants.dart';
import 'package:krishi_customer_app/views/consumer%20ui/cartscreen.dart';
import 'package:krishi_customer_app/views/consumer%20ui/profile.dart';
import 'package:krishi_customer_app/views/consumer%20ui/signupscreen%201.dart';
import 'package:krishi_customer_app/views/farmerui/menubar.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class Uploadpage extends StatefulWidget {
  const Uploadpage();

  @override
  State<Uploadpage> createState() => _UploadpageState();
}

class _UploadpageState extends State<Uploadpage> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    final uri =
        Uri.parse('YOUR_SERVER_UPLOAD_URL'); // Replace with your server URL
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', _image!.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image');
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
    var qty = 1;
    String? _selectedValue; // Variable to hold the selected value
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,

        title: const Text('AI Quality Grading',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); // Navigate back
              },
            );
          },
        ),
        //           actions: [
        //   IconButton(
        //     icon: Icon(Icons.shopping_cart),
        //     onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => CartListScreen(),
        //       ),
        //     );
        //   },
        //   ),
        //   IconButton(
        //     icon: Icon(Icons.person),
        //     onPressed: () {
        //             Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => ProfileScreenmain(),
        //       ),
        //     );
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align children to the left
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
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: Center(
                            child: Text('No image selected.'),
                          )),
                    ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.spaceBetween ,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(
                            74, 230, 50, 0.961), // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30.0), // Rounded edges
                          side: BorderSide(
                              color: Color.fromRGBO(74, 230, 50, 0.961),
                              width: 2.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15), // Button size
                      ),
                      onPressed: _pickImage,
                      child: Text(
                        "Pick Image",
                        style: TextStyle(color: Colors.black), // Text color
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(
                            74, 230, 50, 0.961), // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30.0), // Rounded edges
                          side: BorderSide(
                              color: Color.fromRGBO(74, 230, 50, 0.961),
                              width: 2.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15), // Button size
                      ),
                      onPressed: _uploadImage,
                      child: Text(
                        "Upload Image",
                        style: TextStyle(color: Colors.black), // Text color
                      ),
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
                height: 30,
              ),
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
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //          width: double.infinity, // Set width here
              //         height: 60, // Set height here
              //         decoration: BoxDecoration(

              //         ),
              //     child: DropdownButton<String>(
              //           value: _selectedValue,
              //           isExpanded: true,
              //           hint: Text('Select an option'),
              //           onChanged: (String? newValue) {
              //             setState(() {
              //               _selectedValue = newValue;
              //             });
              //           },
              //           items: <String>['Option 1', 'Option 2', 'Option 3']
              //               .map<DropdownMenuItem<String>>((String value) {
              //             return DropdownMenuItem<String>(
              //               value: value,
              //               child: Text(value),
              //             );
              //           }).toList(),
              //         ),
              //   ),
              // ),
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
                height: 30,
              ),

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
                    child:Center(child: Text("A",
                    style: TextStyle(
                      fontSize: 40
                    ),))
                  )
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
                    child:Center(child: Text("Kurfi Chandramukhi Potatoes",
                    style: TextStyle(
                      fontSize: 16
                    ),))
                    ),
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
                    "The Chandramukhi potato is a prominent variety of potato known for its excellent quality and adaptability. It is widely cultivated in India, particularly in the northern regions, due to its high yield and resistance to various diseases. The tubers of the Chandramukhi potato are medium to large in size, with a smooth, light brown skin and a creamy white flesh that is perfect for a variety of culinary uses. This variety is particularly favored for its good storage properties, making it a reliable choice for both farmers and consumers. Its versatility in cooking, from boiling and frying to baking, makes the Chandramukhi potato a staple in many households and an essential ingredient in numerous traditional Indian dishes.",
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
            ],
          ),
        ),
      ),
    );
  }
}
