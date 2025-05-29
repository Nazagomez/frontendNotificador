import 'package:flutter/material.dart';

class EventFormScreen extends StatefulWidget {
  const EventFormScreen({super.key});

  @override
  State<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  final TextEditingController horaController = TextEditingController();
  final TextEditingController ubicacionController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();

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
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: const Text(
          'Crear nuevo evento',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.image, size: 80, color: Colors.indigo),
                    const SizedBox(height: 8),
                    const Text('Agregue una imagen', style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 24),

                    buildTextField(controller: tituloController, label: 'Título'),
                    buildTextField(controller: descripcionController, label: 'Descripción'),
                    buildTextField(controller: fechaController, label: 'Fecha (MM/DD/AAAA)'),
                    buildTextField(controller: horaController, label: 'Hora (HH:MM)'),
                    buildTextField(controller: ubicacionController, label: 'Ubicación'),
                    buildTextField(controller: categoriaController, label: 'Categoría'),
                    buildTextField(controller: estadoController, label: 'Estado'),

                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Aquí irá la lógica para enviar el evento
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Add event'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({required TextEditingController controller, required String label}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) => value == null || value.isEmpty ? 'Este campo es obligatorio' : null,
      ),
    );
  }
}
