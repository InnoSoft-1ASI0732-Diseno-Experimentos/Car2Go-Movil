import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'presentation/screens/auth/first_screen.dart';
import 'presentation/screens/auth/login_buyer_screen.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'core/services/auth_service.dart';

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
  }

  void _initFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await messaging.subscribeToTopic("alertas-dev");
    print("✅ Suscrito a alertas-dev");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📲 Notificación en primer plano');
      setState(() {
        _mensaje = message.notification?.body ?? 'Sin contenido';
      });

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(message.notification?.title ?? 'Alerta'),
          content: Text(message.notification?.body ?? 'Sin contenido'),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car 2 Go',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const RoleSelectionScreen(),
    );
  }
}
