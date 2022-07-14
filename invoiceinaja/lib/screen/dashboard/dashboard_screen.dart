import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoiceinaja/screen/dashboard/dashboard_view_model.dart';
import 'package:provider/provider.dart';
import '../../model/chart_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<ChartModel> dataChart = List.generate(
    12,
    (index) => ChartModel(
      x: index,
      y1: Random().nextInt(20) + Random().nextDouble(),
      y2: Random().nextInt(20) + Random().nextDouble(),
    ),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var viewModel = Provider.of<DashBoardsViewModel>(context, listen: false);
      await viewModel.getDataOverall();
      await viewModel.getDataGraphic();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final data = Provider.of<DashBoardsViewModel>(context);
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');

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
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    elevation: 8,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    color: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.green,
                            Colors.greenAccent,
                            Colors.green.shade400,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      height: 110,
                      width: size.width * 0.455,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'Total Paid',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              'Terbayar',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              formatCurrency.format(data.overallData.paid),
                              style: const TextStyle(
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
                    child: Container(
                      height: 110,
                      width: size.width * 0.455,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.red.shade600,
                            Colors.redAccent,
                            Colors.red.shade200,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'Total Unpaid',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              'Belum Terbayar',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              formatCurrency.format(data.overallData.unpaid),
                              style: const TextStyle(
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
                        children: const [
                          Icon(
                            Icons.monetization_on,
                            color: Color(
                              0xFF9B6DFF,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Invoice Paid',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF9B6DFF),
                            ),
                          ),
                          Spacer(),
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                'Monthly',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              // child: DropdownButtonHideUnderline(
                              //   child: DropdownButton(
                              //     value: value.isEmpty ? dropItems[0] : value,
                              //     icon: const Icon(
                              //       Icons.keyboard_arrow_down_sharp,
                              //       color: Color(0xFF9B6DFF),
                              //     ),
                              //     items: dropItems.map((String items) {
                              //       return DropdownMenuItem(
                              //         value: items,
                              //         child: Text(
                              //           items,
                              //           style: const TextStyle(
                              //             fontSize: 15,
                              //           ),
                              //         ),
                              //       );
                              //     }).toList(),
                              //     onChanged: (String? newValue) {
                              //       if (newValue != null) {
                              //         setState(() {
                              //           value = newValue;
                              //         });
                              //       }
                              //     },
                              //   ),
                              // ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? size.width * 1
                              : size.width * 1.4,
                          height: 250,
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceBetween,
                              gridData: FlGridData(show: false),
                              backgroundColor: Colors.white,
                              borderData: FlBorderData(show: false),
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: _bottomTittles(),
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
                              groupsSpace: 10,
                              barGroups: data.listChart
                                  .map(
                                    (dataItem) => BarChartGroupData(
                                      x: dataItem.x,
                                      barRods: [
                                        BarChartRodData(
                                          toY: dataItem.y1,
                                          width: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.landscape
                                              ? 24
                                              : 16,
                                          color: const Color(0xFF9B6DFF),
                                        ),
                                        BarChartRodData(
                                          toY: dataItem.y2,
                                          width: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.landscape
                                              ? 24
                                              : 16,
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
                      if (data.listInvoiceActivities.isEmpty)
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(
                            top: 40,
                            bottom: 65,
                          ),
                          child: const Text(
                            'Activities masih kosong',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      Column(
                        children: data.listInvoiceActivities.map((i) {
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
                              i.namaclient!,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              i.tanggalinvoices!,
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
                                  i.totalinvoices!,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  i.statuspembayaran!,
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

  SideTitles _bottomTittles() {
    return SideTitles(
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
          case 6:
            text = const Text(
              'JUL',
              style: style,
            );
            break;
          case 7:
            text = const Text(
              'AUG',
              style: style,
            );
            break;
          case 8:
            text = const Text(
              'SEP',
              style: style,
            );
            break;

          case 9:
            text = const Text(
              'OCT',
              style: style,
            );
            break;
          case 10:
            text = const Text(
              'NOV',
              style: style,
            );
            break;
          case 11:
            text = const Text(
              'DES',
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
          space: 8,
          child: text,
        );
      },
    );
  }
}
