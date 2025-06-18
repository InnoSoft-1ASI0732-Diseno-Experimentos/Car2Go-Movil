import 'dart:io';
import 'package:flutter/material.dart';

class CarDetailScreen extends StatelessWidget {
  final Map<String, dynamic> vehicle;

  const CarDetailScreen({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final images = vehicle['images'] as List<dynamic>? ?? [];

    Widget mainImageWidget() {
      if (images.isEmpty) {
        return Image.asset('assets/auto-ejemplo.png', height: 220, width: double.infinity, fit: BoxFit.cover);
      }

      final img = images[0];

      if (img.toString().startsWith('http')) {
        return Image.network(img, height: 220, width: double.infinity, fit: BoxFit.cover);
      } else {
        final file = File(img);
        if (file.existsSync()) {
          return Image.file(file, height: 220, width: double.infinity, fit: BoxFit.cover);
        } else {
          return Image.asset('assets/auto-ejemplo.png', height: 220, width: double.infinity, fit: BoxFit.cover);
        }
      }
    }

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 Imagen principal
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: mainImageWidget(),
            ),
            const SizedBox(height: 24),

            // 🔥 Titulo
            Row(
              children: [
                Text(
                  vehicle['brand'] ?? 'Marca',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Text(
                  vehicle['model'] ?? 'Modelo',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('PRICE', style: TextStyle(color: Colors.blue.shade700)),

            const SizedBox(height: 24),

            // 🔥 Descripción
            Text(vehicle['description'] ?? 'Descripción no disponible.', style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 32),

            // 🔥 Características
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _InfoTag(icon: Icons.calendar_today, label: vehicle['year']),
                _InfoTag(icon: Icons.settings, label: vehicle['transmission']),
                _InfoTag(icon: Icons.speed, label: vehicle['engine']),
                _InfoTag(icon: Icons.color_lens, label: vehicle['color']),
                _InfoTag(icon: Icons.door_front_door, label: '${vehicle['doors']} Doors'),
                _InfoTag(icon: Icons.speed_outlined, label: '${vehicle['mileage']} km'),
                _InfoTag(icon: Icons.location_on, label: vehicle['location']),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTag extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoTag({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD54F),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
