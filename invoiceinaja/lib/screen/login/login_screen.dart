import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../forgot_password/forgot_password_screen.dart';

import '../homepage/homepage_screen.dart';
import '../register/register_screen.dart';
import 'login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isRemember = false;
  bool isValid = false;
  bool isPasswordError = false;
  bool isError = false;
  bool _obscurepasswordLogin = true;

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final form = _formKey.currentState;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<LoginViewModel>(
        builder: (context, value, child) {
          return SafeArea(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width * 0.6,
                      height: 200,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(
                            'assets/images/login-image.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 35),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            'Selamat Datang Kembali !!👋',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: const Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black,
                            controller: _emailController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (email) {
                              if (email == null || email.isEmpty) {
                                return 'Email cannot be empty';
                              } else if (!RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                  .hasMatch(email)) {
                                return 'Enter email correctly';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Masukan Email Anda',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 5,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            obscureText: _obscurepasswordLogin,
                            cursorColor: Colors.black,
                            controller: _passwordController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (password) {
                              if (password.isEmpty) {
                                setState(() {
                                  isPasswordError = true;
                                });
                              } else {
                                setState(() {
                                  isError = false;
                                  isPasswordError = false;
                                });
                              }
                            },
                            validator: (password) {
                              if (password == null || password.isEmpty) {
                                return 'Password cannot be empty';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Masukan Password Anda',
                              filled: true,
                              errorText: isError ? 'Incorrect Password' : null,
                              fillColor: Colors.white,
                              // errorText: 'Password Salah',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscurepasswordLogin =
                                        !_obscurepasswordLogin;
                                  });
                                },
                                child: Icon(
                                  _obscurepasswordLogin
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: isPasswordError || isError
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 5,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: isRemember,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isRemember = value!;
                                  });
                                },
                              ),
                              const Text(
                                'Remember Me',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassword(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Lupa Password ?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF9B6DFF),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (value.state == LoginViewState.loading)
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(
                              color: Colors.purple,
                            ),
                          ),
                        if (value.state != LoginViewState.loading)
                          Container(
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
                              onPressed: form == null
                                  ? null
                                  : form.validate()
                                      ? () {
                                          final form = _formKey.currentState!;
                                          if (form.validate()) {
                                            value
                                                .login(_emailController.text,
                                                    _passwordController.text)
                                                .then(
                                              (data) {
                                                if (value.state ==
                                                    LoginViewState.none) {
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const HomepageScreen(),
                                                    ),
                                                    (Route<dynamic> route) =>
                                                        false,
                                                  );
                                                }
                                                if (value.state ==
                                                    LoginViewState
                                                        .serverTimeout) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Container(
                                                        width: double.infinity,
                                                        height: 30,
                                                        alignment:
                                                            Alignment.center,
                                                        child: const Text(
                                                            "We couldn't connect to server, please try again later"),
                                                      ),
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .errorColor,
                                                    ),
                                                  );
                                                }
                                                if (value.state ==
                                                    LoginViewState.error) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Container(
                                                        width: double.infinity,
                                                        height: 50,
                                                        alignment:
                                                            Alignment.center,
                                                        child: const Text(
                                                            "Something went wrong, please check your connection or try again later"),
                                                      ),
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .errorColor,
                                                    ),
                                                  );
                                                }
                                                if (value.state ==
                                                    LoginViewState.failed) {
                                                  setState(() {
                                                    isError = true;
                                                  });
                                                }
                                              },
                                            );
                                          }
                                        }
                                      : null,
                              child: const Text(
                                'Login',
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 25,
                    bottom: 35,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Belum Mendaftar?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return const RegisterScreen();
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                final tween = Tween(begin: 0.0, end: 1.0);
                                return ScaleTransition(
                                  scale: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: const Text(
                          'Daftar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF9B6DFF),
                          ),
                        ),
                      ),
                    ],
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
