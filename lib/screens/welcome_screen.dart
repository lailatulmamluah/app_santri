// lib/screens/welcome_screen.dart

import 'package:flutter/material.dart';
import 'admin/login_screen.dart'; // Import LoginScreen Anda

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),

            // --- Bagian Teks Selamat Datang ---
            const Text(
              'اسلام عليكم',
              style: TextStyle(fontSize: 100, color: Colors.black54),
            ),
            const Text(
              'selamat kembali Santri Busa',
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.green, // Warna tema Anda
              ),
            ),
            const SizedBox(height: 50),

            // --- Loading Indicator ---
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
