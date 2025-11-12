import 'package:flutter/material.dart';
// Import screens Admin Anda di sini
import 'chekcin_qr_screen.dart';
import 'home_screen.dart'; // Asumsi ini adalah Dashboard Admin
import 'profile_admin_screen.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _selectedIndex = 0;

  // GANTI DENGAN WIDGET ADMIN ASLI ANDA
  static const List<Widget> _adminWidgetOptions = <Widget>[
    // Halaman 0: Scan QR
    Center(child: Text('Scan QR / Check-In', style: TextStyle(fontSize: 24))),
    // Halaman 1: Kelola Data Santri
    Center(child: Text('Kelola Data Santri', style: TextStyle(fontSize: 24))),
    // Halaman 2: Pengaturan Akun Admin
    Center(child: Text('Pengaturan Admin', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Console'),
        backgroundColor: Colors.indigo,
      ),
      body: _adminWidgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.storage), label: 'Data'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
