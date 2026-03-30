import 'package:flutter/material.dart';

enum UserRole { guard, manager }

class AuthState extends ChangeNotifier {
  UserRole _role = UserRole.guard;
  String _userName = "James Carter";
  String _siteName = "Site A - Main Gate";

  UserRole get role => _role;
  String get userName => _userName;
  String get siteName => _siteName;

  void login(UserRole role, String userName) {
    _role = role;
    _userName = userName;
    if (role == UserRole.manager) {
      _siteName = "Regional Headquarters";
    } else {
      _siteName = "Site A - Main Gate";
    }
    notifyListeners();
  }

  void logout() {
    _role = UserRole.guard;
    notifyListeners();
  }
}
