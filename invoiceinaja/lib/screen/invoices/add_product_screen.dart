import 'package:flutter/material.dart';
import 'package:invoiceinaja/model/invoice_model.dart';
import 'package:invoiceinaja/model/post_invoice_model.dart';
import 'package:provider/provider.dart';

import 'invoices_view_model.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _itemNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _itemNameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<InvoicesViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Add Product'),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const Text(
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: TextFormField(
                        controller: _itemNameController,
                        validator: (itemName) {
                          if (itemName!.isEmpty) {
                            return 'Item must not be empty';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Item Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const Text(
                        'Quantity',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: TextFormField(
                        controller: _quantityController,
                        decoration: InputDecoration(
                          hintText: 'Number of Products',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        validator: (quantity) {
                          if (quantity!.isEmpty) {
                            return 'Quality must not be empty';
                          }
                          if (quantity.startsWith('0')) {
                            return 'Quality must not be 0';
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const Text(
                        'Price',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: TextFormField(
                        controller: _priceController,
                        validator: (price) {
                          if (price!.isEmpty) {
                            return 'Price must not be empty';
                          }
                          if (price.startsWith('0')) {
                            return 'Price must not be 0';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Harga',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    ),
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
                          final form = _formKey.currentState!;
                          if (form.validate()) {
                            var dataItem = DetailInvoice(
                              itemName: _itemNameController.text,
                              quantity: int.parse(_quantityController.text),
                              price: int.parse(_priceController.text),
                            );
                            data.addItems(dataItem);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          'Add Product',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
