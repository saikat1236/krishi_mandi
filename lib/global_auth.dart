import 'package:get/get.dart';

class GlobalController extends GetxController {
  var authToken = ''.obs;

  void setAuthToken(String token) {
    authToken.value = token;
  }

  String getAuthToken() {
    return authToken.value;
  }
}
