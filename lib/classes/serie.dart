class Serie{
  int id;
  int idCatalogo;
  String nombre;
  String img;
  String title_es;
  String title_en;
  String title_fr;
  String url_es;
  String url_en;
  String url_fr;

  Serie({required this.id, required this.idCatalogo, required this.nombre, required this.img, required this.title_es, required this.title_en, required this.title_fr, required this.url_es, required this.url_en, required this.url_fr});

  Map<String, dynamic> toMap(){
    return {'id': id, 'idCatalogo': idCatalogo, 'nombre': nombre, 'img': img, 'title_es': title_es, 'title_en': title_en, 'title_fr': title_fr, 'url_es': url_es, 'url_en': url_en, 'url_fr': url_fr};
  }
}