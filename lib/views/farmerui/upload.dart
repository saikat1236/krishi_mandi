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
    OptionItem(id: "1", title: "Crop 1"),
    OptionItem(id: "2", title: "Crop 2"),
    OptionItem(id: "3", title: "Crop 3"),
  ]);

  final DropListModel dropListModel2 = DropListModel([
    OptionItem(id: "1", title: "Fertilizer 1"),
    OptionItem(id: "2", title: "Fertilizer 2"),
    OptionItem(id: "3", title: "Fertilizer 3"),
  ]);

  OptionItem optionItemSelected = OptionItem(title: "Select Crop");
  OptionItem optionItemSelected2 = OptionItem(title: "Select Fertilizer");

  @override
  void initState() {
    super.initState();
    _loadImageFromAssets();
  }

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
      final byteData = await rootBundle.load('assets/pana.png');
      final file = File('${(await getTemporaryDirectory()).path}/pana.png');
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
        setState(() {
          _response = responseData;
          print(_response);
        });
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'AI Quality Grading',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _image != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      child: Image.file(_image!, fit: BoxFit.cover),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      child: Center(
                        child: Image.asset(
                          "assets/fileupload.png",
                          height: 300,
                          width: 600,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(74, 230, 50, 0.961),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(
                            color: Color.fromRGBO(74, 230, 50, 0.961),
                            width: 2.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                    ),
                    onPressed: _pickImage,
                    child: const Text(
                      "Pick Image",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(74, 230, 50, 0.961),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(
                            color: Color.fromRGBO(74, 230, 50, 0.961),
                            width: 2.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                    ),
                    onPressed: _uploadImage,
                    child: const Text(
                      "Upload Image",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
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
            const SizedBox(height: 30),
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
            const SizedBox(height: 30),
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
              result: _response ?? 'N/A',
            ),
            const SizedBox(height: 30),
            _buildResultSection(
              label: "Variety:",
              result: "Kurfi Chandramukhi Potatoes",
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("About",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:FontWeight.w500
              
                  ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "The Chandramukhi potato is a prominent variety of potato known for its excellent quality and adaptability. It is widely cultivated in India, particularly in the northern regions, due to its high yield and resistance to various diseases. The tubers of the Chandramukhi potato are medium to large in size, with a smooth, light brown skin and a creamy white flesh that is perfect for a variety of culinary uses. This variety is particularly favored for its good storage properties, making it a reliable choice for both farmers and consumers. Its versatility in cooking, from boiling and frying to baking, makes the Chandramukhi potato a staple in many households and an essential ingredient in numerous traditional Indian dishes."
                 , style: TextStyle(
                  
                  ),
                  )
                ],
              ),
            )
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
          height: 60,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
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
