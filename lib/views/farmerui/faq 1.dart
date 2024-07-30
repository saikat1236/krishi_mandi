import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/krishi_mandi.png', // Add your image asset here
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.question_answer, color: Colors.green, size: 30),
                  SizedBox(width: 10),
                  Text(
                    'FAQ Question',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Frequently Asked Questions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ExpansionTile(
                title: Text(
                  'Lorem Ipsum is simply dummy text of the prin....?',
                  style: TextStyle(color: Colors.green),
                ),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              Divider(),
              ExpansionTile(
                title: Text(
                  'Lorem Ipsum is simply dummy text of the prin....?',
                  style: TextStyle(color: Colors.green),
                ),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              Divider(),
              ExpansionTile(
                title: Text(
                  'Lorem Ipsum is simply dummy text of the prin....?',
                  style: TextStyle(color: Colors.green),
                ),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              Divider(),
              ExpansionTile(
                title: Text(
                  'Lorem Ipsum is simply dummy text of the prin....?',
                  style: TextStyle(color: Colors.green),
                ),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
