class Usuario {
  final String sId;
  String sEmail;
  String sNick;
  String sFotoDePerfilUrl;
  int iTotalLitros;
  int iTotalTragos;
  List<String> lGrupos;

  Usuario({
    required this.sId,
    required this.sEmail,
    required this.sNick,
    required this.sFotoDePerfilUrl,
    required this.iTotalLitros,
    required this.iTotalTragos,
    required this.lGrupos,
  });

  // Con este método, Firebase puede almacenar objetos de Usuario en BD
  Map<String, dynamic> toMap() {
    return {
      'sId': sId,
      'sEmail': sEmail,
      'sNick': sNick,
      'sFotoDePerfilUrl': sFotoDePerfilUrl,
      'iTotalLitros': iTotalLitros,
      'iTotalTragos': iTotalTragos,
      'lGrupos': lGrupos,
    };
  }

  // Coge un mapa (como el que devuelve doc.data()) y crea un objeto Usuario
  factory Usuario.fromMap(Map<String, dynamic> mUsuario) {
    return Usuario(
      sId: mUsuario['sId'],
      sEmail: mUsuario['sEmail'],
      sNick: mUsuario['sNick'],
      sFotoDePerfilUrl: mUsuario['sFotoDePerfilUrl'],
      iTotalLitros: mUsuario['iTotalLitros'] as int,
      iTotalTragos: mUsuario['iTotalTragos'] as int,
      lGrupos: List<String>.from(mUsuario['lGrupos']),
    );
  }
}
