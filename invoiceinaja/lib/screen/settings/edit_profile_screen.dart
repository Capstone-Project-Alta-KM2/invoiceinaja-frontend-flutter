import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/user_model.dart';
import 'settings_view_model.dart';

class EditProfile extends StatefulWidget {
  final String nama;
  final String company;
  final String phone;
  final String email;
  const EditProfile({
    Key? key,
    required this.nama,
    required this.company,
    required this.phone,
    required this.email,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _namaPerusahaanController = TextEditingController();
  final _noTeleponController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _namaPerusahaanController.dispose();
    _noTeleponController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _namaController.text = widget.nama;
    _namaPerusahaanController.text = widget.company;
    _noTeleponController.text = widget.phone;
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<SettingViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        title: const Text('Edit Profile'),
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
      body: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFF9B6DFF),
                    foregroundColor: Colors.white,
                    maxRadius: 50,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80'),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Change Photo',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF9B6DFF)),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text(
                                'Full Name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              child: TextFormField(
                                controller: _namaController,
                                decoration: InputDecoration(
                                  hintText: 'Name',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                validator: (name) {
                                  if (name == null || name.isEmpty) {
                                    return 'Name cannot be empty';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: const Text(
                                'Email',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                ),
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
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: const Text(
                                'Phone Number',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              child: TextFormField(
                                controller: _noTeleponController,
                                decoration: InputDecoration(
                                  hintText: 'Phone Number',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                validator: (phone) {
                                  if (phone == null || phone.isEmpty) {
                                    return 'Phone number cannot be empty';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: const Text(
                                'Company',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              child: TextFormField(
                                controller: _namaPerusahaanController,
                                decoration: InputDecoration(
                                  hintText: 'Company',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                validator: (company) {
                                  if (company == null || company.isEmpty) {
                                    return 'Company cannot be empty';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            if (data.state == SettingViewState.loading)
                              Container(
                                margin: const EdgeInsets.only(top: 30),
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(
                                  color: Colors.purple,
                                ),
                              ),
                            if (data.state != SettingViewState.loading)
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 30, bottom: 10),
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
                                    final dataUpdate = UserModel(
                                      fullname: _namaController.text,
                                      company: _namaPerusahaanController.text,
                                      email: _emailController.text,
                                      phoneNumber: _noTeleponController.text,
                                    );
                                    if (form.validate()) {
                                      data.updateUser(dataUpdate).then(
                                        (_) {
                                          if (data.state ==
                                              SettingViewState.none) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                duration:
                                                    const Duration(seconds: 1),
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
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Container(
                                                  width: double.infinity,
                                                  height: 30,
                                                  alignment: Alignment.center,
                                                  child: const Text(
                                                      "We couldn't connect to server, please try again later"),
                                                ),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .errorColor,
                                              ),
                                            );
                                          }
                                          if (data.state ==
                                              SettingViewState.error) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Container(
                                                  width: double.infinity,
                                                  height: 30,
                                                  alignment: Alignment.center,
                                                  child: const Text(
                                                      "Something went wrong, please check your connection or try again later"),
                                                ),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .errorColor,
                                              ),
                                            );
                                          }
                                          if (data.state ==
                                              SettingViewState.failed) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Container(
                                                  width: double.infinity,
                                                  height: 30,
                                                  alignment: Alignment.center,
                                                  child: const Text(
                                                      "Update failed, please check the data again"),
                                                ),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .errorColor,
                                              ),
                                            );
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
