import 'package:flutter/material.dart';
import 'package:football_station/screens/menu.dart';
import 'package:football_station/screens/productlist_form.dart';
import 'package:football_station/screens/product_entry_list.dart';


/// Kartu tombol dengan ikon
class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
        topRight: Radius.circular(5),
        bottomLeft: Radius.circular(5),
      ),
      child: InkWell(
        onTap: () async {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));

          // Navigate ke route yang sesuai (tergantung jenis tombol)
          if (item.name == "Create Product") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProductFormPage()));
          } else if (item.name == "All Products") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProductEntryListPage(filter: "all")
              ),
            );
          } else if (item.name == "My Products") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProductEntryListPage(filter: "my")
              ),
            );
          }

        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item.icon,
                    color: Colors.white,
                    size: 40.0,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  item.name.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}