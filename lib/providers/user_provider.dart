import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String? _userName;
  String? _profileImagePath; // 🔹 Profile photo ka local path

  String get userName => _userName ?? "";
  String? get profileImagePath => _profileImagePath;

  // 🔹 Constructor — jab provider create hota hai to data load kar le
  UserProvider() {
    _loadUserData();
  }

  // 🔹 Load user name & profile image path from SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString('user_name');
    _profileImagePath = prefs.getString('profile_image');
    notifyListeners();
  }

  // 🔹 Save name to SharedPreferences
  Future<void> _saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
  }

  // 🔹 Save image path to SharedPreferences
  Future<void> _saveProfileImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', path);
  }

  // 🔹 Set user name (for first time or update)
  void setUserName(String name) {
    _userName = name;
    _saveUserName(name);
    notifyListeners();
  }

  void updateUserName(String newName) {
    _userName = newName;
    _saveUserName(newName);
    notifyListeners();
  }

  // 🔹 Set or update profile image (after cropping)
  void setProfileImage(String path) {
    _profileImagePath = path;
    _saveProfileImage(path);
    notifyListeners();
  }

  // 🔹 Optional: Clear all user data (logout etc.)
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_name');
    await prefs.remove('profile_image');
    _userName = null;
    _profileImagePath = null;
    notifyListeners();
  }
}
