// lib/screens/wali/wali_main_screen.dart

import 'package:flutter/material.dart';
import 'dashboard_wali_screen.dart';
import 'history_wali_screen.dart';
import 'package:e_santri/screens/admin/login_screen.dart';

class WaliMainScreen extends StatefulWidget {
  final String waliId;

  const WaliMainScreen({super.key, required this.waliId});

  @override
  State<WaliMainScreen> createState() => _WaliMainScreenState();
}

class _WaliMainScreenState extends State<WaliMainScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _waliWidgetOptions;

  @override
  void initState() {
    super.initState();
    _waliWidgetOptions = <Widget>[
      DashboardWaliScreen(waliId: widget.waliId),
      HistoryWaliScreen(waliId: widget.waliId),
      const Center(child: Text('Profile Wali', style: TextStyle(fontSize: 24))),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wali Console'),
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
      body: _waliWidgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
