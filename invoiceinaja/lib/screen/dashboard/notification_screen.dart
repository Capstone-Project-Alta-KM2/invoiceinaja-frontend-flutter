import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invoiceinaja/screen/dashboard/dashboard_view_model.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var viewModel = Provider.of<DashBoardsViewModel>(context, listen: false);
      await viewModel.getDataNotifications();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DashBoardsViewModel>(context);
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            children: [
              if (data.listToday.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  child: const Text(
                    'Today',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              if (data.listToday.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.listToday.length,
                  itemBuilder: (context, index) {
                    var listTodayIndex = data.listToday[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
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
                                  child: Icon(
                                    listTodayIndex.message!
                                            .toLowerCase()
                                            .contains('client')
                                        ? CupertinoIcons.person_crop_square
                                        : CupertinoIcons.square_list,
                                    size: 26,
                                    color: listTodayIndex.message!
                                            .toLowerCase()
                                            .contains('client')
                                        ? Colors.purple
                                        : Colors.blue,
                                  )),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(listTodayIndex.message!),
                            ],
                          ),
                          Text(listTodayIndex.message!
                                  .toLowerCase()
                                  .contains('client')
                              ? '#USR - ${listTodayIndex.idInvoice}'
                              : '#INV - ${listTodayIndex.idInvoice}'),
                        ],
                      ),
                    );
                  },
                ),
              if (data.listYesterday.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: const Text(
                    'Yesterday',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              if (data.listYesterday.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.listYesterday.length,
                  itemBuilder: (context, index) {
                    var listIndex = data.listYesterday[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
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
                                  child: Icon(
                                    listIndex.message!
                                            .toLowerCase()
                                            .contains('client')
                                        ? CupertinoIcons.person_crop_square
                                        : CupertinoIcons.square_list,
                                    size: 26,
                                    color: listIndex.message!
                                            .toLowerCase()
                                            .contains('client')
                                        ? Colors.purple
                                        : Colors.blue,
                                  )),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(listIndex.message!),
                            ],
                          ),
                          Text(listIndex.message!
                                  .toLowerCase()
                                  .contains('client')
                              ? '#USR - ${listIndex.idInvoice}'
                              : '#INV - ${listIndex.idInvoice}'),
                        ],
                      ),
                    );
                  },
                ),
              if (data.listLater.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: const Text(
                    'A later than yesterday',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              if (data.listLater.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.listLater.length,
                  itemBuilder: (context, index) {
                    var listIndex = data.listLater[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
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
                                  child: Icon(
                                    listIndex.message!
                                            .toLowerCase()
                                            .contains('client')
                                        ? CupertinoIcons.person_crop_square
                                        : CupertinoIcons.square_list,
                                    size: 26,
                                    color: listIndex.message!
                                            .toLowerCase()
                                            .contains('client')
                                        ? Colors.purple
                                        : Colors.blue,
                                  )),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(listIndex.message!),
                            ],
                          ),
                          Text(listIndex.message!
                                  .toLowerCase()
                                  .contains('client')
                              ? '#USR - ${listIndex.idInvoice}'
                              : '#INV - ${listIndex.idInvoice}'),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
