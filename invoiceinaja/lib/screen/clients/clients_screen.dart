import 'package:flutter/material.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: const [
            SizedBox(
              height: 25,
            ),
            Padding(
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
          ],
        ),
      ),
    );
  }
}
