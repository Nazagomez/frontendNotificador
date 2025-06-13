import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notificador/core/constants/api_constants.dart';
import 'package:notificador/features/profile/models/user_model.dart';

class AuthService extends ChangeNotifier {
  static final String authUrl = '${ApiConstants.baseUrl}/auth';

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;
  bool get isAdmin => isLoggedIn && (_currentUser?.isAdmin ?? false);

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$authUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _currentUser = UserModel.fromJson(data);
      notifyListeners();
    } else {
      throw Exception('Login failed');
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
