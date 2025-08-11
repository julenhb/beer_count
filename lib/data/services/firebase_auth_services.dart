import 'package:beer_count/data/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // RegistrarUsuario
  Future<Usuario> registrarUsuario(
      String sEmail, String sPassword, String sNick) async {
    try {
      // Creo el usuario en Firebase Authentication
      UserCredential uCredential = await _auth.createUserWithEmailAndPassword(
          email: sEmail, password: sPassword);

      // Creo la instancia de Usuario
      final nuevoUsuario = Usuario(
          sId: uCredential.user!.uid,
          sEmail: sEmail,
          sNick: sNick,
          sFotoDePerfilUrl: "",
          iTotalLitros: 0,
          iTotalTragos: 0,
          lGrupos: []);

      // Lo guardo en Firestore (como a base de datos)
      await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(nuevoUsuario.sId)
          .set(nuevoUsuario.toMap());

      return nuevoUsuario;
    } on FirebaseAuthException catch (e) {
      throw Exception("Error al registrar: ${e.message}");
    }
  }
}
