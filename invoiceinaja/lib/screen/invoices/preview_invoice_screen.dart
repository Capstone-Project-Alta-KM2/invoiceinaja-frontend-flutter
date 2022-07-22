import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoiceinaja/model/post_invoice_model.dart';
import 'package:invoiceinaja/screen/homepage/homepage_screen.dart';
import 'package:provider/provider.dart';

import 'invoices_view_model.dart';

class PreviewInvoice extends StatelessWidget {
  final int id;
  final String nama;
  final String alamat;
  final String email;
  final String invoiceDate;
  final String invoiceDueDate;
  final List<DetailInvoice> listDetailInvoice;
  const PreviewInvoice({
    Key? key,
    required this.id,
    required this.nama,
    required this.alamat,
    required this.email,
    required this.invoiceDate,
    required this.invoiceDueDate,
    required this.listDetailInvoice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<InvoicesViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Preview Invoice'),
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
                Card(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Invoice To',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(nama),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFCC00).withOpacity(0.2),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  top: 5,
                                  bottom: 5,
                                ),
                                child: Text(
                                  'Unpaid',
                                  style: TextStyle(color: Color(0xFFFFCC00)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Email',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(email),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Street',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(alamat)
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Invoice Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(invoiceDate)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Due Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(invoiceDueDate)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Total Product : ${listDetailInvoice.length}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var dataIndex = listDetailInvoice[index];
                    final formatCurrency =
                        NumberFormat.simpleCurrency(locale: 'id_ID');
                    final totalPrice =
                        dataIndex.quantity!.toInt() * dataIndex.price!.toInt();
                    return Card(
                      elevation: 5,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  CupertinoIcons.cube,
                                  color: Color(0xFF9B6DFF),
                                ),
                                const SizedBox(width: 20),
                                Text('${dataIndex.itemName}'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Deskripsi'),
                                Text('${dataIndex.itemName}')
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Quantity'),
                                Text('${dataIndex.quantity}'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Price'),
                                Text(formatCurrency.format(dataIndex.price)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  formatCurrency.format(totalPrice),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: listDetailInvoice.length,
                ),
                if (data.state == InvoiceViewState.loading)
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                  ),
                if (data.state != InvoiceViewState.loading)
                  Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 10),
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
                        final int totalAmount = listDetailInvoice
                            .map((e) => e.price! * e.quantity!)
                            .fold(
                                0,
                                (previousValue, element) =>
                                    previousValue + element);
                        data
                            .addInvoice(
                              PostInvoice(
                                invoice: Invoice(
                                  clientId: id,
                                  invoiceDate: invoiceDate,
                                  invoiceDue: invoiceDueDate,
                                  totalAmount: totalAmount,
                                ),
                                detailInvoice: listDetailInvoice,
                              ),
                            )
                            .then(
                              (_) => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomepageScreen(),
                                ),
                                (Route<dynamic> route) => false,
                              ),
                            );
                      },
                      child: const Text(
                        'Send Invoice',
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
