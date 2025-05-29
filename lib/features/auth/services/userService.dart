/*port 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final int id;
  final String nombre;
  final String correo;
  final String rol;

  User({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.rol,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.parse(json['id'].toString()),
      nombre: json['nombre'],
      correo: json['correo'],
      rol: json['rol'],
    );
  }
}

class UserService {
  final String baseUrl = 'https://683522c1cd78db2058c05ad2.mockapi.io';

  Future<List<User>> fetchUsuarios() async {
    final url = Uri.parse('$baseUrl/usuarios');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar usuarios');
    }
  }

  Future<User> fetchUsuarioPorId(String id) async {
    final url = Uri.parse('$baseUrl/usuarios/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Usuario no encontrado');
    }
  }
}
*/