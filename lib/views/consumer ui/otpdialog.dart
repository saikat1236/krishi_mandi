import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_customer_app/constants/AppConstants.dart';
import 'package:krishi_customer_app/views/farmerui/loginscreen.dart';
import '../../controller/customer_apis/authcontroller.dart';

class OTPDialog extends StatefulWidget {
  final String mobileNumber;
  final VoidCallback onClose;

  OTPDialog({required this.onClose, required this.mobileNumber});

  @override
  _OTPDialogState createState() => _OTPDialogState();
}

class _OTPDialogState extends State<OTPDialog> {
  final AuthController controller = Get.put(AuthController());
  List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((focusNode) => focusNode.dispose());
    super.dispose();
  }

  void _handleInputChange(String value, int index) {
    if (value.isNotEmpty) {
      if (index < _focusNodes.length - 1) {
        _focusNodes[index].unfocus();
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        _focusNodes[index].unfocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 193, 239, 194),
      title: Text(
        'OTP Verification',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Enter the OTP sent to +91 ${widget.mobileNumber}',
            style: TextStyle(fontSize: 10),
          ),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              6,
              (index) => Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => _handleInputChange(value, index),
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                  ),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle Resend OTP
            },
            child: Text("Didn't Receive? Resend OTP"),
          ),
        ],
      ),
      actions: <Widget>[
        Obx(() => Center(
              child: GradientButton(
                label: "Verify",
                widget: !controller.isLoading.value
                    ? Text(
                        "Verify",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )
                    : CircularProgressIndicator(color: Colors.white),
                onPressed: () {
                  String otp =
                      _controllers.map((controller) => controller.text).join();
                  AppContants.isfarmer?
                  framercontroller.verifyOtp():
                  controller.verifyOtp(widget.mobileNumber, otp);
                },
              ),
            )),
      ],
    );
  }
}

class GradientButton extends StatelessWidget {
  final String label;
  final Widget widget;
  final VoidCallback onPressed;

  const GradientButton({
    Key? key,
    required this.label,
    required this.widget,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff52DB22), Color(0xff2C7512)], // White to dark green
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        child: widget,
      ),
    );
  }
}
