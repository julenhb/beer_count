import 'package:beer_count/features/auth/screens/auth_gate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConsumoScreen extends StatelessWidget {
  const ConsumoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("¿Qué has bebido?"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AuthGate()),
              );
            },
          )
        ],
      ),
      body: const Center(
        child: Text("Aquí irá la selección de bebidas 🍻"),
      ),
    );
  }
}
