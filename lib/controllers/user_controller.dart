import 'package:get/get.dart';

class UserController extends GetxController {
  // Reactive variable for user info
  var userInfo = Rx<Map<String, dynamic>>({}).obs;

  // Method to update user info
  void updateUser(Map<String, dynamic> newUserInfo) {
    userInfo.value = newUserInfo as Rx<Map<String, dynamic>>;
  }
}
