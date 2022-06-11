import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceinaja/model/onboarding_model.dart';
import 'package:invoiceinaja/screen/login/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var _controller = PageController();
  int? _currentPage = 0;

  List<OnboardingModel> dataOnboard = [
    OnboardingModel(
      image: 'assets/images/onboarding-image-1.png',
      title: 'Ayo mudahkan bisnis kamu bersama Invoicein Aja',
      subtitle:
          'Buat invoice, data pembayaran client dan uang yang masuk jadi lebih rinci',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding-image-2.png',
      title: 'One Click Share melalui Email',
      subtitle:
          'Kirim invoice hanya dengan sekali click melalui email dijamin lebih cepat.',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding-image-3.png',
      title: 'Digital Payment untuk dapat pelunasan lebih cepat',
      subtitle:
          'Berbagai pilihan metode pembayaran mulai dari Kartu Kredit, Virtual Account, dan Bank Transfer akan memudahkan untuk melunasi invoice',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            if (_currentPage != 2)
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.only(left: 15, right: 15),
                alignment: Alignment.centerRight,
                child: const Text(
                  'Skipp',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9B6DFF),
                  ),
                ),
              ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: dataOnboard.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 280,
                              height: 280,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                    dataOnboard[index].image,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 15, bottom: 20),
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(
                                    dataOnboard[index].title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      dataOnboard[index].subtitle,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 25),
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_currentPage == 2)
                    Flexible(
                      child: SizedBox(
                        height: 45,
                        width: double.infinity,
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
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: const Text(
                            'Get Started',
                          ),
                        ),
                      ),
                    ),
                  if (_currentPage != 2)
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: const ExpandingDotsEffect(
                        activeDotColor: Color(0xFF9B6DFF),
                        dotColor: Colors.grey,
                        expansionFactor: 2.5,
                        dotHeight: 14,
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
