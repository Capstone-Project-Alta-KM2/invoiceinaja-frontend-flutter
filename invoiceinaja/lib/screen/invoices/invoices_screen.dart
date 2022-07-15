import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoiceinaja/screen/invoices/create_invoice_screen.dart';
import 'package:invoiceinaja/screen/invoices/detail_invoice_screen.dart';
import 'package:provider/provider.dart';

import '../login/login_screen.dart';
import 'invoices_view_model.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({Key? key}) : super(key: key);

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var viewModel = Provider.of<InvoicesViewModel>(context, listen: false);
      await viewModel.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final data = Provider.of<InvoicesViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<InvoicesViewModel>(
        builder: (context, value, child) {
          if (value.state == InvoiceViewState.loading) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: Colors.purple,
              ),
            );
          }
          if (value.state != InvoiceViewState.none &&
              value.state != InvoiceViewState.loading) {
            return Center(
              child: GestureDetector(
                onTap: () {
                  value.getData().then(
                    (data) {
                      if (value.state == InvoiceViewState.error) {
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
                            backgroundColor: Theme.of(context).errorColor,
                          ),
                        );
                      }
                      if (value.state == InvoiceViewState.tokenExpired) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
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
                                  onPressed: () => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
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
                          },
                        );
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
            );
          }
          return SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Material(
                        elevation: 5,
                        shadowColor: Color(0xFF9B6DFF),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: 'Pencarian untuk semua invoice',
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
                      const SizedBox(
                        height: 25,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: value.listTitle.map(
                            (data) {
                              var index = value.listTitle.indexOf(data);
                              return GestureDetector(
                                onTap: () {
                                  _controller.animateToPage(
                                    index,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeIn,
                                  );
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeIn,
                                  alignment: Alignment.center,
                                  width: 80,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 3,
                                        color: _currentPage == index
                                            ? Colors.purpleAccent
                                            : Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    data,
                                    style: TextStyle(
                                      color: _currentPage == index
                                          ? Colors.purpleAccent
                                          : Colors.grey,
                                      fontWeight: FontWeight.bold,
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
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: value.listAllInvoice.length,
                    onPageChanged: (int index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      var dataList = value.listAllInvoice[index];
                      if (value.state == InvoiceViewState.loading) {
                        return Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            color: Colors.purple,
                          ),
                        );
                      }
                      if (value.state == InvoiceViewState.error) {
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              value.getData().then(
                                (data) {
                                  if (value.state == InvoiceViewState.error) {
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
                                  if (value.state ==
                                      InvoiceViewState.tokenExpired) {
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
                                                    Navigator
                                                        .pushAndRemoveUntil(
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
                                      },
                                    );
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
                                    blurRadius:
                                        10, // changes position of shadow
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
                        );
                      }
                      if (value.state == InvoiceViewState.tokenExpired) {
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              value.getData().then(
                                (data) {
                                  if (value.state ==
                                      InvoiceViewState.tokenExpired) {
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
                                      },
                                    );
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
                                    blurRadius:
                                        10, // changes position of shadow
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
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: () => value.getData(),
                        child: CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          slivers: [
                            if (dataList.isEmpty)
                              SliverFillRemaining(
                                hasScrollBody: false,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          'Buat Invoice Anda terlihat Profesional dan kirim melalui Email',
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
                                children: dataList.map((i) {
                                  final formatCurrency =
                                      NumberFormat.simpleCurrency(
                                          locale: 'id_ID');
                                  return Container(
                                    margin: const EdgeInsets.all(10.0),
                                    child: Card(
                                      elevation: 8,
                                      shadowColor: const Color(0xFF9B6DFF),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            20.0,
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          left: 8,
                                          right: 8,
                                          top: 15,
                                          bottom: 15,
                                        ),
                                        child: ListTile(
                                          leading: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: const Color(0xFF9B6DFF)
                                                  .withOpacity(0.2),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Icon(
                                                Icons.receipt_outlined,
                                                color: Color(0xFF9B6DFF),
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                          title: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(
                                              i.client!,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 5),
                                                child: Text(
                                                  DateFormat.yMMMMd().format(
                                                      DateFormat('yyyy-MM-dd')
                                                          .parse(i.postDue!)),
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                formatCurrency.format(i.amount),
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          trailing: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
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
                                                        margin: const EdgeInsets
                                                            .all(20),
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
                                                                            DetailInvoiceScreen(
                                                                      id: i.id!,
                                                                      nama: i
                                                                          .client!,
                                                                      invoiceDate:
                                                                          i.date!,
                                                                      invoiceDueDate:
                                                                          i.postDue!,
                                                                      amount: i
                                                                          .amount!,
                                                                      status: i
                                                                          .status!,
                                                                      listItems:
                                                                          i.items!,
                                                                    ),
                                                                  ),
                                                                )
                                                                    .then(
                                                                      (value) =>
                                                                          Navigator.pop(
                                                                              context),
                                                                    )
                                                                    .then(
                                                                      (value) =>
                                                                          data.getData(),
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
                                                                        width:
                                                                            5,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .newspaper_sharp,
                                                                        color: Colors
                                                                            .purple,
                                                                        size:
                                                                            50,
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
                                                                      'Preview Invoice',
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
                                                                    .deleteInvoice(
                                                                        i.id!)
                                                                    .then(
                                                                      (value) =>
                                                                          Navigator.pop(
                                                                              context),
                                                                    )
                                                                    .then((_) =>
                                                                        value
                                                                            .getData());
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
                                                                        width:
                                                                            5,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .delete_sharp,
                                                                        color: Colors
                                                                            .red,
                                                                        size:
                                                                            50,
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
                                                                      'Delete Invoice',
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
                                              if (i.status == 'Paid' ||
                                                  i.status == 'PAID')
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                              0xFF87E460)
                                                          .withOpacity(0.2),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 15,
                                                        right: 15,
                                                        top: 5,
                                                        bottom: 5,
                                                      ),
                                                      child: Text(
                                                        i.status!,
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Color(0xFF87E460),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              if (i.status == 'Unpaid' ||
                                                  i.status == 'UNPAID')
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                              0xFFFFCC00)
                                                          .withOpacity(0.2),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 15,
                                                        right: 15,
                                                        top: 5,
                                                        bottom: 5,
                                                      ),
                                                      child: Text(
                                                        i.status!,
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Color(0xFFFFCC00),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              if (i.status == 'Overdue' ||
                                                  i.status == 'OVERDUE')
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                              0xFFFF304C)
                                                          .withOpacity(0.2),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 15,
                                                        right: 15,
                                                        top: 5,
                                                        bottom: 5,
                                                      ),
                                                      child: Text(
                                                        i.status!,
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Color(0xFFFF304C),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: data.state == InvoiceViewState.error ||
                data.state == InvoiceViewState.tokenExpired
            ? null
            : () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateInvoice()));
              },
        backgroundColor: const Color(0xFF9B6DFF),
        elevation: 8,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
