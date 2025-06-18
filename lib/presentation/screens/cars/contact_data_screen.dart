// lib/presentation/screens/cars/contact_data_screen.dart
import 'package:flutter/material.dart';
import '../../../models/new_vehicle.dart';
import '../../widgets/main_scaffold.dart';
import 'price_screen.dart';

class ContactDataScreen extends StatefulWidget {
  final NewVehicle newVehicle; // 👈 Recibir desde afuera

  const ContactDataScreen({super.key, required this.newVehicle}); // 👈 Required

  @override
  State<ContactDataScreen> createState() => _ContactDataScreenState();
}

class _ContactDataScreenState extends State<ContactDataScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    // Inicializar los controllers con los valores que ya tenga el vehículo (si existiera)
    _nameController = TextEditingController(text: widget.newVehicle.name);
    _lastNameController = TextEditingController(text: widget.newVehicle.lastName);
    _phoneController = TextEditingController(text: widget.newVehicle.phone);
    _emailController = TextEditingController(text: widget.newVehicle.email);
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 24),
              const Text(
                'Sales Data ',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                '- Contact Data',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              _buildInputField('Name', _nameController),
              const SizedBox(height: 16),
              _buildInputField('Last Name', _lastNameController),
              const SizedBox(height: 16),
              _buildInputField('Telephone', _phoneController),
              const SizedBox(height: 16),
              _buildInputField('Email', _emailController),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _goToNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD54F),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF3F3F3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          validator: (value) => (value == null || value.isEmpty) ? 'Required field' : null,
        ),
      ],
    );
  }

  void _goToNext() {
    if (_formKey.currentState!.validate()) {
      // Guardar datos en el objeto que recibimos
      widget.newVehicle.name = _nameController.text.trim();
      widget.newVehicle.lastName = _lastNameController.text.trim();
      widget.newVehicle.phone = _phoneController.text.trim();
      widget.newVehicle.email = _emailController.text.trim();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PriceScreen(newVehicle: widget.newVehicle),
        ),
      );
    }
  }
}
