import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'screen/clients/clinets_view_model.dart';
import 'screen/dashboard/dashboard_view_model.dart';
import 'screen/homepage/homepage_screen.dart';

import 'screen/invoices/invoices_view_model.dart';
import 'screen/login/login_view_model.dart';
import 'screen/onboarding/onboarding_screen.dart';

import 'screen/register/register_view_model.dart';
import 'screen/settings/settings_view_model.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize a new Firebase App instance
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        ChangeNotifierProvider(
          create: (context) => SettingViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => InvoicesViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ClientsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DashBoardsViewModel(),
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
