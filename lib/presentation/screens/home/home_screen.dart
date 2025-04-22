import 'package:flutter/material.dart';
import '../../widgets/main_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const Text(
              'SELL YOUR CAR WITH EASE',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 22),
            const Text(
              'WANT TO SELL YOUR CAR?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 34,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD54F),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: const Text('SELL YOUR CAR'),
            ),
            const SizedBox(height: 32),
            const InfoCardsRow(), // ← nuevo carrusel
          ],
        ),
      ),
    );
  }
}

class InfoCardsRow extends StatelessWidget {
  const InfoCardsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          children: const [
            InfoCard(
              icon: Icons.directions_car,
              title: 'Safe Buying and Selling',
              description:
              'We offer secure and reliable transactions so you can buy or sell your car with complete peace.',
            ),
            InfoCard(
              icon: Icons.search,
              title: 'Quality Verification',
              description:
              'We ensure that every vehicle on the platform meets high safety standards with complete peace.',
            ),
            InfoCard(
              icon: Icons.groups,
              title: 'Specialized Workshops',
              description:
              'We have technical workshops that certify and ensure the optimal condition of the vehicles.',
            ),
            InfoCard(
              icon: Icons.lock,
              title: 'Secure Payments',
              description:
              'We guarantee secure and reliable payments, protecting your transaction at all times.',
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFFFD54F),
            child: Icon(icon, color: Colors.black),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}