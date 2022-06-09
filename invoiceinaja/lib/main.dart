import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invoiceinaja/screen/Login/login_screen.dart';

void main() {
  runApp(const InvoiceinAja());
}

class InvoiceinAja extends StatelessWidget {
  const InvoiceinAja({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InvoiceinAja',
      theme: ThemeData(
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      home: const LoginScreen(),
    );
  }
}
