import 'package:flutter/material.dart';
import 'package:invoiceinaja/screen/add_clients/add_clients.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            const Padding(
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
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Card(
                elevation: 5,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                  child: ListTile(
                    leading: const Icon(Icons.people, color: Color(0xFF9B6DFF)),
                    title: const Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text(
                        'Putra',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '0812-3456-7890',
                          style: TextStyle(color: Color(0xFF9B6DFF)),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'ilhamganteng@gmail.com',
                          style: TextStyle(color: Color(0xFF9B6DFF)),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(
                          Icons.more_horiz,
                          color: Colors.black,
                          size: 25,
                        ),
                        Text(
                          'Client',
                          style: TextStyle(color: Color(0xFF9B6DFF)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Card(
                elevation: 5,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                  child: ListTile(
                    leading: const Icon(Icons.people, color: Color(0xFF9B6DFF)),
                    title: const Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text(
                        'Putra',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '0812-3456-7890',
                          style: TextStyle(color: Color(0xFF9B6DFF)),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'ilhamganteng@gmail.com',
                          style: TextStyle(color: Color(0xFF9B6DFF)),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(
                          Icons.more_horiz,
                          color: Colors.black,
                          size: 25,
                        ),
                        Text(
                          'Client',
                          style: TextStyle(color: Color(0xFF9B6DFF)),
                        ),
                      ],
                    ),
                  ),
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
