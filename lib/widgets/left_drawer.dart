import 'package:flutter/material.dart';
import 'package:football_station/screens/menu.dart';
import 'package:football_station/screens/productlist_form.dart';
import 'package:football_station/screens/product_entry_list.dart';


class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            // Drawer Header
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Text(
                  'Football Station',
                  textAlign: TextAlign.center,
                  style:  TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Seluruh produk terbaru ada di sini!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),


          // Routing
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(),
                  ));
            },
          ),

          ListTile(
            leading: const Icon(Icons.add_box),
            title: const Text('Create Product'),
            // redirection ke ProductFormPage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProductFormPage(),
                  ));
            }
          ),


          ListTile(
            leading: const Icon(Icons.add_reaction_rounded),
            title: const Text('Product List'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductEntryListPage(),
                  ));
            },
          ),

        ],
      ),
    );
  }
}