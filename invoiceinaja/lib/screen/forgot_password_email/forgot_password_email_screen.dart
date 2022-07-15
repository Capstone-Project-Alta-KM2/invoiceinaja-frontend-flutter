import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../new_password/new_password_screen.dart';

class ForgotPasswordEmail extends StatefulWidget {
  const ForgotPasswordEmail({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordEmail> createState() => _ForgotPasswordEmailState();
}

class _ForgotPasswordEmailState extends State<ForgotPasswordEmail> {
  @override
  Widget build(BuildContext context) {
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
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              width: 260,
              height: 260,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(
                    'assets/images/verifikasi-email.png',
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25, bottom: 35),
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Verified Your Email',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: const [
                        Flexible(
                          child: Text(
                            'Please enter the verification code we sent to your email address',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 70,
                          height: 75,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.black,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 21,
                            ),
                            onChanged: (i) {
                              if (i.isNotEmpty) {
                                FocusScope.of(context).nextFocus();
                              }
                              if (i.isEmpty) {
                                FocusScope.of(context).unfocus();
                              }
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          height: 75,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 21,
                            ),
                            onChanged: (i) {
                              if (i.isNotEmpty) {
                                FocusScope.of(context).nextFocus();
                              }
                              if (i.isEmpty) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          height: 75,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 21,
                            ),
                            onChanged: (i) {
                              if (i.isNotEmpty) {
                                FocusScope.of(context).nextFocus();
                              }
                              if (i.isEmpty) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          height: 75,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 21,
                            ),
                            onChanged: (i) {
                              if (i.isNotEmpty) {
                                FocusScope.of(context).nextFocus();
                              }
                              if (i.isEmpty) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NewPassword(),
                          ),
                        );
                      },
                      child: const Text(
                        'Send',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 25,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Resend Code',
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
            )
          ],
        ),
      ),
    );
  }
}
