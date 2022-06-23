import 'package:flutter/material.dart';
import 'package:invoiceinaja/screen/add_client/add_client_screen.dart';

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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Card(
                child: ListTile(
                  leading: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.people, color: Color(0xFF9B6DFF)),
                  ),
                  title: Text(
                    'Putra',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('0812-3456-7890'),
                  trailing: Text('Client'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Card(
                child: ListTile(
                  leading: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.people, color: Color(0xFF9B6DFF)),
                  ),
                  title: Text(
                    'Nakula',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('0812-3456-7890'),
                  trailing: Text('Client'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Card(
                child: ListTile(
                  leading: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.people, color: Color(0xFF9B6DFF)),
                  ),
                  title: Text(
                    'Sadewa',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('0812-3456-7890'),
                  trailing: Text('Client'),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddClients()));
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
