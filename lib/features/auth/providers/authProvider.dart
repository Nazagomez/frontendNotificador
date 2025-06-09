import 'package:flutter/material.dart';
import '../services/authServices.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _token;
  String? get token => _token;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final result = await _authService.login(email, password);
    if (result) {
      _token = await _authService.getToken();
    }

    _isLoading = false;
    notifyListeners();

    return result;
  }

  Future<void> logout() async {
    await _authService.logout();
    _token = null;
    notifyListeners();
  }
}