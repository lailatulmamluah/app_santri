// lib/services/api_service.dart

import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/checkin_data.dart';

const String supabaseUrl =
    'https://hxwmveeczwuagymmysis.supabase.co'; // GANTI DENGAN URL ASLI ANDA
const String supabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh4d212ZWVjend1YWd5bW15c2lzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjMzMzU2MTYsImV4cCI6MjA3ODkxMTYxNn0.nDsrWK-mDhn_-db0N3gUEkIdTBf59wMkdz7KpH666iA'; // GANTI DENGAN ANONYMOUS KEY ASLI ANDA

class ApiService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  static Future<void> initializeSupabase() async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut(); // Jika ini yang menyebabkan error
  }

  // --- FUNGSI NYATA: Verifikasi NIS (Admin QR Scan) ---
  Future<CheckInData> sendNisForVerification(String nis) async {
    // 1. Cari Santri berdasarkan NIS
    try {
      final List<Map<String, dynamic>> santriData = await _supabaseClient
          .from('santri')
          .select('id, nama')
          .eq('nis', nis)
          .limit(1);

      if (santriData.isEmpty) {
        // Santri tidak ditemukan di database
        return CheckInData(
          nama: "Santri Tidak Terdaftar",
          nis: nis,
          isVerified: false,
          waktu: "",
        );
      }

      final int santriId = santriData.first['id'] as int;
      final String santriNama = santriData.first['nama'] as String;

      // 2. Tentukan jenis absen (Check-in atau Check-out)
      // Query riwayat absen terakhir untuk santri ini
      final List<Map<String, dynamic>> lastEntry = await _supabaseClient
          .from('riwayat_absen')
          .select('check_in_type')
          .eq('santri_id', santriId)
          .order('created_at', ascending: false)
          .limit(1);

      // Jika riwayat kosong atau check-out terakhir, maka jenisnya adalah CHECK_IN
      final String newCheckInType =
          (lastEntry.isEmpty || lastEntry.first['check_in_type'] == 'CHECK_OUT')
          ? 'CHECK_IN'
          : 'CHECK_OUT';

      // 3. Masukkan entri baru ke tabel riwayat_absen
      final Map<String, dynamic> newEntry = {
        'santri_id': santriId,
        'check_in_type': newCheckInType,
        // Tambahkan admin_id yang mencatat, jika diperlukan
      };

      await _supabaseClient.from('riwayat_absen').insert(newEntry);

      // 4. Kembalikan data hasil sukses
      return CheckInData(
        nama: santriNama,
        nis: nis,
        isVerified: true,
        waktu: DateTime.now().toString().substring(11, 16),
      );
    } on PostgrestException catch (e) {
      // Tangani error database Supabase
      throw Exception('Database Error: ${e.message}');
    } catch (e) {
      // Tangani error umum lainnya
      throw Exception('Gagal memproses verifikasi: ${e.toString()}');
    }
  }
}// ... (Sisa class ApiService) ...