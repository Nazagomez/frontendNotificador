class EventModel {
  final int ID_Usuario;
  final String Titulo;
  final String Descripcion;
  final String Fecha;
  final String Hora;
  final String Ubicacion;
  final String Categoria;
  final String Estado;
  final String Imagen;

  EventModel({
    required this.ID_Usuario,
    required this.Titulo,
    required this.Descripcion,
    required this.Fecha,
    required this.Hora,
    required this.Ubicacion,
    required this.Categoria,
    required this.Estado,
    required this.Imagen,
  });

  Map<String, dynamic> toJson() {
    return {
      'ID_Usuario': ID_Usuario,
      'Titulo': Titulo,
      'Descripcion': Descripcion,
      'Fecha': Fecha,
      'Hora': Hora,
      'Ubicacion': Ubicacion,
      'Categoria': Categoria,
      'Estado': Estado,
      'Imagen': Imagen,
    };
  }
}