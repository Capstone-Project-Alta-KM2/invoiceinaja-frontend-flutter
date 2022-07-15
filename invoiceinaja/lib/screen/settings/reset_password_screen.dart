import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'settings_view_model.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();

  bool isPasswordError = false;
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmNewPassword = true;
  bool isError = false;

  final _oldPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<SettingViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        title: const Text('Reset Password'),
        centerTitle: true,
        // iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 24,
          ),
        ),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 16),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const Text(
                      'Enter Old Password',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: TextFormField(
                      obscureText: _obscureOldPassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _oldPasswordController,
                      onChanged: (data) {
                        setState(() {
                          isError = false;
                        });
                      },
                      decoration: InputDecoration(
                        errorText: isError ? 'Incorrect Old Password' : null,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureOldPassword = !_obscureOldPassword;
                            });
                          },
                          child: Icon(
                            _obscureOldPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: isPasswordError ? Colors.red : Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      validator: (data) {
                        if (data == null || data.isEmpty) {
                          return 'Old password cannot be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text(
                      'Enter New Password',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: TextFormField(
                      obscureText: _obscureNewPassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureNewPassword = !_obscureNewPassword;
                            });
                          },
                          child: Icon(
                            _obscureNewPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: isPasswordError ? Colors.red : Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      validator: (password) {
                        if (password == null || password.isEmpty) {
                          return 'Password cannot be empty';
                        } else if (password.length < 8) {
                          return 'Must be at least 8 characters long';
                        } else if (!RegExp(r'[a-z]').hasMatch(password)) {
                          return 'Include at least 1 lowercase letter';
                        } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
                          return 'Include at least 1 uppercase letter';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text(
                      'Confirm New Password',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: TextFormField(
                      obscureText: _obscureConfirmNewPassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureConfirmNewPassword =
                                  !_obscureConfirmNewPassword;
                            });
                          },
                          child: Icon(
                            _obscureConfirmNewPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: isPasswordError ? Colors.red : Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      validator: (data) {
                        if (data == null || data.isEmpty) {
                          return 'New password cannot be empty';
                        } else if (data != _passwordController.text) {
                          return 'Password does not match';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 10),
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF9B6DFF),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        final form = _formKey.currentState!;
                        if (form.validate()) {
                          data
                              .changePassword(_oldPasswordController.text,
                                  _passwordController.text)
                              .then(
                            (_) {
                              if (data.state == SettingViewState.none) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(seconds: 1),
                                    content: Container(
                                      width: double.infinity,
                                      height: 30,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Update Succesfully",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    backgroundColor: Colors.purple,
                                  ),
                                );
                                Navigator.pop(context);
                              }
                              if (data.state ==
                                  SettingViewState.serverTimeout) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Container(
                                      width: double.infinity,
                                      height: 30,
                                      alignment: Alignment.center,
                                      child: const Text(
                                          "We couldn't connect to server, please try again later"),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).errorColor,
                                  ),
                                );
                              }
                              if (data.state == SettingViewState.error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Container(
                                      width: double.infinity,
                                      height: 30,
                                      alignment: Alignment.center,
                                      child: const Text(
                                          "Something went wrong, please check your connection or try again later"),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).errorColor,
                                  ),
                                );
                              }
                              if (data.state == SettingViewState.failed) {
                                setState(() {
                                  isError = true;
                                });
                              }
                            },
                          );
                        }
                      },
                      child: const Text(
                        'Save',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
