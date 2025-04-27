// lib/presentation/screens/vehicle/car_data_screen.dart
import 'package:flutter/material.dart';
import '../../../models/new_vehicle.dart';
import 'photo_upload_screen.dart'; // siguiente pantalla

class CarDataScreen extends StatefulWidget {
  final NewVehicle newVehicle;

  const CarDataScreen({super.key, required this.newVehicle});

  @override
  State<CarDataScreen> createState() => _CarDataScreenState();
}

class _CarDataScreenState extends State<CarDataScreen> {
  final _formKey = GlobalKey<FormState>();

  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _colorController = TextEditingController();
  final _yearController = TextEditingController();
  final _transmissionController = TextEditingController();
  final _engineController = TextEditingController();
  final _mileageController = TextEditingController();
  final _doorsController = TextEditingController();
  final _plateController = TextEditingController(); // ✅ Agregado
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _fuelController = TextEditingController(); // ✅ Agregado
  final _speedController = TextEditingController(); // ✅ Agregado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF282828),
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 100,
        title: Image.asset('assets/logo-car.png', height: 56),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.account_circle, size: 52, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.white,
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
                '- Car Data',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              _buildInput('Brand', _brandController),
              _buildInput('Model', _modelController),
              _buildInput('Color', _colorController),
              _buildInput('Year of manufacture', _yearController),
              _buildInput('Transmission type', _transmissionController),
              _buildInput('Engine (Cylinder capacity)', _engineController),
              _buildInput('Mileage', _mileageController),
              _buildInput('Number of doors', _doorsController),
              _buildInput('Plate', _plateController), // ✅ Agregado
              _buildInput('Location', _locationController),
              _buildInput('Fuel Type', _fuelController), // ✅ Agregado
              _buildInput('Top Speed (Km/h)', _speedController), // ✅ Agregado
              _buildInput('Description', _descriptionController, maxLines: 3),
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

  Widget _buildInput(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
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
      ),
    );
  }

  void _goToNext() {
    if (_formKey.currentState!.validate()) {
      widget.newVehicle.brand = _brandController.text.trim();
      widget.newVehicle.model = _modelController.text.trim();
      widget.newVehicle.color = _colorController.text.trim();
      widget.newVehicle.year = _yearController.text.trim();
      widget.newVehicle.transmission = _transmissionController.text.trim();
      widget.newVehicle.engine = _engineController.text.trim();
      widget.newVehicle.mileage = double.tryParse(_mileageController.text.trim()) ?? 0.0;
      widget.newVehicle.doors = _doorsController.text.trim();
      widget.newVehicle.plate = _plateController.text.trim(); // ✅
      widget.newVehicle.location = _locationController.text.trim();
      widget.newVehicle.fuel = _fuelController.text.trim(); // ✅
      widget.newVehicle.speed = int.tryParse(_speedController.text.trim()) ?? 100; // ✅
      widget.newVehicle.description = _descriptionController.text.trim();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhotoUploadScreen(newVehicle: widget.newVehicle),
        ),
      );
    }
  }
}
