// lib/screens/wali/dashboard_wali_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:e_santri/screens/admin/login_screen.dart';
// Sesuaikan path import ini agar menunjuk ke file api_service.dart Anda

class DashboardWaliScreen extends StatefulWidget {
  // Menerima ID Wali dari WaliMainScreen
  final String waliId;

  const DashboardWaliScreen({super.key, required this.waliId});

  @override
  State<DashboardWaliScreen> createState() => _DashboardWaliScreenState();
}

class _DashboardWaliScreenState extends State<DashboardWaliScreen> {
  // Gunakan instance ApiService Anda
  late Future<Map<String, dynamic>?> _santriStatusFuture;

  @override
  void initState() {
    super.initState();
    // Panggil fungsi untuk mendapatkan status santri saat layar dimuat
    // Catatan: Anda perlu mengaktifkan kembali atau mensimulasikan getSantriStatusByWali di ApiService
    // yang sudah kita buat sebelumnya
    // _santriStatusFuture = _apiService.getSantriStatusByWali(widget.waliId);

    // Saat ini menggunakan simulasi data yang sangat sederhana agar tidak crash:
    _santriStatusFuture = Future.value({
      'nis': 'NIS2025001',
      'nama': 'Ahmad Fauzi',
      'wali_id': widget.waliId,
      'last_check_in': {
        'checkin_type':
            'CHECK_IN', // Ganti ke 'CHECK_OUT' untuk status belum kembali
        'created_at': DateTime.now().toIso8601String(),
      },
    });
  }

  // Fungsi untuk memuat ulang data (misalnya saat ditarik ke bawah)
  Future<void> _refreshData() async {
    // Ganti baris di bawah ini dengan kode Supabase yang sebenarnya saat Anda mengaktifkannya:
    setState(() {
      // _santriStatusFuture = _apiService.getSantriStatusByWali(widget.waliId);
    });
    // Saat ini hanya menunggu sebentar untuk simulasi
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Wali'),
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

      // Menggunakan RefreshIndicator untuk memuat ulang data dengan gesture tarik
      body: RefreshIndicator(
        onRefresh: _refreshData,
        // FutureBuilder menunggu hasil data
        child: FutureBuilder<Map<String, dynamic>?>(
          future: _santriStatusFuture,
          builder: (context, snapshot) {
            // 1. Loading State
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.green),
              );
            }

            // 2. Error State
            if (snapshot.hasError) {
              return Center(
                child: Text('Terjadi error: ${snapshot.error.toString()}'),
              );
            }

            // 3. Data Kosong
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: Text(
                  'Tidak ada data santri yang terdaftar untuk akun ini.',
                ),
              );
            }

            // 4. Data Ditemukan (Success State)
            final santri = snapshot.data!;
            final lastCheckIn =
                santri['last_check_in'] as Map<String, dynamic>?;

            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                const Text(
                  'Selamat Datang, Wali!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                _buildSantriCard(santri),
                const SizedBox(height: 20),
                _buildStatusCard(lastCheckIn),
              ],
            );
          },
        ),
      ),
    );
  }

  // --- Widget Card untuk Info Santri ---
  Widget _buildSantriCard(Map<String, dynamic> santri) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              santri['nama'] ?? 'Nama Santri',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text('NIS: ${santri['nis']}', style: const TextStyle(fontSize: 16)),
            Text(
              'Wali ID: ${santri['wali_id']}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget Card untuk Status Check-In Terakhir ---
  Widget _buildStatusCard(Map<String, dynamic>? lastCheckIn) {
    // Tentukan status saat ini
    final bool isCheckedIn = lastCheckIn?['checkin_type'] == 'CHECK_IN';

    // Parsing waktu
    final DateTime? checkInTime = lastCheckIn?['created_at'] != null
        ? DateTime.parse(lastCheckIn!['created_at'])
        : null;

    final String statusText = isCheckedIn
        ? 'SUDAH KEMBALI DI PONDOK'
        : 'BELUM KEMBALI / SEDANG DI LUAR';
    final Color statusColor = isCheckedIn ? Colors.teal : Colors.redAccent;
    final String timeText = checkInTime != null
        ? DateFormat('EEEE, dd MMM yyyy HH:mm').format(checkInTime.toLocal())
        : 'Belum ada riwayat check-in.';

    return Card(
      elevation: 4,
      color: statusColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Status Terkini Santri',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const Divider(),
            Text(
              statusText,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: statusColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Terakhir Tercatat: $timeText',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Anda akan menerima notifikasi saat status berubah.',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
