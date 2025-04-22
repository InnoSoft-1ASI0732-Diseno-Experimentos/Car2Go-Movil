import 'package:flutter/material.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/plans/plan_screen.dart';
import '../../presentation/screens/cars/my_cars_screen.dart';
void _emptyAction() {}

class MainScaffold extends StatelessWidget {
  final Widget body;
  final String title;

  const MainScaffold({
    super.key,
    required this.body,
    this.title = 'CAR 2 GO',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ← COLOR DE FONDO DE LA PANTALLA
        drawer: Drawer(
          backgroundColor: const Color(0xFF282828),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              const SizedBox(height: 40),
              Image.asset('assets/logo-car.png', height: 80),
              const Divider(color: Colors.white54),
              DrawerItem(
                label: 'HOME',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                },
              ),
              DrawerItem(
                label: 'PLANS',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const PlanScreen()),
                  );
                },
              ),
              const DrawerItem(label: 'CARS LISTING', onTap: _emptyAction),
              DrawerItem(
                label: 'MY CARS',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const MyCarsScreen()),
                  );
                  },
              ),
            ],
          ),
        ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF282828),
        iconTheme: const IconThemeData(color: Colors.white), // ← cambia el color del ícono del Drawer
        toolbarHeight: 100,
        title: Image.asset('assets/logo-car.png', height: 56),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.account_circle, size: 52, color: Colors.white),
          )
        ],
      ),
      body: body,
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const DrawerItem({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: () {
        Navigator.pop(context); // cerrar el drawer
        onTap(); // ejecutar acción
      },
    );
  }
}

