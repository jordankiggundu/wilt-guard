import 'package:flutter/foundation.dart';
import 'package:wiltguard/models/user_model.dart';

class UserController extends ChangeNotifier {
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  void setCurrentUser(UserModel? user) {
    _currentUser = user;
    notifyListeners(); // Notify listeners about the change
  }
}