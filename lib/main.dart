import 'package:flutter/material.dart';
import 'package:e_santri/services/api_service.dart';
import 'package:e_santri/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiService.initializeSupabase();
  runApp(const ESantriApp());
}

class ESantriApp extends StatelessWidget {
  const ESantriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'e_santri App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Tampilan awal aplikasi
      home: const WelcomeScreen(),
    );
  }
}
