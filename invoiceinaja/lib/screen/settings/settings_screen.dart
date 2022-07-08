import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceinaja/screen/login/login_screen.dart';
import 'package:invoiceinaja/screen/settings/settings_view_model.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<SettingViewModel>(
        builder: (context, value, child) {
          return SafeArea(
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF9B6DFF),
                    onSurface: const Color(0xFF9B6DFF),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    value.logout().then((value) {
                      if (value.state == SettingViewState.none) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      }
                    });
                  },
                  child: value.state == SettingViewState.loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Logout',
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
