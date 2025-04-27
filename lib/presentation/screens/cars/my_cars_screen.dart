import 'dart:io';

import 'package:flutter/material.dart';
import 'package:car_2_go/core/services/vehicle_service.dart';
import '../../widgets/main_scaffold.dart';
import 'package:car_2_go/models/new_vehicle.dart';
import 'package:car_2_go/presentation/screens/cars/contact_data_screen.dart';
import 'car_detail_screen.dart';

class MyCarsScreen extends StatefulWidget {
  const MyCarsScreen({super.key});

  @override
  State<MyCarsScreen> createState() => _MyCarsScreenState();
}

class _MyCarsScreenState extends State<MyCarsScreen> {
  final VehicleService _vehicleService = VehicleService();
  late Future<List<dynamic>> _vehiclesFuture;

  @override
  void initState() {
    super.initState();
    _vehiclesFuture = _vehicleService.getMyCars(); // Llama a tu servicio
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My ',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactDataScreen(
                          newVehicle: NewVehicle(), // ← siempre pasas un objeto vacío al inicio
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD54F),
                  ),
                  child: const Text('Sell Cars'),
                )

              ],
            ),
            const Text(
              'Cars',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFD54F),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _vehiclesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text('❌ Error al cargar vehículos'));
                  }

                  final vehicles = snapshot.data!;

                  if (vehicles.isEmpty) {
                    return const Center(
                      child: Text(
                        'No hay autos para vender',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: vehicles.length,
                    itemBuilder: (context, index) {
                      final vehicle = vehicles[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Color(0xFFFFE0E0)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: vehicle['images'] != null && vehicle['images'].isNotEmpty
                                    ? (vehicle['images'][0].startsWith('http')
                                    ? Image.network(vehicle['images'][0], height: 160, fit: BoxFit.cover)
                                    : Image.file(File(vehicle['images'][0]), height: 160, fit: BoxFit.cover))
                                    : Image.asset('assets/auto-ejemplo.png', height: 200),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    vehicle['model'] ?? 'Modelo Auto',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  // 👇 Aquí cambiamos el "Details" por un botón
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CarDetailScreen(vehicle: vehicle),
                                        ),
                                      );
                                    },
                                    child: const Text('Details', style: TextStyle(color: Colors.blue)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text('Precio: S/${vehicle['price']}'),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _InfoTag(icon: Icons.calendar_today, label: vehicle['year']),
                                  _InfoTag(icon: Icons.speed, label: '${vehicle['mileage']} km'),
                                  _InfoTag(icon: Icons.local_gas_station, label: vehicle['fuel']),
                                  _InfoTag(icon: Icons.location_on, label: vehicle['location']),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
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
      width: 70,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD54F),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
