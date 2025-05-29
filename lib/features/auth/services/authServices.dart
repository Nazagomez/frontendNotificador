import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = 'http://10.0.2.2:3000/api';

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/inicio-sesion');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        final user = data.firstWhere(
          (u) => u['Correo'] == email && u['Contrasena'] == password,
          orElse: () => null,
        );

        return user != null;
      } else {
        return false;
      }
    } catch (e) {
      print('Error al intentar loguear: $e');
      return false;
    }
  }
}
