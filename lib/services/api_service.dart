// lib/services/api_service.dart

import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/checkin_data.dart';

class ApiService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<CheckInData> sendNisForVerification(String nis) async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (nis == "NIS2025001") {
      return CheckInData(
        nama: "Ahmad Fauzi (Verified by Supabase Placeholder)",
        nis: nis,
        isVerified: true,
        waktu: DateTime.now().toString().substring(11, 16),
      );
    } else {
      return CheckInData(
        nama: "Tidak Ditemukan",
        nis: nis,
        isVerified: false,
        waktu: DateTime.now().toString().substring(11, 16),
      );
    }
  }
}
