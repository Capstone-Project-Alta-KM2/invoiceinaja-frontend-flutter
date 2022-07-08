import 'package:flutter/material.dart';
import 'package:invoiceinaja/screen/add_clients/add_clients.dart';
import 'package:provider/provider.dart';

import 'clinets_view_model.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({Key? key}) : super(key: key);

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var viewModel = Provider.of<ClientsViewModel>(context, listen: false);
      await viewModel.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<ClientsViewModel>(
        builder: (context, value, child) {
          var listData = value.listClient;
          return SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 5,
                    shadowColor: Color(0xFF9B6DFF),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'Pencarian untuk semua clients',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      if (listData.isEmpty)
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 280,
                                  height: 280,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                        'assets/images/empty-invoices.png',
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: const Text(
                                    'Add your Partner to make it easier in making invoices',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          children: listData.map(
                            (i) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                child: Card(
                                  elevation: 5,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 4),
                                    child: ListTile(
                                      leading: const Icon(Icons.people,
                                          color: Color(0xFF9B6DFF)),
                                      title: const Padding(
                                        padding: EdgeInsets.only(bottom: 4),
                                        child: Text(
                                          'Putra',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            '0812-3456-7890',
                                            style: TextStyle(
                                                color: Color(0xFF9B6DFF)),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'ilhamganteng@gmail.com',
                                            style: TextStyle(
                                                color: Color(0xFF9B6DFF)),
                                          ),
                                        ],
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Icon(
                                            Icons.more_horiz,
                                            color: Colors.black,
                                            size: 25,
                                          ),
                                          Text(
                                            'Client',
                                            style: TextStyle(
                                                color: Color(0xFF9B6DFF)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddClients()));
        },
        backgroundColor: const Color(0xFF9B6DFF),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
