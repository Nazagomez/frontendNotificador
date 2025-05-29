import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/userModel.dart';

class UserService {
  final String baseUrl = 'http://10.0.2.2:3000/api/usuarios';

  Future<List<UserModel>> fetchUsuarios() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar usuarios');
    }
  }
}