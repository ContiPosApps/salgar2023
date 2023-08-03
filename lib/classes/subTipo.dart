class subTipo {
  final int id;
  final int idTipo;
  final String nombre;
  final String img;
  final int url;

  subTipo({
    required this.id,
    required this.idTipo,
    required this.nombre,
    required this.img,
    required this.url,
  });

 
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idTipo': idTipo,
      'nombre': nombre,
      'img': img,
      'url':url,
    };
  }
}
