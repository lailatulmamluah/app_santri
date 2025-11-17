// lib/screens/admin/profile_admin_screen.dart

import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import layar login
import 'package:e_santri/services/api_service.dart'; // Import ApiService untuk fungsi logout

class ProfileAdminScreen extends StatelessWidget {
  const ProfileAdminScreen({super.key});

  // Fungsi untuk menangani Logout
  void _handleLogout(BuildContext context) async {
    // Tampilkan loading sebentar
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    Future<void> signOut() async {
      try {
        await _supabaseClient.auth.signOut();
      } catch (e) {
        print('Error saat sign out: $e');
      }
    } // Panggil fungsi signOut dari ApiService

    // Catatan: Pastikan method signOut sudah didefinisikan di ApiService
    await ApiService().signOut();

    // Tutup dialog loading
    if (context.mounted) {
      Navigator.pop(context);
    }

    // Navigasi kembali ke layar Login dan hapus semua rute sebelumnya
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false, // Hapus semua rute di stack
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Admin'),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // --- Bagian Header Profil ---
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blueGrey,
                    child: Icon(
                      Icons.admin_panel_settings,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Admin Pondok (Pengurus)',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ID Admin: ADMIN001',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // --- Menu Pengaturan Khusus Admin ---
            Card(
              elevation: 2,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.history_toggle_off,
                      color: Colors.indigo,
                    ),
                    title: const Text('Lihat Log Check-in Hari Ini'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Aksi: Navigasi ke log harian
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.indigo),
                    title: const Text('Pengaturan Sistem'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Aksi: Navigasi ke pengaturan sistem
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            // --- Tombol Logout ---
            ElevatedButton.icon(
              onPressed: () => _handleLogout(context),
              icon: const Icon(Icons.logout),
              label: const Text('LOGOUT', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
