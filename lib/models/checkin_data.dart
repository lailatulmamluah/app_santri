// lib/models/checkin_data.dart

class CheckInData {
  final String nama;
  final String nis;
  final bool isVerified;
  final String waktu; // Format: "HH:mm WIB"

  CheckInData({
    required this.nama,
    required this.nis,
    required this.isVerified,
    required this.waktu,
  });

  // Fungsi sederhana untuk membuat objek dari data JSON yang dikirim server
  factory CheckInData.fromJson(Map<String, dynamic> json) {
    return CheckInData(
      nama: json['nama_santri'] ?? 'Tidak Dikenal',
      nis: json['nis'] ?? 'NIS: 2025',
      isVerified: json['status'] == 'verified',
      waktu: json['waktu_kembali'] ?? 'XX:XX WIB',
    );
  }
}
