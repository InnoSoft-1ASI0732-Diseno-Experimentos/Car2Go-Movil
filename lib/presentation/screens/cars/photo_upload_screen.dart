// lib/presentation/screens/vehicle/photo_upload_screen.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/services/auth_service.dart';
import '../../../models/new_vehicle.dart';
import '../../../core/services/vehicle_service.dart'; // Servicio para guardar
import '../../widgets/main_scaffold.dart'; // Si quieres envolver luego

class PhotoUploadScreen extends StatefulWidget {
  final NewVehicle newVehicle;

  const PhotoUploadScreen({super.key, required this.newVehicle});

  @override
  State<PhotoUploadScreen> createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];

  bool _isSubmitting = false;

  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages = pickedFiles;
      });
    }
  }

  Future<void> _submitVehicle() async {
    setState(() {
      _isSubmitting = true;
    });

    // Convertimos las rutas locales de imágenes en rutas simuladas o URIs (en proyecto real debes subirlas primero)
    widget.newVehicle.images = _selectedImages.map((file) => file.path).toList();
    print('📢 TOKEN que se enviará: ${AuthService().token}');

    // 🔥🔥 AQUI imprimimos bonito el objeto que se va a enviar 🔥🔥
    final jsonVehicle = jsonEncode(widget.newVehicle.toJson());
    print('📝 Datos del vehículo a enviar:');
    print(jsonVehicle);

    final vehicleService = VehicleService();
    final success = await vehicleService.createVehicle(widget.newVehicle);

    setState(() {
      _isSubmitting = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Vehículo registrado exitosamente')),
      );
      Navigator.popUntil(context, (route) => route.isFirst); // Volver al Home
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Error al registrar vehículo')),
      );
    }
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const Text(
              'Upload Photos',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _pickImages,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD54F),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Select Images'),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _selectedImages.isEmpty
                  ? const Center(child: Text('No images selected'))
                  : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: _selectedImages.length,
                itemBuilder: (context, index) {
                  return Image.file(
                    File(_selectedImages[index].path),
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submitVehicle,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD54F),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isSubmitting
                  ? const CircularProgressIndicator(color: Colors.black)
                  : const Text('Publish Vehicle'),
            ),
          ],
        ),
      ),
    );
  }
}
