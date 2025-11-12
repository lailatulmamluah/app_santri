// lib/screens/admin/verification_result_screen.dart

import 'package:flutter/material.dart';
import 'package:e_santri/models/checkin_data.dart';
import 'chekcin_qr_screen.dart'; // Untuk navigasi kembali ke scanner

class VerificationResultScreen extends StatelessWidget {
  final CheckInData result;

  const VerificationResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    // Tentukan warna dan ikon berdasarkan hasil verifikasi
    final Color cardColor = result.isVerified
        ? Colors.green.shade100
        : Colors.red.shade100;
    final Color iconColor = result.isVerified
        ? Colors.green.shade800
        : Colors.red.shade800;
    final IconData icon = result.isVerified ? Icons.check_circle : Icons.error;
    final String title = result.isVerified
        ? 'VERIFIKASI SUKSES'
        : 'VERIFIKASI GAGAL';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Verifikasi'),
        backgroundColor: Colors.green,
        automaticallyImplyLeading:
            false, // Menyembunyikan tombol kembali bawaan
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // --- Card Hasil Verifikasi ---
              Card(
                color: cardColor,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: iconColor, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      Icon(icon, size: 80, color: iconColor),
                      const SizedBox(height: 20),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: iconColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // --- Detail Santri ---
                      _buildDetailRow('NIS', result.nis),
                      _buildDetailRow('Nama', result.nama),
                      _buildDetailRow('Waktu Scan', result.waktu),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // --- Tombol Selesai ---
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigasi kembali ke scanner QR untuk scan berikutnya
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CheckInQrScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'SELESAI / SCAN LAGI',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
