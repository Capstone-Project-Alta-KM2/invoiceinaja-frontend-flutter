import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:invoiceinaja/model/chart_model.dart';
import '../../model/invoices_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String value = '';
  var dropItems = [
    'Monthly',
    'Weekly',
  ];

  final List<ChartModel> dataChart = List.generate(
    6,
    (index) => ChartModel(
      x: index,
      y1: Random().nextInt(20) + Random().nextDouble(),
      y2: Random().nextInt(20) + Random().nextDouble(),
    ),
  );

  final List<InvoicesModel> dataInvoices = List.generate(
    6,
    (index) => InvoicesModel(
      namaClient: "Ilham Ganteng",
      tanggalInvoices: "July 03, 2022",
      totalInvoices: "Rp 2.500.000",
      statusPembayaran: "Unpaid",
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 10),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/logo-invoiceinaja.png',
                  ),
                ),
              ),
            ),
            const Text(
              'InvoiceinAja',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.black,
              size: 32,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Card(
                    elevation: 8,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    color: Colors.white,
                    child: SizedBox(
                      height: 100,
                      width: 180,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Paid',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff87E460)
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      '+25%',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff87E460),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              'Terbayar',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              'Rp. 25.000.000',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 8,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    color: Colors.white,
                    child: SizedBox(
                      height: 100,
                      width: 180,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Unpaid',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      '-25%',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              'Belum Terbayar',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              'Rp. 25.000.000',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Card(
                elevation: 8,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.monetization_on,
                            color: Color(
                              0xFF9B6DFF,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Invoice Paid',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF9B6DFF),
                            ),
                          ),
                          const Spacer(),
                          Card(
                            elevation: 2,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 5,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: value.isEmpty ? dropItems[0] : value,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: Color(0xFF9B6DFF),
                                  ),
                                  items: dropItems.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        value = newValue;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 250,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.center,
                            gridData: FlGridData(show: false),
                            backgroundColor: Colors.white,
                            borderData: FlBorderData(show: false),
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (data, meta) {
                                    const style = TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    );
                                    Widget text;
                                    switch (data.toInt()) {
                                      case 0:
                                        text = const Text('JAN', style: style);
                                        break;
                                      case 1:
                                        text = const Text(
                                          'FEB',
                                          style: style,
                                        );
                                        break;
                                      case 2:
                                        text = const Text(
                                          'MAR',
                                          style: style,
                                        );
                                        break;
                                      case 3:
                                        text = const Text(
                                          'APR',
                                          style: style,
                                        );
                                        break;
                                      case 4:
                                        text = const Text(
                                          'MAY',
                                          style: style,
                                        );
                                        break;
                                      case 5:
                                        text = const Text(
                                          'JUN',
                                          style: style,
                                        );
                                        break;
                                      default:
                                        text = const Text(
                                          '',
                                          style: style,
                                        );
                                        break;
                                    }
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      space: 4,
                                      child: text,
                                    );
                                  },
                                ),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                            ),
                            groupsSpace: 20,
                            barGroups: dataChart
                                .map(
                                  (dataItem) => BarChartGroupData(
                                    x: dataItem.x,
                                    barRods: [
                                      BarChartRodData(
                                        toY: dataItem.y1,
                                        width: 16,
                                        color: const Color(0xFF9B6DFF),
                                      ),
                                      BarChartRodData(
                                        toY: dataItem.y2,
                                        width: 16,
                                        color: const Color(0xFF9B6DFF)
                                            .withOpacity(0.2),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Card(
                elevation: 8,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Invoices Activities',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Column(
                        children: dataInvoices.map((i) {
                          return ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF9B6DFF).withOpacity(0.2),
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
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
