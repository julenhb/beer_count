import 'package:beer_count/features/auth/screens/login_screen.dart';
import 'package:beer_count/features/consumicion/screens/consumo_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // No hay sesión iniciada
      return const LoginScreen();
    } else {
      // Tengo una sesión activa, voy a la pantalla principal
      return const ConsumoScreen(); // De momento voy a utilizar esto hasta que cree la pantalla de consumo
    }
  }
}
