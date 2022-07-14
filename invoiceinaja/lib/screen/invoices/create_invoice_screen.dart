import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoiceinaja/model/client_model.dart';
import 'package:invoiceinaja/screen/invoices/add_product_screen.dart';
import 'package:invoiceinaja/screen/invoices/invoices_view_model.dart';
import 'package:invoiceinaja/screen/invoices/preview_invoice_screen.dart';
import 'package:provider/provider.dart';

class CreateInvoice extends StatefulWidget {
  const CreateInvoice({Key? key}) : super(key: key);

  @override
  State<CreateInvoice> createState() => _CreateInvoiceState();
}

class _CreateInvoiceState extends State<CreateInvoice> {
  DateTime? selectedDate;
  DateTime? selectedDueDate;
  int? id;
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _companyController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _namaController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _companyController.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var viewModel = Provider.of<InvoicesViewModel>(context, listen: false);
      await viewModel.getDataClient();
      viewModel.listItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<InvoicesViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Invoice'),
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
        padding: const EdgeInsets.all(10),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Form(
              key: _formKey,
              child: Card(
                elevation: 5,
                shadowColor: const Color(0xFF9B6DFF),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const Text(
                          'Invoice To',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Autocomplete<ClientModel>(
                        optionsBuilder: (TextEditingValue value) {
                          if (value.text.isEmpty) {
                            return List.empty();
                          } else {
                            return data.listClients
                                .where(
                                  (element) =>
                                      element.fullname!.toLowerCase().contains(
                                            value.text.toLowerCase(),
                                          ),
                                )
                                .toList();
                          }
                        },
                        displayStringForOption: (ClientModel client) =>
                            '${client.fullname}',
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController controller,
                            FocusNode node,
                            Function onSubmit) {
                          return Container(
                            margin: const EdgeInsets.only(top: 12),
                            child: TextFormField(
                              controller: controller,
                              focusNode: node,
                              decoration: InputDecoration(
                                hintText: 'Name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          );
                        },
                        onSelected: (value) {
                          setState(() {
                            id = value.id!;
                            _namaController.text = value.fullname!;
                            _emailController.text = value.email!;
                            _addressController.text = value.address!;
                            _companyController.text = value.company!;
                          });
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text(
                          'Email',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text(
                          'Streets Address',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        child: TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            hintText: 'Address',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text(
                          'Company',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        child: TextFormField(
                          controller: _companyController,
                          decoration: InputDecoration(
                            hintText: 'Company',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: const Text(
                                  'Invoice Date',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                width: 160,
                                height: 60,
                                child: OutlinedButton(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        selectedDate == null
                                            ? 'dd/mm/yyyy'
                                            : DateFormat('dd-MM-yyyy')
                                                .format(selectedDate!),
                                        style: TextStyle(
                                          color: selectedDate == null
                                              ? Colors.grey
                                              : Colors.black,
                                        ),
                                      ),
                                      Icon(
                                        Icons.date_range,
                                        color: selectedDate == null
                                            ? Colors.grey
                                            : Colors.black,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    showDate();
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: const Text(
                                  'Due Date',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                width: 160,
                                height: 60,
                                child: OutlinedButton(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        selectedDueDate == null
                                            ? 'dd/mm/yyyy'
                                            : DateFormat('dd-MM-yyyy')
                                                .format(selectedDueDate!),
                                        style: TextStyle(
                                          color: selectedDueDate == null
                                              ? Colors.grey
                                              : Colors.black,
                                        ),
                                      ),
                                      Icon(
                                        Icons.date_range,
                                        color: selectedDueDate == null
                                            ? Colors.grey
                                            : Colors.black,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    showDueDate();
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: const Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: EdgeInsets.only(top: 20),
                child: ListTile(
                  leading: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      CupertinoIcons.cube,
                      color: Color(0xFF9B6DFF),
                    ),
                  ),
                  title: Text(
                    'Add Product',
                    style: TextStyle(color: Color(0xFF9B6DFF)),
                  ),
                  trailing: Icon(Icons.add, color: Color(0xFF9B6DFF)),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddProduct()));
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'Total Product : ${data.listItems.length}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var dataIndex = data.listItems[index];
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: data.listItems.length,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  width: 170,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Save as draft',
                      style: TextStyle(color: Color(0xFF9B6DFF)),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  width: 170,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF9B6DFF),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      if (_emailController.text.isEmpty ||
                          _namaController.text.isEmpty ||
                          _addressController.text.isEmpty ||
                          selectedDate.toString().isEmpty ||
                          selectedDueDate.toString().isEmpty ||
                          data.listItems.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Container(
                              width: double.infinity,
                              height: 50,
                              alignment: Alignment.center,
                              child: const Text(
                                  "Please fill all the data in the form"),
                            ),
                            backgroundColor: Theme.of(context).errorColor,
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PreviewInvoice(
                              id: id!,
                              nama: _namaController.text,
                              email: _emailController.text,
                              alamat: _addressController.text,
                              invoiceDate: DateFormat('dd-MM-yyyy')
                                  .format(selectedDate!),
                              invoiceDueDate: DateFormat('dd-MM-yyyy')
                                  .format(selectedDueDate!),
                              listDetailInvoice: data.listItems,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Preview',
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

  void showDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 730),
      ),
    ).then((date) {
      setState(() {
        selectedDate = date;
      });
    });
  }

  void showDueDate() {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 730),
      ),
      initialDate: DateTime.now(),
    ).then((date) {
      setState(() {
        selectedDueDate = date;
      });
    });
  }
}
