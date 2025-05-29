class EventModel {
  final int id;
  final String titulo;
  final String fecha;
  final String lugar;
  final String categoria;
  final int asistentes;
  final String imagen;


  EventModel({
    required this.id,
    required this.titulo,
    required this.fecha,
    required this.lugar,
    required this.categoria,
    required this.asistentes,
    required this.imagen,

  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['ID_Evento'],
      titulo: json['Titulo'],
      fecha: json['Fecha'],
      lugar: json['Ubicacion'],
      categoria: json['Categoria'] ?? '',
      asistentes: json['Asistentes'] ?? 0,
      imagen: json['Imagen'] ?? '',
    );
  }
}
