import 'package:flutter/material.dart';
import '../../widgets/main_scaffold.dart';
import '../transaction/payment_buyer.dart';
import 'car_technical_review_buyer_screen.dart';

class CarDetailBuyerScreen extends StatefulWidget {
  final Map<String, dynamic> vehicle;

  const CarDetailBuyerScreen({Key? key, required this.vehicle}) : super(key: key);

  @override
  State<CarDetailBuyerScreen> createState() => _CarDetailBuyerScreenState();
}

class _CarDetailBuyerScreenState extends State<CarDetailBuyerScreen> {
  int _currentIndex = 0;

  List<dynamic>? get _images => widget.vehicle['image'] as List<dynamic>?;
  bool get _hasImages => _images?.isNotEmpty == true;

  @override
  Widget build(BuildContext context) {
    final model = (widget.vehicle['model'] as String?) ?? 'Modelo desconocido';
    final price = widget.vehicle['price']?.toString() ?? '-';
    final description = (widget.vehicle['description'] as String?) ?? '';

    final year = (widget.vehicle['year'] as String?) ?? '-';
    final transmission = (widget.vehicle['transmission'] as String?) ?? '-';
    final fuel = (widget.vehicle['fuel'] as String?) ?? '-';
    final location = (widget.vehicle['location'] as String?) ?? '-';
    final colors = widget.vehicle['color'] != null
        ? [widget.vehicle['color']]
        : ['-'];
    final doors = widget.vehicle['doors']?.toString() ?? '-';
    final mileage = widget.vehicle['mileage']?.toString() ?? '-';

    const accentColor = Color(0xFFFFD54F);

    return MainScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                            text: 'Details',
                            style: const TextStyle(color: Color(0xFFFFD54F)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaymentBuyerScreen(vehicle: widget.vehicle),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Add Offer', style: TextStyle(color: Colors.white)),
                )
              ],
            ),
            const SizedBox(height: 16),
            if (_hasImages) ...[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  _images![_currentIndex],
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _images!.length,
                  itemBuilder: (context, idx) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = idx;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _currentIndex == idx ? accentColor : Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            _images![idx],
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ] else ...[
              Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(child: Icon(Icons.directions_car, size: 64)),
              ),
            ],
            const SizedBox(height: 16),
            Text(
              model,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Precio: S/ $price',
              style: const TextStyle(fontSize: 20, color: Colors.black87),
            ),
            const SizedBox(height: 16),

            Text(
              description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _IconDetail(icon: Icons.calendar_today, value: year),
                      _IconDetail(icon: Icons.settings, value: transmission),
                      _IconDetail(icon: Icons.local_gas_station, value: fuel),
                      _IconDetail(icon: Icons.location_on, value: location),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _IconDetail(icon: Icons.color_lens, value: colors.join(', ')),
                      _IconDetail(icon: Icons.door_front_door, value: '$doors puertas'),
                      _IconDetail(icon: Icons.speed, value: '$mileage km'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'For your safety this car has been inspected',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CarTechnicalReviewBuyerScreen(vehicle: widget.vehicle),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: accentColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        child: const Text(
                          'Review Here',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconDetail extends StatelessWidget {
  final IconData icon;
  final String value;

  const _IconDetail({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFFFFD54F);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: accentColor,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(6),
            child: Icon(icon, size: 16, color: Colors.black),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
