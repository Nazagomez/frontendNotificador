class AuthService {
  // Simulación de login (mock)
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Simula red
    return email == 'admin@una.cr' && password == '1234';
  }
}
