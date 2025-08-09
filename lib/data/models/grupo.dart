class Grupo {
  // Atributos
  String sId;
  String sNombre;
  String sAdminUid;
  int iObjetivoLitros;
  int iStatusLitros;
  List<String> lBebedores;

  // Constructor
  Grupo({
    required this.sId,
    required this.sNombre,
    required this.sAdminUid,
    required this.iObjetivoLitros,
    required this.iStatusLitros,
    required this.lBebedores,
  });

  Map<String, dynamic> toMap() {
    return {
      'sId': sId,
      'sNombre': sNombre,
      'sAdminUid': sAdminUid,
      'iObjetivoLitros': iObjetivoLitros,
      'iStatusLitros': iStatusLitros,
      'lBebedores': lBebedores,
    };
  }

  factory Grupo.fromMap(Map<String, dynamic> mGrupo) {
    return Grupo(
      sId: mGrupo['sId'],
      sNombre: mGrupo['sNombre'],
      sAdminUid: mGrupo['sAdminUid'],
      iObjetivoLitros: mGrupo['iObjetivoLitros'],
      iStatusLitros: mGrupo['iStatusLitros'],
      lBebedores: List<String>.from(mGrupo['lBebedores']),
    );
  }
}
