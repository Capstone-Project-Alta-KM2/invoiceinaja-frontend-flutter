import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screen/homepage/homepage_screen.dart';
import 'screen/login/login_view_model.dart';
import 'screen/onboarding/onboarding_screen.dart';
import 'screen/register/register_view_model.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const InvoiceinAja());
}

class InvoiceinAja extends StatefulWidget {
  const InvoiceinAja({Key? key}) : super(key: key);

  @override
  State<InvoiceinAja> createState() => _InvoiceinAjaState();
}

class _InvoiceinAjaState extends State<InvoiceinAja> {
  String? token;

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'InvoiceinAja',
        theme: ThemeData(
          fontFamily: GoogleFonts.montserrat().fontFamily,
        ),
        home: token != null ? const HomepageScreen() : const OnboardingScreen(),
      ),
    );
  }

  getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      token = pref.getString("token");
    });
  }
}
