import 'package:beer_count/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:beer_count/data/services/firebase_auth_services.dart';
import 'package:beer_count/data/models/usuario.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => RegistroScreenState();
}

class RegistroScreenState extends State<RegistroScreen> {
  // Atributos
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nickController = TextEditingController();

  // Conexión a Firebase
  final authService = FirebaseAuthServices();

  bool bIsLoading = false;
  String? sError;

  void registrar() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      bIsLoading = true;
      sError = null;
    });

    try {
      Usuario usuario = await authService.registrarUsuario(
          emailController.text.trim(),
          passwordController.text.trim(),
          nickController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("¡${usuario.sNick} registrado con éxito!"),
      ));
    } catch (e) {
      setState(() {
        sError = e.toString();
      });
    } finally {
      setState(() {
        bIsLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Correo"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.isEmpty ? "Introduce un correo" : null,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Contraseña"),
                obscureText: true,
                validator: (value) =>
                    value!.length < 6 ? "Mínimo 6 caracteres" : null,
              ),
              TextFormField(
                controller: nickController,
                decoration: const InputDecoration(labelText: "Nick"),
                validator: (value) =>
                    value!.isEmpty ? "Introduce un nick" : null,
              ),
              const SizedBox(height: 20),
              if (bIsLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: registrar,
                  child: const Text("Registrarse"),
                ),
              if (sError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child:
                      Text(sError!, style: const TextStyle(color: Colors.red)),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("¿Ya tienes cuenta? "),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },
                    child: const Text("Inicia sesión"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Utilizo el dispose para limpiar formularios y optimizar memoria cuando ya se haya usado esta pantalla
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nickController.dispose();
    super.dispose();
  }
}
