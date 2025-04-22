import 'package:flutter/material.dart';
import 'core/services/auth_service.dart';
import 'presentation/screens/auth/login_screen.dart'; // importa tu pantalla de login

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car 2 Go',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const LoginScreen(), // ← aquí arranca tu app
    );
  }
}
