import 'package:flutter/material.dart';
import 'package:invoiceinaja/screen/Login/login_screen.dart';

void main() {
  runApp(const InvoiceinAja());
}

class InvoiceinAja extends StatelessWidget {
  const InvoiceinAja({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
