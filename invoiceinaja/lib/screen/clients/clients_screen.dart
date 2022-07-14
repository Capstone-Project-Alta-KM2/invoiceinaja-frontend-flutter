import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login/login_screen.dart';
import 'add_clients.dart';
import 'clinets_view_model.dart';
import 'update_client_screen.dart';

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
    final data = Provider.of<ClientsViewModel>(context);
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
                if (value.state == ClientViewState.loading)
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        color: Colors.purple,
                      ),
                    ),
                  ),
                if (value.state == ClientViewState.error)
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          value.getData().then(
                            (data) {
                              if (value.state == ClientViewState.error) {
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
                                    backgroundColor:
                                        Theme.of(context).errorColor,
                                  ),
                                );
                              }
                              if (value.state == ClientViewState.tokenExpired) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                            onPressed: () =>
                                                Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen(),
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
                                    });
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
                    ),
                  ),
                if (value.state == ClientViewState.tokenExpired)
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          value.getData().then(
                            (data) {
                              if (value.state == ClientViewState.tokenExpired) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                            onPressed: () {
                                              value.logout().then(
                                                (_) {
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginScreen(),
                                                    ),
                                                    (Route<dynamic> route) =>
                                                        false,
                                                  );
                                                },
                                              );
                                            },
                                            child: const Text(
                                              'Login Again',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
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
                    ),
                  ),
                if (value.state == ClientViewState.none)
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => value.getData(),
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          if (listData.isEmpty)
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
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
                                            'assets/images/empty-clients.png',
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
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                var dataIndex = listData[index];
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
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 4),
                                          child: Text(
                                            dataIndex.fullname!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        subtitle: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dataIndex.email!,
                                              style: const TextStyle(
                                                  color: Color(0xFF9B6DFF)),
                                            ),
                                          ],
                                        ),
                                        trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(25),
                                                      topRight:
                                                          Radius.circular(25),
                                                    ),
                                                  ),
                                                  builder: (context) {
                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          UpdateClients(
                                                                    id: dataIndex
                                                                        .id!,
                                                                    clientName:
                                                                        dataIndex
                                                                            .fullname!,
                                                                    address:
                                                                        dataIndex
                                                                            .address!,
                                                                    email: dataIndex
                                                                        .email!,
                                                                    city: dataIndex
                                                                        .city!,
                                                                    zipCode:
                                                                        dataIndex
                                                                            .zipCode!,
                                                                    company:
                                                                        dataIndex
                                                                            .company!,
                                                                  ),
                                                                ),
                                                              )
                                                                  .then(
                                                                    (value) =>
                                                                        Navigator.pop(
                                                                            context),
                                                                  )
                                                                  .then(
                                                                    (value) => data
                                                                        .getData(),
                                                                  );
                                                            },
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .white,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .purple,
                                                                      width: 5,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      const Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            8.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .edit,
                                                                      color: Colors
                                                                          .purple,
                                                                      size: 50,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    top: 20,
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    'Update Client',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .purple,
                                                                      fontSize:
                                                                          18,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              data
                                                                  .deleteClient(
                                                                      dataIndex
                                                                          .id!)
                                                                  .then(
                                                                    (value) =>
                                                                        Navigator.pop(
                                                                            context),
                                                                  );
                                                            },
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .white,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .red,
                                                                      width: 5,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      const Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            8.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .delete_sharp,
                                                                      color: Colors
                                                                          .red,
                                                                      size: 50,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    top: 20,
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    'Delete Client',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          18,
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
                                                );
                                              },
                                              child: const Icon(
                                                Icons.more_horiz,
                                                color: Colors.black,
                                                size: 25,
                                              ),
                                            ),
                                            const Text(
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
                              childCount: listData.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: data.state == ClientViewState.error ||
                data.state == ClientViewState.tokenExpired
            ? null
            : () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddClients()))
                    .then((value) => data.getData());
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
