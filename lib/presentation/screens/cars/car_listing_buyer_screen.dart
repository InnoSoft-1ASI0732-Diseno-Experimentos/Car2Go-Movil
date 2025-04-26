import 'package:flutter/material.dart';
import 'package:car_2_go/core/services/vehicle_service.dart';
import '../../widgets/main_scaffold.dart';
import 'car_detail_buyer_screen.dart';

class CarListingBuyerScreen extends StatefulWidget {
  const CarListingBuyerScreen({super.key});

  @override
  State<CarListingBuyerScreen> createState() => _CarListingBuyerScreenState();
}

class _CarListingBuyerScreenState extends State<CarListingBuyerScreen> {
  final VehicleService _vehicleService = VehicleService();
  late Future<List<dynamic>> _vehiclesFuture;

  @override
  void initState() {
    super.initState();
    _vehiclesFuture = _vehicleService.getAllVehicles();
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
                Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      const TextSpan(text: 'Car '),
                      TextSpan(
                        text: 'Listing',
                        style: const TextStyle(color: Color(0xFFFFD54F)),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD54F),
                  ),
                  child: const Text('My offers'),
                )
              ],
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


                  final vehicles = snapshot.data ?? [];

                  if (vehicles.isEmpty) {
                    return const Center(
                      child: Text(
                        'No enviaste ofertas',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: vehicles.length,
                    itemBuilder: (context, index) {
                      final vehicle = vehicles[index] as Map<String, dynamic>;
                      final images = vehicle['image'] as List<dynamic>?;
                      final hasImages = images?.isNotEmpty == true;

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
                                child: hasImages
                                    ? Image.network(
                                  images!.first,
                                  height: 160,
                                  fit: BoxFit.cover,
                                )
                                    : Image.asset(
                                  'assets/placeholder-car.jpg',
                                  height: 160,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    (vehicle['model'] as String?) ?? 'Modelo Auto',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => CarDetailBuyerScreen(vehicle: vehicle),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Details',
                                      style: TextStyle(color: Colors.blue.shade700),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text("Precio: S/${vehicle['price']}"),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _InfoTag(icon: Icons.calendar_today, label: vehicle['year']),
                                  _InfoTag(icon: Icons.speed, label: "${vehicle['mileage']} km"),
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
