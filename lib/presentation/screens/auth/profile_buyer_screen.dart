import 'package:flutter/material.dart';
import 'package:car_2_go/core/services/auth_service.dart'; // Importa AuthService
import 'package:car_2_go/core/services/user_seller_service.dart'; // Import UserSellerService
import '../home/home_screen.dart'; // Importa HomeScreen

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dniController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final AuthService _authService = AuthService(); // Usar el singleton
  final UserSellerService _userSellerService = UserSellerService(); // Agregar UserSellerService

  // Función para guardar el perfil
  Future<void> _saveProfile(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final profileData = {
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'dni': _dniController.text,
        'address': _addressController.text,
        'phone': _phoneController.text,
        'email': _authService.username, // Obtener el email del AuthService
        'image': "-", // Puedes dejarlo vacío o pedirlo al usuario
      };

      final response = await _userSellerService.createProfile(profileData); // Llama a createProfile

      if (response.isNotEmpty && response.containsKey('id')) {
        // Perfil creado exitosamente, redirige a HomeScreen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile created successfully!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        // Error al crear el perfil, muestra un mensaje
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create profile.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const Text(
                'Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _dniController,
                decoration: const InputDecoration(labelText: 'DNI'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your DNI';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _authService.username,
                decoration: const InputDecoration(labelText: 'Email'),
                enabled: false,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _saveProfile(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD54F),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

