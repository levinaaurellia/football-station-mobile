import 'package:flutter/material.dart';
import 'package:football_station/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:football_station/screens/menu.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _price = 0;
  String _description = "";
  String _category = "jersey"; // default
  String _thumbnail = "";
  bool _isFeatured = false;
  int _stock = 0;
  String _brand = "adidas";

  final List<String> _categories = [
    'jersey',
    'shoes',
    'ball',
    'merch'
  ];

  final List<String> _brands = [
    'nike',
    'adidas',
    'puma',
    'under_armour',
    'reebok',
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Create Product Form',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===Nama Produk===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Produk",
                    labelText: "Nama Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                  ),
                  onChanged: (String? value){
                    setState(() {
                      _name = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Nama produk tidak boleh kosong!";
                    }
                    // Validasi panjang string min/max
                    if(value.length < 5) {
                      return "Nama produk minimal 5 karakter!";
                    }
                    if (value.length > 50) {
                      return "Nama produk tidak boleh lebih dari 50 karakter!";
                    }
                    return null;
                  },
                ),
              ),


              // ===Price===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Harga Produk",
                    labelText: "Harga Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),

                  // Menampilkan keyboard angka
                  keyboardType: TextInputType.number,
                  onChanged: (String? value){
                    setState(() {
                      // Ubah string input menjadi integer
                      // Pakai tryParse utk menghindari error (inputnya bkn angka)
                      // '??0' => jika input kosong/ ga valid, anggap nilainya 0
                      _price = int.tryParse(value?? "") ?? 0;
                    });
                  },
                  validator: (String? value){
                    if (value == null || value.isEmpty) {
                      return "Harga tidak boleh kosong!";
                    }
                    // Pastikan inputnya angka
                    if (int.tryParse(value) == null) {
                      return "Harga harus berupa angka!";
                    }
                    // Pastikan harganya positif
                    if (int.parse(value) <= 0) {
                      return "Harga harus lebih dari 0!";
                    }
                    return null;
                  },
                ),
              ),


              // ===Description===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Isi Keterangan Produk",
                    labelText: "Isi Keterangan Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Isi keterangan produk tidak boleh kosong!";
                    }
                    // Validasi panjang string min/max
                    if (value.length < 10) {
                      return "Deskripsi minimal 10 karakter!";
                    }
                    if (value.length > 500) {
                      return "Deskripsi tidak boleh lebih dari 500 karakter!";
                    }
                    return null;
                  },
                ),
              ),


              // ===Category==
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategori",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  value: _category,
                  items: _categories
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(
                                cat == 'shoes' ? 'Sepatu' :
                                cat == 'ball' ? 'Bola' :
                                cat == 'merch' ? 'Merchandise' :
                                'Jersey' // default untuk 'jersey'
                            ),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                ),
              ),


              // ===Thumbnail URL===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "URL Thumbnail (opsional)",
                    labelText: "URL Thumbnail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _thumbnail = value!;
                    });
                  },
                ),
              ),


              // ===Is Featured===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text("Tandai sebagai Produk Unggulan"),
                  value: _isFeatured,
                  onChanged: (bool value) {
                    setState(() {
                      _isFeatured = value;
                    });
                  },
                ),
              ),


              // ===Stock===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Jumlah Stok",
                    labelText: "Jumlah Stok",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  initialValue: _stock.toString(),
                  onChanged: (String? value){
                    setState(() {
                      _stock = int.tryParse(value?? "") ?? 0;
                    });
                  },
                  validator: (String? value){
                    if (value == null || value.isEmpty) {
                      return "Stok tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Stok harus berupa angka!";
                    }
                    if (int.parse(value) < 0) {
                      return "Stok tidak boleh negatif!";
                    }
                    return null;
                  },
                ),
              ),


              // ===Brand===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Brand",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  value: _brand, // Default value
                  items: _brands
                      .map((brand) => DropdownMenuItem(
                    value: brand,
                    child: Text(brand[0].toUpperCase() + brand.substring(1).replaceAll('_', ' ')),
                  ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _brand = newValue!;
                    });
                  },
                ),
              ),


              // ===Tombol Save===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // To connect Android emulator with Django on localhost, use URL http://10.0.2.2/
                        // If you using chrome,  use URL http://localhost:8000

                        final response = await request.postJson(
                          "http://localhost:8000/create-flutter/",
                          jsonEncode({
                            "name": _name,
                            "description": _description,
                            "price": _price,
                            "stock": _stock,
                            "brand": _brand,
                            "thumbnail": _thumbnail,
                            "category": _category,
                            "is_featured": _isFeatured,
                          }),
                        );
                        if (context.mounted) {
                          if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Product successfully saved!"),
                            ));
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Something went wrong, please try again."),
                            ));
                          }
                        }
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}