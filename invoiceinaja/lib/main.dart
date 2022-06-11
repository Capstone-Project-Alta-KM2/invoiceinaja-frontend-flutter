import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invoiceinaja/screen/Login/login_screen.dart';
import 'package:invoiceinaja/screen/onboarding/onboarding_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
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
      home: const OnboardingScreen(),
    );
  }
}
