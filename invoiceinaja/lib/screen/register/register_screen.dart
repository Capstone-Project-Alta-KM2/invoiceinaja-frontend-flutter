import 'package:flutter/material.dart';
import 'package:invoiceinaja/model/user_model.dart';
import 'package:provider/provider.dart';

import '../login/login_screen.dart';
import 'register_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isPasswordError = false;
  bool _obscurepasswordRegister = true;

  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _namaPerusahaanController = TextEditingController();
  final _noTeleponController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _namaPerusahaanController.dispose();
    _noTeleponController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final data = Provider.of<RegisterViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 35,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
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
                        'assets/images/register-image.png',
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
                      margin: const EdgeInsets.only(top: 40),
                      child: const Text(
                        'Daftar ke InvoiceinAja',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: const Text(
                        'Nama Anda',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        controller: _namaController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (name) {
                          if (name == null || name.isEmpty) {
                            return 'Name cannot be empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Masukan Nama Lengkap Anda',
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
                        'Nama Perusahaan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        controller: _namaPerusahaanController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (company) {
                          if (company == null || company.isEmpty) {
                            return 'Company cannot be empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Masukan Nama Perusahaan Anda',
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return 'email cannot be empty';
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
                        'Nomor Handphone',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        controller: _noTeleponController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (phone) {
                          if (phone == null || phone.isEmpty) {
                            return 'Phone cannot be empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Masukan No. Handphone Anda',
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
                        cursorColor: Colors.black,
                        obscureText: _obscurepasswordRegister,
                        controller: _passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (password) {
                          if (password.isEmpty) {
                            setState(() {
                              isPasswordError = true;
                            });
                          } else if (password.length < 8) {
                            setState(() {
                              isPasswordError = true;
                            });
                          } else if (!RegExp(r'[a-z]').hasMatch(password)) {
                            setState(() {
                              isPasswordError = true;
                            });
                          } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
                            setState(() {
                              isPasswordError = true;
                            });
                          } else {
                            setState(() {
                              isPasswordError = false;
                            });
                          }
                        },
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
                        decoration: InputDecoration(
                          hintText: 'Masukan Password Anda',
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscurepasswordRegister =
                                    !_obscurepasswordRegister;
                              });
                            },
                            child: Icon(
                              _obscurepasswordRegister
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color:
                                  isPasswordError ? Colors.red : Colors.black,
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
                    if (data.state == RegisterViewState.loading)
                      Container(
                        margin: const EdgeInsets.only(
                          top: 30,
                          bottom: 35,
                        ),
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          color: Colors.purple,
                        ),
                      ),
                    if (data.state != RegisterViewState.loading)
                      Container(
                        margin: const EdgeInsets.only(
                          top: 30,
                          bottom: 35,
                        ),
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
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            final form = _formKey.currentState!;
                            if (form.validate()) {
                              final dataRegister = UserModel(
                                fullname: _namaController.text,
                                company: _namaPerusahaanController.text,
                                email: _emailController.text,
                                phoneNumber: _noTeleponController.text,
                                password: _passwordController.text,
                              );
                              data.register(dataRegister).then(
                                (value) {
                                  if (data.state == RegisterViewState.none) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 1),
                                        content: Container(
                                          width: double.infinity,
                                          height: 30,
                                          alignment: Alignment.center,
                                          child: const Text(
                                            "Register Succesfully",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        backgroundColor: Colors.purple,
                                      ),
                                    );
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                      (Route<dynamic> route) => false,
                                    );
                                  }
                                  if (data.state ==
                                      RegisterViewState.serverTimeout) {
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
                                  if (data.state == RegisterViewState.error) {
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
                                  if (data.state == RegisterViewState.failed) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Container(
                                          width: double.infinity,
                                          height: 30,
                                          alignment: Alignment.center,
                                          child: const Text(
                                              "Register failed, please check the data again"),
                                        ),
                                        backgroundColor:
                                            Theme.of(context).errorColor,
                                      ),
                                    );
                                  }
                                },
                              );
                            }
                          },
                          child: const Text(
                            'Daftar',
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
