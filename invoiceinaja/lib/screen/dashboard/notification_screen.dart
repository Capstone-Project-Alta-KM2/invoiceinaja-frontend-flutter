import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Recent Activities'),
        centerTitle: true,
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  child: const Text(
                    'Today',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.2),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Icon(
                                CupertinoIcons.square_list,
                                size: 26,
                                color: Colors.blue,
                              )),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text('New Invoice Created'),
                        ],
                      ),
                      const Text('#00132412'),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Icon(
                                CupertinoIcons.money_dollar_circle,
                                size: 26,
                                color: Colors.green,
                              )),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text('Invoice Paid #00132412'),
                        ],
                      ),
                      const Text('+Rp.200.000'),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.2),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Icon(
                                CupertinoIcons.square_list,
                                size: 26,
                                color: Colors.blue,
                              )),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text('New Invoice Created'),
                        ],
                      ),
                      const Text('#00132412'),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Icon(
                                CupertinoIcons.money_dollar_circle,
                                size: 26,
                                color: Colors.green,
                              )),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text('Invoice Paid #00132412'),
                        ],
                      ),
                      const Text('+Rp.200.000'),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: const Text(
                    'Yesterday',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.2),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Icon(
                                CupertinoIcons.square_list,
                                size: 26,
                                color: Colors.blue,
                              )),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text('New Invoice Created'),
                        ],
                      ),
                      const Text('#00132412'),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Icon(
                                CupertinoIcons.money_dollar_circle,
                                size: 26,
                                color: Colors.green,
                              )),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text('Invoice Paid #00132412'),
                        ],
                      ),
                      const Text('+Rp.200.000'),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.2),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Icon(
                                CupertinoIcons.square_list,
                                size: 26,
                                color: Colors.blue,
                              )),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text('New Invoice Created'),
                        ],
                      ),
                      const Text('#00132412'),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Icon(
                                CupertinoIcons.money_dollar_circle,
                                size: 26,
                                color: Colors.green,
                              )),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text('Invoice Paid #00132412'),
                        ],
                      ),
                      const Text('+Rp.200.000'),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
