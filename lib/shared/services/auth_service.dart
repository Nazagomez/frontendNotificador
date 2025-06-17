import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notificador/core/constants/api_constants.dart';
import 'package:notificador/features/profile/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  static final String authUrl = '${ApiConstants.baseUrl}/auth';

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;
  bool get isAdmin => isLoggedIn && (_currentUser?.isAdmin ?? false);

  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$authUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _currentUser = UserModel.fromJson(data);

      try {
        await _prefs.setString('user', jsonEncode(data));
      } catch (e) {
        debugPrint('Error saving user data: $e');
      }

      notifyListeners();
    } else {
      throw Exception('Login failed');
    }
  }

  Future<void> loadUser() async {
    final userString = await _prefs.getString('user');

    if (userString != null) {
      final data = jsonDecode(userString);
      _currentUser = UserModel.fromJson(data);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    await _prefs.remove('user');
    notifyListeners();
  }
}
