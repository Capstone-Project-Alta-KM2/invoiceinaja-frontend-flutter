import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceinaja/model/invoices_model.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({Key? key}) : super(key: key);

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  bool all = true, paid = false, unpaid = false, draft = false, overdue = false;
  final _controller = PageController();
  int _currentPage = 0;

  List<String> dataTitle = [
    'All',
    'Paid',
    'Unpaid',
    'Draft',
    'Overdue',
  ];

  List<String> dataHalaman = [
    'Halaman All',
    'Halaman Paid',
    'Halaman Unpaid',
    'Halaman Draft',
    'Halaman Overdue',
  ];

  List<List<InvoicesModel>> dataInvoices = [
    [
      InvoicesModel(
        namaClient: 'Ferdi',
        tanggalInvoices: 'June 26, 2022',
        totalInvoices: '2.000.000',
        statusPembayaran: 'Paid',
      ),
      InvoicesModel(
        namaClient: 'Ahmad',
        tanggalInvoices: 'July 11, 2022',
        totalInvoices: '1.500.000',
        statusPembayaran: 'Paid',
      ),
      InvoicesModel(
        namaClient: 'Mauladi',
        tanggalInvoices: 'August 01, 2022',
        totalInvoices: '3.000.000',
        statusPembayaran: 'Paid',
      ),
      InvoicesModel(
        namaClient: 'Robert',
        tanggalInvoices: 'July 10, 2022',
        totalInvoices: '1.000.000',
        statusPembayaran: 'Unpaid',
      ),
      InvoicesModel(
        namaClient: 'Tony',
        tanggalInvoices: 'June 29, 2022',
        totalInvoices: '2.500.000',
        statusPembayaran: 'Unpaid',
      ),
    ],
    [
      InvoicesModel(
        namaClient: 'Ferdi',
        tanggalInvoices: 'June 26, 2022',
        totalInvoices: '2.000.000',
        statusPembayaran: 'Paid',
      ),
      InvoicesModel(
        namaClient: 'Ahmad',
        tanggalInvoices: 'July 11, 2022',
        totalInvoices: '1.500.000',
        statusPembayaran: 'Paid',
      ),
      InvoicesModel(
        namaClient: 'Mauladi',
        tanggalInvoices: 'August 01, 2022',
        totalInvoices: '3.000.000',
        statusPembayaran: 'Paid',
      ),
    ],
    [
      InvoicesModel(
        namaClient: 'Robert',
        tanggalInvoices: 'July 10, 2022',
        totalInvoices: '1.000.000',
        statusPembayaran: 'Unpaid',
      ),
      InvoicesModel(
        namaClient: 'Tony',
        tanggalInvoices: 'June 29, 2022',
        totalInvoices: '2.500.000',
        statusPembayaran: 'Unpaid',
      ),
    ],
    [],
    [],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
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
                      children: dataTitle.map(
                        (data) {
                          var index = dataTitle.indexOf(data);
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
                itemCount: dataInvoices.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  var dataList = dataInvoices[index];
                  return CustomScrollView(
                    slivers: [
                      if (dataList.isEmpty)
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
                            return Card(
                              child: ListTile(
                                leading: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xFF9B6DFF)
                                        .withOpacity(0.2),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.receipt_outlined,
                                      color: Color(0xFF9B6DFF),
                                      size: 25,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  i.namaClient,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  i.tanggalInvoices,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      i.totalInvoices,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      i.statusPembayaran,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
