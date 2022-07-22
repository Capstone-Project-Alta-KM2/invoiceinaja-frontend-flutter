import 'package:flutter/material.dart';

import 'package:invoiceinaja/screen/login/login_screen.dart';
import 'package:invoiceinaja/screen/settings/reset_password_screen.dart';
import 'package:invoiceinaja/screen/settings/settings_view_model.dart';
import 'package:provider/provider.dart';

import 'edit_profile_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var viewModel = Provider.of<SettingViewModel>(context, listen: false);
      await viewModel.getDataUser().then((_) => isLoading = false);
    });
  }

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
      body: Consumer<SettingViewModel>(
        builder: (context, value, child) {
          if (isLoading) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: Colors.purple,
              ),
            );
          }
          if (value.state == SettingViewState.error) {
            return Center(
              child: GestureDetector(
                onTap: () {
                  value.getDataUser().then(
                    (data) {
                      if (value.state == SettingViewState.error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 3),
                            content: Container(
                              width: double.infinity,
                              height: 30,
                              alignment: Alignment.center,
                              child: const Text(
                                  "Unable fetch data from server, please check your connection or try again later"),
                            ),
                            backgroundColor: Theme.of(context).errorColor,
                          ),
                        );
                      }
                      if (value.state == SettingViewState.tokenExpired) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 5,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.clear_sharp,
                                  color: Colors.red,
                                  size: 80,
                                ),
                              ),
                              content: const Text(
                                'Your session has expired, please login again',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  ),
                                  child: const Text(
                                    'Login Again',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  );
                },
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 7,
                        blurRadius: 10, // changes position of shadow
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ),
            );
          }
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF9B6DFF),
                      foregroundColor: Colors.white,
                      maxRadius: 30,
                      backgroundImage:
                          NetworkImage(value.userData.avatar ?? ''),
                    ),
                    title: Text(
                      value.userData.fullname ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text('User'),
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfile(
                              avatar: value.userData.avatar ?? '',
                              nama: value.userData.fullname ?? '',
                              email: value.userData.email ?? '',
                              phone: value.userData.phoneNumber ?? '',
                              company: value.userData.company ?? '',
                            ),
                          ),
                        ).then(
                          (_) => value.getDataUser(),
                        );
                      },
                      child: const Icon(Icons.edit, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
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
                const Spacer(),
                if (value.state == SettingViewState.loading)
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                  ),
                if (value.state != SettingViewState.loading)
                  Container(
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
                        value.logout().then((data) {
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
              ],
            ),
          );
        },
      ),
    );
  }
}
