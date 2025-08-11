import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Creo la clase de la pantalla de login
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

// Creo la clase de estado para la pantalla de login
class LoginScreenState extends State<LoginScreen> {
  // Atributos
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool bIsLoading = false;
  String? sError;

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      bIsLoading = true;
      sError = null;
    });

    try {
      // Me logueo con FirebaseAuth
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      // Muestro mensaje de confirmación. APUNTE -> aquí estaría bien, cuando haya avanzado más, mostrar el nick del usuario o algo así
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Bienvenido!")));

      // TODO: Aquí es donde hay que meter la lógica para, después del logueo, navegar a la panalla "principal"
    } on FirebaseAuthException catch (e) {
      setState(() {
        sError = e.message;
      });
    } finally {
      setState(() {
        bIsLoading = false;
      });
    }
  }

  // Destructor
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iniciar sesión")),
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
                    value!.isEmpty ? "Introduce tu correo" : null,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Contraseña"),
                obscureText: true,
                validator: (value) =>
                    value!.length < 6 ? "Mínimo 6 caracteres" : null,
              ),
              const SizedBox(height: 20),
              if (bIsLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: login,
                  child: const Text("Entrar"),
                ),
              if (sError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child:
                      Text(sError!, style: const TextStyle(color: Colors.red)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
