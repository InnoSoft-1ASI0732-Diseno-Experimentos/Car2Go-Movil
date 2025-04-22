import 'package:flutter/material.dart';
import '../../widgets/main_scaffold.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const SizedBox(height: 24),
            const Text(
              'Choose a Plan',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            PlanCard(
              title: 'Basic Plan',
              subtitle: 'Current Plan',
              features: const [
                'Access to all listings',
                'Customer support',
                'Increased visibility in ads',
              ],
              isCurrent: true,
            ),
            PlanCard(
              title: 'Premium Plan',
              subtitle: 'S/179 - month',
              features: const [
                'Access to all listings',
                'Customer support',
                'Increased visibility in ads',
                'Discounts on featured listings',
              ],
              onSubscribe: () {
                // Acción al suscribirse
              },
            ),
            PlanCard(
              title: 'Pro Plan',
              subtitle: 'S/259 - month',
              features: const [
                'Benefits of previous plans',
                'Commission discount',
                'Priority customer support',
              ],
              onSubscribe: () {
                // Acción al suscribirse
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> features;
  final bool isCurrent;
  final VoidCallback? onSubscribe;

  const PlanCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.features,
    this.isCurrent = false,
    this.onSubscribe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.pink.shade100),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isCurrent ? Colors.amber.shade700 : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features.map((f) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• ", style: TextStyle(fontSize: 16)),
                  Expanded(child: Text(f)),
                ],
              ),
            )).toList(),
          ),
          if (!isCurrent) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onSubscribe,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD54F),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
              ),
              child: const Text("Subscribe now"),
            ),
          ],
        ],
      ),
    );
  }
}
