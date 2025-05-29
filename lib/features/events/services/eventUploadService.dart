import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import '../models/eventModelAdd.dart';

class EventUploadService {
  final String baseUrl = 'http://10.0.2.2:3000/api';

  Future<String?> uploadImage(File imageFile) async {
    final uri = Uri.parse('$baseUrl/eventos/upload-image');
    final request = http.MultipartRequest('POST', uri);

    final mimeType = lookupMimeType(imageFile.path)!.split('/');
    request.files.add(
      await http.MultipartFile.fromPath(
        'imagen',
        imageFile.path,
        contentType: MediaType(mimeType[0], mimeType[1]),
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['url'];
    } else {
      return null;
    }
  }

  Future<bool> createEvent(EventModel event) async {
    final uri = Uri.parse('$baseUrl/eventos');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(event.toJson()),
    );
    return response.statusCode == 201 || response.statusCode == 200;
  }
}
