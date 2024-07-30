import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _salesNotifications = true;
  bool _newArrivalsNotifications = false;
  bool _deliveryStatusNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Adding Shipping Address',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Settings',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text('Personal Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildTextField(label: 'Email', initialValue: 'user@example.com'),
            _buildTextField(label: 'Date of Birth', initialValue: '12/12/1989'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Address',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    // Add change address functionality
                  },
                  child: const Text('Change',
                      style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
            _buildTextField(
                label: 'Password', initialValue: '****************'),
            const SizedBox(height: 20),
            const Text('Notifications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildNotificationSwitch(
              label: 'Sales',
              value: _salesNotifications,
              onChanged: (bool value) {
                setState(() {
                  _salesNotifications = value;
                });
              },
            ),
            _buildNotificationSwitch(
              label: 'New arrivals',
              value: _newArrivalsNotifications,
              onChanged: (bool value) {
                setState(() {
                  _newArrivalsNotifications = value;
                });
              },
            ),
            _buildNotificationSwitch(
              label: 'Delivery status changes',
              value: _deliveryStatusNotifications,
              onChanged: (bool value) {
                setState(() {
                  _deliveryStatusNotifications = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label, required String initialValue}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        readOnly: true,
      ),
    );
  }

  Widget _buildNotificationSwitch(
      {required String label,
      required bool value,
      required ValueChanged<bool> onChanged}) {
    return SwitchListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.green,
    );
  }
}
