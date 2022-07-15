import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoiceinaja/model/invoice_model.dart';

class DetailInvoiceScreen extends StatelessWidget {
  final int id;
  final String nama;
  final String status;
  final String invoiceDate;
  final String invoiceDueDate;
  final int amount;
  final List<Items> listItems;
  const DetailInvoiceScreen({
    Key? key,
    required this.id,
    required this.nama,
    required this.status,
    required this.invoiceDate,
    required this.invoiceDueDate,
    required this.amount,
    required this.listItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
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
                            if (status.toLowerCase() == 'unpaid')
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFFFFCC00).withOpacity(0.2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    status,
                                    style: const TextStyle(
                                      color: Color(0xFFFFCC00),
                                    ),
                                  ),
                                ),
                              ),
                            if (status.toLowerCase() == 'paid')
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF87E460).withOpacity(0.2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    status,
                                    style: const TextStyle(
                                      color: Color(0xFF87E460),
                                    ),
                                  ),
                                ),
                              ),
                            if (status.toLowerCase() == 'overdue')
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFFFF304C).withOpacity(0.2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    status,
                                    style: const TextStyle(
                                      color: Color(0xFFFF304C),
                                    ),
                                  ),
                                ),
                              ),
                            if (status.toLowerCase() == 'draft')
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    status,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
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
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Payment Total',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              formatCurrency.format(amount),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Total Product : ${listItems.length}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var dataIndex = listItems[index];
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
                  itemCount: listItems.length,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
