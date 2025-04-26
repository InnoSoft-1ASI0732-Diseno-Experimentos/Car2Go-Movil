import 'package:flutter/material.dart';
import '../../widgets/main_scaffold.dart';
import '../../../core/services/user_seller_service.dart';
import 'package:car_2_go/presentation/screens/cars/car_listing_buyer_screen.dart';

class SendDataBuyerScreen extends StatelessWidget {
  final Map<String, dynamic> vehicle;
  final String bank;
  final String account;
  final String name;
  final String email;
  final String telephone;
  final String dni;

  const SendDataBuyerScreen({
    Key? key,
    required this.vehicle,
    required this.bank,
    required this.account,
    required this.name,
    required this.email,
    required this.telephone,
    required this.dni,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = vehicle['model'] as String? ?? 'Modelo desconocido';
    final price = vehicle['price']?.toString() ?? '-';
    final userSellerService = UserSellerService();
    const yellowColor = Color(0xFFFFD54F);

    return MainScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                const Text(
                  'Send ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Data',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: yellowColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Información del Vehículo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 8),
            Text('Modelo: $model',
                style: const TextStyle(fontSize: 16), textAlign: TextAlign.start),
            const SizedBox(height: 8),
            Text('Precio: S/ $price',
                style: const TextStyle(fontSize: 16), textAlign: TextAlign.start),
            const SizedBox(height: 16),
            const Text(  // Agregamos el título "Información del Comprador"
              'Información del Comprador',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 8),
            Text('Nombre: $name',
                style: const TextStyle(fontSize: 16), textAlign: TextAlign.start),
            const SizedBox(height: 8),
            Text('Email: $email',
                style: const TextStyle(fontSize: 16), textAlign: TextAlign.start),
            const SizedBox(height: 8),
            Text('Teléfono: $telephone',
                style: const TextStyle(fontSize: 16), textAlign: TextAlign.start),
            const SizedBox(height: 8),
            Text('DNI: $dni',
                style: const TextStyle(fontSize: 16), textAlign: TextAlign.start),
            const SizedBox(height: 8),
            Text('Banco: $bank',
                style: const TextStyle(fontSize: 16), textAlign: TextAlign.start),
            const SizedBox(height: 8),
            Text('Cuenta: $account',
                style: const TextStyle(fontSize: 16), textAlign: TextAlign.start),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CarListingBuyerScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 80),
                  backgroundColor: yellowColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Send',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

