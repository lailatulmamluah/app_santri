// lib/screens/admin/checkin_qr_screen.dart

import 'package:e_santri/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:e_santri/models/checkin_data.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'verification_result_screen.dart';
import 'login_screen.dart';

class CheckInQrScreen extends StatelessWidget {
  const CheckInQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Santri'),
        backgroundColor: Colors.green,
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
      body: MobileScanner(
        // Untuk memindai QR code
        onDetect: (capture) async {
          final List<Barcode> barcodes = capture.barcodes;

          if (barcodes.isNotEmpty) {
            final String? scannedNis = barcodes.first.rawValue;

            if (scannedNis != null) {
              // Tampilkan loading sebelum memproses data
              showDialog(
                context: context, // Menggunakan context yang ada
                barrierDismissible: false,
                builder: (context) =>
                    const Center(child: CircularProgressIndicator()),
              );

              // 1. Panggil API untuk Verifikasi NIS
              try {
                final CheckInData result = await apiService
                    .sendNisForVerification(scannedNis);

                // Tutup loading
                if (context.mounted) {
                  Navigator.pop(context);
                }

                // Navigasi ke hasil verifikasi
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VerificationResultScreen(result: result),
                    ),
                  );
                }
              } catch (e) {
                // Tutup loading
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Verifikasi Gagal: ${e.toString()}'),
                    ),
                  );
                }
              }
            }
          }
        },
      ),
    );
  }
}
