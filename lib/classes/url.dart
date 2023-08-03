class Url {
  int id;
  int? idTipo;
  String url_es;
  String url_en;
  String url_fr;

  // ignore: non_constant_identifier_names
  Url({required this.id, this.idTipo, required this.url_es, required this.url_en, required this.url_fr});

  Map<String, dynamic> toMap(){
    return {'id':id, 'idTipo': idTipo, 'url_es': url_es, 'url_en': url_en, 'url_fr': url_fr};
  }
}
