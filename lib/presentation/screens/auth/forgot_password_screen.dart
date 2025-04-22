import 'package:flutter/material.dart';
import 'register_screen.dart'; // para el botón "Sign Up"
import 'login_screen.dart'; // para el botón "Sign In"

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _codeController = TextEditingController();
  bool _codeSent = false;

  void _sendCode() {
    if (_usernameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa tu nombre de usuario')),
      );
      return;
    }

    setState(() => _codeSent = true);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('📨 Se ha enviado un código a tu correo (simulado)'),
      ),
    );
  }

  void _recoverPassword() {
    if (_codeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa el código recibido')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Contraseña restablecida (simulado)')),
    );

    Navigator.pop(context); // Regresar al login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView(
            children: [
              const SizedBox(height: 40),
              Center(
                child: Image.asset(
                  'assets/logo-car.png',
                  height: 140,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Password Recovery',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text('Username'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFE0E0E0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _sendCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD54F),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Enviar codigo'),
              ),
              const SizedBox(height: 24),
              if (_codeSent) ...[
                const Text('Codigo'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFE0E0E0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _recoverPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD54F),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Recuperar contraseña'),
                ),
              ],
              const SizedBox(height: 32),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
