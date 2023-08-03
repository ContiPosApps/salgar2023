class Estampado {
  int id;
  String img;

  Estampado({required this.id, required this.img});

  Map<String, dynamic> toMap() {
    return {'id': id, 'img': img};
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Estampado && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
