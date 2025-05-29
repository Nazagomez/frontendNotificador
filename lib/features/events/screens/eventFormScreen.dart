import 'package:flutter/material.dart';
import '../services/eventUploadService.dart';
import '../models/eventModelAdd.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EventFormScreen extends StatefulWidget {
  const EventFormScreen({super.key});

  @override
  State<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final EventUploadService _uploadService = EventUploadService();

  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  final TextEditingController horaController = TextEditingController();
  final TextEditingController ubicacionController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();

  File? _selectedImage;
  String? _uploadedImageUrl;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      final imageUrl = await _uploadService.uploadImage(_selectedImage!);
      if (imageUrl != null) {
        setState(() => _uploadedImageUrl = imageUrl);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Imagen subida correctamente')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al subir la imagen')),
        );
      }
    }
  }

  Future<void> enviarEvento() async {
    final evento = EventModel(
      ID_Usuario: 5,
      Titulo: tituloController.text,
      Descripcion: descripcionController.text,
      Fecha: fechaController.text,
      Hora: horaController.text,
      Ubicacion: ubicacionController.text,
      Categoria: categoriaController.text,
      Estado: estadoController.text,
      Imagen: _uploadedImageUrl ?? '',
    );

    final success = await _uploadService.createEvent(evento);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Evento creado correctamente')),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al crear evento')),
      );
    }
  }

  @override
  void dispose() {
    tituloController.dispose();
    descripcionController.dispose();
    fechaController.dispose();
    horaController.dispose();
    ubicacionController.dispose();
    categoriaController.dispose();
    estadoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text('Nuevo Evento', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.indigo.shade100),
                  ),
                  child: _selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            _selectedImage!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Center(
                          child: Icon(Icons.add_a_photo, size: 48, color: Colors.indigo),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              buildTextField(controller: tituloController, label: 'Título del evento'),
              buildTextField(controller: descripcionController, label: 'Descripción'),
              Row(
                children: [
                  Expanded(child: buildTextField(controller: fechaController, label: 'Fecha (YYYY-MM-DD)')),
                  const SizedBox(width: 12),
                  Expanded(child: buildTextField(controller: horaController, label: 'Hora (HH:MM:SS)')),
                ],
              ),
              buildTextField(controller: ubicacionController, label: 'Ubicación'),
              buildTextField(controller: categoriaController, label: 'Categoría'),
              buildTextField(controller: estadoController, label: 'Estado'),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      enviarEvento();
                    }
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Guardar evento'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({required TextEditingController controller, required String label}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black87),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.indigo),
          ),
        ),
        validator: (value) => value == null || value.isEmpty ? 'Este campo es obligatorio' : null,
      ),
    );
  }
}