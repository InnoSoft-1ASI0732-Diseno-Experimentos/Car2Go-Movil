import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';

import 'presentation/screens/auth/first_screen.dart';
import 'presentation/screens/auth/login_buyer_screen.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'core/services/auth_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Manejador de notificaciones en segundo plano
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('(BG) Notificación: ${message.notification?.title}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _mensaje = "Esperando notificación...";

  @override
  void initState() {
    super.initState();
    _initFirebaseMessaging();
    _medirInicioApp();
  }

  void _initFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Solicitar permisos
    await messaging.requestPermission(alert: true, badge: true, sound: true);

    // Suscribirse a tópico
    await messaging.subscribeToTopic("alertas-dev");
    print("✅ Suscrito a alertas-dev");

    // Obtener token para pruebas
    String? token = await messaging.getToken();
    debugPrint("🔑 FCM Token: $token");

    // Mensaje en primer plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📲 Notificación en primer plano');
      setState(() {
        _mensaje = message.notification?.body ?? 'Sin contenido';
      });

      showDialog(
        context: navigatorKey.currentContext!,
        builder: (_) => AlertDialog(
          title: Text(message.notification?.title ?? 'Alerta'),
          content: Text(message.notification?.body ?? 'Sin contenido'),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.pop(navigatorKey.currentContext!),
            )
          ],
        ),
      );
    });

    // Mensaje que abrió la app desde segundo plano
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    // Mensaje que abrió la app desde terminada
    final initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
  }

  void _handleMessage(RemoteMessage message) {
    print('📩 Notificación abrió la app: ${message.notification?.title}');
    // Aquí puedes redirigir a otra pantalla si quieres
    // Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder: (_) => OtraPantalla()));
  }

  void _medirInicioApp() async {
    final trace = FirebasePerformance.instance.newTrace("inicio_app");
    await trace.start();
    await Future.delayed(const Duration(milliseconds: 500));
    await trace.stop();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car 2 Go',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const RoleSelectionScreen(),
    );
  }
}
