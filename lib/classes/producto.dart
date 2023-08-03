class Producto{
  int id;
  int idTipo;
  int idsubTipo;
  int estampado;
  int posicion;
  int todos;
  String img;

  Producto({required this.id, required this.idTipo, required this.idsubTipo, required this.estampado, required this.posicion, required this.todos, required this.img});

  Map<String, dynamic> toMap(){
    return {'id': id, 'idTipo': idTipo, 'idsubTipo': idsubTipo, 'posicion': posicion, 'todos':todos, 'estampado': estampado, 'img': img};
  }
}