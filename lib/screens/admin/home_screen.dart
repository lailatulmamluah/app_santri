// lib/screens/admin/home_screen.dart

import 'package:flutter/material.dart';
import 'package:e_santri/screens/admin/chekcin_qr_screen.dart';
import 'package:e_santri/screens/admin/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Santri Admin'),
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Bagian Sambutan ---
            const Text(
              'Selamat Bertugas, Admin!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Pilih aksi utama yang akan dilakukan hari ini.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 30),

            // --- Tombol Aksi 1: Scan QR Santri ---
            _buildActionCard(
              context,
              icon: Icons.qr_code_scanner,
              title: 'SCAN QR Santri',
              subtitle: 'Aksi utama untuk Check-In',
              color: Colors.green.shade700,
              onTap: () {
                // Navigasi ke layar Scan QR Code
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckInQrScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // --- Tombol Aksi 2: Laporan Harian/History ---
            _buildActionCard(
              context,
              icon: Icons.history,
              title: 'Laporan dan History',
              subtitle: 'Lihat catatan kedatangan',
              color: Colors.blue.shade700,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fitur Laporan segera hadir!')),
                );
              },
            ),

            const SizedBox(height: 40),

            // --- Informasi Tambahan ---
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Sistem E-Santri v1.0',
                style: TextStyle(color: Colors.grey[400]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Pembantu untuk Kartu Aksi
  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(25.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.white54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
