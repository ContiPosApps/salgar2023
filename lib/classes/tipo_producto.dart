class TipoProducto{
  int id;
  int idGama;
  String nombre;
  String img;
  int url;

  TipoProducto({required this.id, required this.idGama, required this.nombre, required this.img, required this.url});

  Map<String, dynamic> toMap(){
    return {'id': id, 'idGama': idGama, 'nombre': nombre, 'img': img, 'url': url};
  }
}