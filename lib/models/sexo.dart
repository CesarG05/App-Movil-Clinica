class Sexo {
  final int id;
  final String tipoSexo;

  Sexo({
    required this.id,
    required this.tipoSexo,
  });

  factory Sexo.fromJson(Map<String, dynamic> json) {
    return Sexo(
      id: json['id'] ?? 0,
      tipoSexo: json['tipoSexo'] ?? '',
    );
  }
}
