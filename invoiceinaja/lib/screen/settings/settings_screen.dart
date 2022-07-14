import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceinaja/screen/edit_profile/edit_profile_screen.dart';
import 'package:invoiceinaja/screen/login/login_screen.dart';
import 'package:invoiceinaja/screen/reset_password/reset_password_screen.dart';
import 'package:invoiceinaja/screen/settings/settings_view_model.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        title: const Text('Settings'),
        centerTitle: true,
        // iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 16),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFF9B6DFF),
                foregroundColor: Colors.white,
                maxRadius: 30,
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80'),
              ),
              title: const Text(
                'Ilham Ganteng',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('User'),
              trailing: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfile()));
                },
                child: const Icon(Icons.edit, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ResetPassword()));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                title: Text('Change Password'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Consumer<SettingViewModel>(
            builder: (context, value, child) {
              return SafeArea(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(20),
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
        ],
      ),
    );
  }
}
