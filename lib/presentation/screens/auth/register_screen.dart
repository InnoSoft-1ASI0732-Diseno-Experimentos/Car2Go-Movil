import 'package:flutter/material.dart';
import 'package:car_2_go/core/services/auth_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  final Map<String, String> _roleLabels = {
    'ROLE_SELLER': 'Seller',
    'ROLE_BUYER': 'Buyer',
    'ROLE_MECHANIC': 'Mechanic',
  };

  String? _selectedRole;

  void _submit() async {
    final formValid = _formKey.currentState?.validate() ?? false;

    if (formValid && _selectedRole != null) {
      final success = await _authService.register(
        _usernameController.text.trim(),
        _passwordController.text.trim(),
        [_selectedRole!], // ya no es null aquí
      );

      final message = success
          ? '✅ Registro exitoso'
          : '❌ Error al registrar';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );

      if (success) {
        Navigator.pop(context); // volver al login
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Completa todos los campos y selecciona un rol'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
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
                  'Sign Up',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                const Text('Name'),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color(0xFFF3F3F3),
                  ),
                  validator: (value) =>
                  (value == null || value.isEmpty) ? 'Enter your name' : null,
                ),
                const SizedBox(height: 16),
                const Text('Password'),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color(0xFFF3F3F3),
                  ),
                  validator: (value) =>
                  (value == null || value.isEmpty) ? 'Enter a password' : null,
                ),
                const SizedBox(height: 16),
                const Text('Select Role'),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedRole,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color(0xFFF3F3F3),
                  ),
                  items: _roleLabels.entries.map((entry) {
                    return DropdownMenuItem(
                      value: entry.key,
                      child: Text(entry.value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value;
                    });
                  },
                  validator: (value) =>
                  value == null ? 'Please select a role' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD54F),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()));
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: "Have an account? ",
                        children: [
                          TextSpan(
                            text: "Sign In",
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
