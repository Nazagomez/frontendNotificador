import 'package:flutter/material.dart';
import '../services/authServices.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners(); // Le dice a la interfaz que algo cambió (loading)

    final result = await _authService.login(email, password);

    _isLoading = false;
    notifyListeners(); // Termina el loading

    return result; // true si fue exitoso, false si falló
  }
}
