class Consumicion {
  // Atributos
  String sId;
  String sIdUsuario;
  DateTime dtFechaConsumicion;
  TipoConsumicion eTipo;
  int iCantidad;
  double dLitrosConsumicion;

  Consumicion(
      {required this.sId,
      required this.sIdUsuario,
      required this.dtFechaConsumicion,
      required this.eTipo,
      required this.iCantidad})
      : dLitrosConsumicion = eTipo.litros *
            iCantidad; // Calculo automáticamente los litros en base al enum (tipo) y la cantidad de consumiciones

  Map<String, dynamic> toMap() {
    return {
      'sId': sId,
      'sIdUsuario': sIdUsuario,
      'dtFechaConsumicion': dtFechaConsumicion,
      'eTipo': eTipo.name,
      'iCantidad': iCantidad,
      'dLitrosConsumicion': dLitrosConsumicion
    };
  }

  factory Consumicion.fromMap(Map<String, dynamic> mConsumicion) {
    return Consumicion(
        sId: mConsumicion['sId'],
        sIdUsuario: mConsumicion['sIdUsuario'],
        dtFechaConsumicion: DateTime.parse(mConsumicion['dtFechaConsumicion']),
        eTipo: TipoConsumicion.values
            .firstWhere((e) => e.name == mConsumicion['eTipo']),
        iCantidad: mConsumicion['iCantidad']);
  }
}

// Genero un enum para los tipos de consumición
enum TipoConsumicion {
  canya,
  botellin,
  tercio,
  lata,
  yonkilata,
  jarrita,
  jarra,
  pinta,
  cachi,
}

// Esto mola más en C#, porque arriba podría haber asignado valores directamente, pero aquí, utilizo extension
extension TipoConsumicionExtension on TipoConsumicion {
  double get litros {
    switch (this) {
      case TipoConsumicion.canya:
        return 0.2;
      case TipoConsumicion.botellin:
        return 0.25;
      case TipoConsumicion.tercio:
        return 0.33;
      case TipoConsumicion.lata:
        return 0.33;
      case TipoConsumicion.yonkilata:
        return 0.5;
      case TipoConsumicion.jarrita:
        return 0.25;
      case TipoConsumicion.jarra:
        return 0.5;
      case TipoConsumicion.pinta:
        return 0.5;
      case TipoConsumicion.cachi:
        return 1;
    }
  }
}
