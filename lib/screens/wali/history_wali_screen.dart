// lib/screens/wali/history_wali_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryWaliScreen extends StatefulWidget {
  final String waliId;

  const HistoryWaliScreen({super.key, required this.waliId});

  @override
  State<HistoryWaliScreen> createState() => _HistoryWaliScreenState();
}

class _HistoryWaliScreenState extends State<HistoryWaliScreen> {
  late Future<List<Map<String, dynamic>>> _historyFuture;

  @override
  void initState() {
    super.initState();
    // Memuat riwayat saat pertama kali layar dibuka
    _historyFuture = _fetchHistory();
  }

  // Fungsi untuk memuat riwayat (menggunakan simulasi saat ini)
  Future<List<Map<String, dynamic>>> _fetchHistory() async {
    // ------------------------------------------------------------------
    // Hapus kode simulasi di bawah ini dan aktifkan _apiService.getCheckInHistory(widget.waliId)
    // jika Anda sudah mengaktifkan Supabase di ApiService!
    // ------------------------------------------------------------------

    // SIMULASI DATA RIWAYAT
    await Future.delayed(const Duration(seconds: 1));
    return [
      {
        'nis': 'NIS2025001',
        'checkin_type': 'CHECK_IN',
        'created_at': DateTime.now()
            .subtract(const Duration(hours: 2))
            .toIso8601String(),
        'is_success': true,
      },
      {
        'nis': 'NIS2025001',
        'checkin_type': 'CHECK_OUT',
        'created_at': DateTime.now()
            .subtract(const Duration(days: 1, hours: 5))
            .toIso8601String(),
        'is_success': true,
      },
      {
        'nis': 'NIS2025001',
        'checkin_type': 'CHECK_IN',
        'created_at': DateTime.now()
            .subtract(const Duration(days: 1, hours: 23))
            .toIso8601String(),
        'is_success': true,
      },
    ];
    // ------------------------------------------------------------------

    // return _apiService.getCheckInHistory(widget.waliId); // Kode Supabase Asli
  }

  // Fungsi untuk memuat ulang data
  Future<void> _refreshHistory() async {
    setState(() {
      _historyFuture = _fetchHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Check-In Santri'),
        backgroundColor: Colors.green,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshHistory,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _historyFuture,
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
                child: Text(
                  'Terjadi error saat memuat riwayat: ${snapshot.error.toString()}',
                ),
              );
            }

            // 3. Data Kosong
            final historyList = snapshot.data ?? [];
            if (historyList.isEmpty) {
              return const Center(
                child: Text(
                  'Belum ada riwayat check-in tercatat.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            // 4. Data Ditemukan
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                final record = historyList[index];

                final bool isCheckIn = record['checkin_type'] == 'CHECK_IN';
                final DateTime timestamp = DateTime.parse(record['created_at']);

                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isCheckIn
                          ? Colors.teal
                          : Colors.deepOrange,
                      child: Icon(
                        isCheckIn ? Icons.login : Icons.logout,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      isCheckIn ? 'KEMBALI KE PONDOK' : 'KELUAR DARI PONDOK',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isCheckIn
                            ? Colors.teal[800]
                            : Colors.deepOrange[800],
                      ),
                    ),
                    subtitle: Text(
                      'NIS: ${record['nis']}\n${DateFormat('EEEE, dd MMM yyyy').format(timestamp.toLocal())}',
                    ),
                    trailing: Text(
                      DateFormat('HH:mm').format(timestamp.toLocal()),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
