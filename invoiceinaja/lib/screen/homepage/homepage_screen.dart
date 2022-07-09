import 'package:flutter/material.dart';

import '../clients/clients_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../invoices/invoices_screen.dart';
import '../settings/settings_screen.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  int indexHalaman = 0;

  List screen = [
    const DashboardScreen(),
    const InvoicesScreen(),
    const ClientsScreen(),
    const SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen.elementAt(indexHalaman),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 15,
            ),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 15,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: const Color(0xFF9B6DFF),
          unselectedItemColor: Colors.grey,
          iconSize: 30,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          currentIndex: indexHalaman,
          onTap: (value) {
            setState(() {
              indexHalaman = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
              label: "Invoices",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "Clients",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
