import 'package:flutter/material.dart';
import '../../widgets/main_scaffold.dart';

class CarTechnicalReviewBuyerScreen extends StatelessWidget {
  final Map<String, dynamic> vehicle;

  const CarTechnicalReviewBuyerScreen({Key? key, required this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFFFFD54F);

    return MainScaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
                children: [
                  TextSpan(text: 'Technical '),
                  TextSpan(
                    text: 'Review',
                    style: TextStyle(color: accentColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Phasellus imperdiet, nulla et dictum interdum, nisi lorem egestas odio, '
                  'vitae scelerisque enim ligula venenatis dolor.',
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para abrir el documento o navegar a otra pantalla
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Review Document',
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
