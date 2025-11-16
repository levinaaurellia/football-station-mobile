### Jawab Pertanyaan Tugas

<details>
<summary>📘 Tugas 7</summary>

<details>
<summary> Nomor 1</summary>

1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.   
[Jawab]      
***Widget Tree***    
Pada Flutter, semua UI dibangun dari widget. Saat aplikasi berjalan, Flutter mengatur widget-widget itu dalam hierarki (tree) yang merepresentasikan tampilan pada state/config saat ini. Widget bersifat deklaratif dan immutable; ketika state berubah, Flutter membangun ulang deskripsi UI dan hanya menerapkan perubahan yang diperlukan.

Flutter memisahkan tiga pohon yang saling terkait:
- Widget tree: deklarasi/config UI. 
- Element tree: objek aktif yang menjembatani widget dengan sistem render. 
- RenderObject tree: menangani perhitungan ukuran, layout, dan proses menggambar di layar. 
Memisahkan ketiga pohon ini membuat update UI efisien dan terkontrol.

***Hubungan Parent-Child Bekerja Antar Widget***  
1) Constraints mengalir ke bawah: parent mengirim batas ukuran (min/max) ke child. 
2) Size mengalir ke atas: child memilih ukuran di dalam constraint tersebut dan melaporkannya ke parent. 
3) Parent memposisikan child di areanya.

Hal ini menjelaskan mengapa sebuah widget tidak bisa semudah itu  menentukan ukuran/posisinya sendiri. Selain layout, banyak hal yang berkaitan dari parent ke child melalui `BuildContext` (misalnya `Theme.of(context)`, `Navigator.of(context)`, `InheritedWidget/state-management`). `BuildContext` sebenarnya sebuah Element penunjuk lokasi widget di tree sehingga ia tahu siapa parent/ancestor-nya.

Contoh:
```dart
Scaffold(
  body: Center(
    child: Container(
      padding: const EdgeInsets.all(8),
      child: const Text('Halo'),
    ),
  ),
);
```

pohon sederhananya:
```scss
Scaffold
└─ Center        // memberi constraint longgar ke child
   └─ Container  // memilih ukuran sesuai padding dan teks
      └─ Text    // dilayout & diposisikan oleh parent di atas
```

</details>


<details>
<summary> Nomor 2</summary>

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.    
[Jawab]      
Berdasarkan file `lib/main.dart` dan `lib/menu.dart`, berikut adalah semua widget yang saya gunakan dalam proyek "football_station" beserta fungsinya:
***Widget Utama (Aplikasi & Halaman)***
1) `StatelessWidget`: Ini adalah kelas dasar (induk) yang digunakan untuk membuat widget sendiri yang tidak memiliki status internal (tidak bisa berubah sendiri). `MyApp`, `MyHomePage`, `InfoCard`, dan `ItemCard` semuanya adalah turunan dari `StatelessWidget`.
2) `MaterialApp`: Ini adalah widget root dari seluruh aplikasi. Fungsinya adalah menyediakan banyak fitur standar Material Design, seperti navigasi (perpindahan halaman) dan tema (termasuk warna utama yang  diatur). 
3) `Scaffold`: Widget ini menyediakan struktur visual dasar untuk halaman (layar). Di `MyHomePage`, saya menggunakannya untuk menampung `AppBar` (di bagian atas) dan `body` (konten utama halaman). 
4) `AppBar`: Ini adalah bar judul di bagian atas layar. Kamu menggunakannya untuk menampilkan judul 'Football Station'.
            
***Widget Layout (Tata Letak)***         
1) `Padding`: Memberikan ruang kosong di sekeliling child-nya. Digunakan untuk memberi jarak 16.0 piksel di sekeliling seluruh konten di dalam `body`. 
2) `Column`: Mengatur children (anak-anaknya) dalam daftar vertikal (dari atas ke bawah). Digunakan sebagai penampung utama di `body` dan juga di `InfoCard` dan `ItemCard`. 
3) `Row`: Mengatur children (anak-anaknya) dalam daftar horizontal (dari kiri ke kanan). Digunakan untuk menyusun tiga `InfoCard` (NPM, Nama, Kelas). 
4) `SizedBox`: Membuat sebuah kotak kosong dengan ukuran tetap. Digunakan untuk memberi jarak vertikal (spasi) setinggi 16.0 piksel antara Row info dan Center di bawahnya. 
5) `Center`: Menempatkan child-nya di tengah-tengah ruang yang tersedia. Digunakan untuk memusatkan `Column` yang berisi teks sambutan dan `GridView`. 
6) `GridView`: Menampilkan children-nya dalam sebuah grid, menggunakan `GridView.count` untuk membuat grid dengan 3 kolom yang menampilkan `ItemCard`. 
7) `Container`: Widget serbaguna untuk tata letak, pewarnaan, dan ukuran. Digunakan di dalam `InfoCard` untuk mengatur lebar (width) dan padding, serta di dalam `ItemCard` untuk mengatur padding.
       
***Widget Kustom***
1) `MyHomePage`: Widget kustom sebagai halaman utama aplikasi. 
2) `InfoCard`: Widget kustom untuk menampilkan kotak kartu berisi judul (NPM/Nama/Kelas) dan isinya. 
3) `ItemCard`: untuk menampilkan tombol-tombol di GridView, lengkap dengan ikon, teks, warna latar belakang, dan event saat ditekan.
               
***Widget Tampilan & Interaksi***        
1) `Text`: Menampilkan string (teks) di layar untuk semua teks yang terlihat di aplikasi. 
2) `Icon`: Menampilkan ikon grafis di dalam `ItemCard` untuk menampilkan ikon (seperti Icons.grid_view, dll.). 
3) `Card`: Widget dasar dari `InfoCard` yang juga merupaka design yang memiliki sudut sedikit membulat dan bayangan. 
4) `Material`: menyediakan "kanvas" Material Design. Digunakan di `ItemCard` sebagai dasar untuk memberikan warna latar belakang, bentuk melengkung (borderRadius), dan efek splash saat ditekan. 
5) `InkWell`: Membuat child-nya (dalam hal ini Container di ItemCard) dapat merespons sentuhan dan menampilkan efek percikan saat ditekan. Digunakan untuk menangani `onTap`. 
6) `ScaffoldMessenger`: Mengelola `SnackBar`. Memanggilnya (`ScaffoldMessenger.of(context)`) untuk menampilkan pesan `SnackBar` saat `ItemCard` ditekan. 
7) `SnackBar`: Pesan sementara yang muncul di bagian bawah layar. Digunakan untuk memberi tahu pengguna tombol mana yang telah mereka tekan.
                 
***Widget Data & Styling***
1) `ThemeData`: Mendefinisikan konfigurasi visual untuk `MaterialApp`, seperti warna. Digunakan untuk mengatur warna primer aplikasi. 
2) `ColorScheme`: Bagian dari `ThemeData` yang secara spesifik mengatur skema warna aplikasi. 
3) `TextStyle`: Mendefinisikan properti visual untuk `Text`, seperti `color`, `fontWeight`, `fontSize`. 
4) `MediaQuery`: Digunakan untuk mendapatkan informasi tentang media saat ini (seperti ukuran layar). Digunakan di `InfoCard` untuk mengatur lebarnya secara responsif (`MediaQuery.of(context).size.width / 3.5`).

</details>
       
      

<details>
<summary> Nomor 3</summary> 

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.              
[Jawab]                              
`MaterialApp` adalah widget inti yang membungkus seluruh aplikasi. Bisa dianggap rangka utama untuk aplikasi yang menggunakan gaya Material Design. Fungsi utamanya adalah menyediakan berbagai fitur level aplikasi yang dibutuhkan agar semua halaman dan widget di dalamnya bisa berfungsi dengan baik.
            
Dia harus berada di level tertinggi (seperti di dalam `MyApp`) karena dia menyediakan tiga hal penting yang harus bisa diakses oleh semua widget di bawahnya:
1) Mengatur Tema (Styling) `MaterialApp` adalah tempat menentukan `ThemeData` untuk aplikasi. Tema ini (seperti `colorScheme` yang diatur ke `Colors.blue`) akan secara otomatis diwariskan ke semua widget lain di bawahnya. Maka dari itu,  `AppBar` dan `ItemCard` di proyek tahu harus memakai warna biru tanpa perlu atur warnanya satu per satu di widget tersebut. 
2) Mengatur Navigasi (Pindah Halaman) `MaterialApp`lah yang mengelola rute di aplikasi. Saat ingin pindah dari satu layar ke layar lain, `MaterialApp` yang menangani prosesnya. Properti `home: MyHomePage()` adalah cara memberi tahu `MaterialApp` widget mana yang harus ditampilkan sebagai halaman pertama saat aplikasi dibuka.     
3) Menyediakan Layanan Dasar yang dibutuhkan aplikasi, seperti: `title` (judul aplikasi yang digunakan oleh sistem operasi), Lokalisasi (Bahasa) untuk mengatur dukungan berbagai bahasa, Builder untuk kustomisasi level atas lainnya.      
           
Tanpa `MaterialApp` di paling atas, widget-widget seperti `Scaffold`, `AppBar`, dan lainnya tidak 
akan tahu tema apa yang harus dipakai atau bagaimana cara berpindah halaman.      

</details>
      

   
<details>
<summary> Nomor 4</summary>

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?       
[Jawab]     
- `StatelessWidget` (Widget Statis) adalah widget yang tidak bisa berubah setelah digambar. Tampilannya murni ditentukan oleh data (konfigurasi) yang dikirimkan oleh parent-nya. 
- `StatefulWidget` (Widget Dinamis) adalah widget yang bisa berubah secara internal. Ia memiliki objek "State" (status) khusus yang bisa menyimpan data dan bisa diperbarui kapan saja kemudian meminta Flutter untuk menampilkan ulang widget itu di layar dengan tampilan yang baru.
                      
Untuk memicu penggambaran ulang di StatefulWidget, panggil fungsi setState(). `StatelessWidget` tidak memiliki fungsi ini.

***Kapan Memilihnya***
1) Pilih `StatelessWidget` (Default)
- Widget tersebut "statis" dan hanya perlu menampilkan data yang dikirimkan padanya. 
- Widget tidak perlu mengingat apapun. 
- Tampilannya tidak akan pernah berubah berdasarkan input pengguna.
Contoh di football station: `InfoCard` adalah contoh Stateless. Ia menerima title dan content, menampilkannya, dan selesai. Ia tidak akan pernah mengubah title atau content itu sendiri.
2) Pilih `StatefulWidget` (Jika Perlu Berubah)
- Berubah karena interaksi pengguna. Contoh: `Checkbox` yang dicentang, `Slider` yang digeser, atau `TextField` tempat pengguna mengetik. 
- Menyimpan data internal yang bisa berubah. Contoh: Menghitung berapa kali tombol ditekan, menyimpan daftar item yang bisa ditambah atau dikurangi. 
- Menunggu data. Contoh: Menampilkan indikator loading selagi mengambil data dari internet, lalu menampilkan data itu setelah selesai.

</details>
     

       
   
<details>
<summary> Nomor 5</summary> 

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
[Jawab]            
`BuildContext` itu seperti alamat-nya sebuah widget. Fungsi utamanya adalah memberi tahu sebuah widget di mana tepatnya lokasinya di dalam keseluruhan widget tree. Setiap widget yang sedang ditampilkan di layar memiliki `BuildContext`-nya sendiri yang unik, yang berisi informasi tentang posisinya relatif terhadap widget lain. `BuildContext` penting karena satu-satunya cara bagi sebuah widget untuk berinteraksi dengan widget yang ada di atasnya (parent, kakek, atau leluhurnya di dalam tree). Widget tidak bisa "melihat ke atas" secara langsung. Ia harus menggunakan alamat-nya untuk meminta sesuatu. Fungsi terpentingnya adalah untuk lookup data atau layanan dari widget ancestor terdekat.

***Penggunaannya di Metode `build`***         
`Widget build(BuildContext context) { ... }`
Setiap kali Flutter ingin menggambar widget, ia akan memanggil metode `build` dan memberikan context sebagai parameter.

Di dalam metode `build` itulah kita gunakan context tersebut untuk:
1) Mengambil data dari atas di dalam `MyHomePage`, `AppBar` bisa berwarna biru karena `Theme.of(context).colorScheme.primary` secara internal menggunakan `context` untuk bertanya pada `MaterialApp` (yang ada di atasnya) apa warna primernya.
2) Menjalankan aksi di `ItemCard`, dengan menggunakan `ScaffoldMessenger.of(context).showSnackBar(...)` hanya bisa bekerja karena context tersebut tahu di mana `Scaffold` (leluhurnya) berada, yang menyediakan layanan `ScaffoldMessenger`. 
3) Mengatur ukuran responsif Di `InfoCard`, dengan menggunakan `MediaQuery.of(context).size.width`. Context digunakan untuk mencari info ukuran layar yang disediakan oleh `MaterialApp`.
                      
Dengan begitu, `BuildContext` hanya bisa menemukan data dari widget yang posisinya di atas dia di dalam tree. Inilah mengapa  `MaterialApp` (yang menyediakan `Theme` dan `MediaQuery`) harus selalu berada di paling atas (root).

</details>
       
           


<details>
<summary> Nomor 6</summary> 

6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".              
[Jawab]                      
`hot reload` memberikan file kode Dart yang baru diubah ke dalam Dart Virtual Machine (VM) yang sedang berjalan. VM kemudian langsung menggambar ulang widget tree. Kecepatannya sangat cepat yaitu kurang dari 1 detik. Status (State) aplikasi tetap terjaga, jika sedang berada di halaman kelima aplikasi, sudah mengisi formulir, atau ada counter yang menunjukkan angka 10, setelah hot reload, akan tetap berada di halaman kelima, formulir tetap terisi, dan counter tetap 10. Digunakan setiap kali mengubah tampilan (layout), warna, ukuran, atau teks di `StatelessWidget` atau `StatefulWidget`.

Sedangkan `hot restart` mematikan aplikasi yang sedang berjalan dan me-restart-nya dari awal. Ia memuat ulang semua kode (termasuk state awal). Kecepatannya auh lebih cepat daripada menghentikan dan menjalankan ulang aplikasi (Full Restart), tetapi lebih lambat dari Hot Reload (biasanya beberapa detik). Status (State) aplikasi hilang / direset, aplikasi akan kembali ke kondisi awal seperti baru saja dibuka. Digunakan saat:
- mengubah state awal dari `StatefulWidget`. 
- mengubah konstruktor widget (misalnya, `MyHomePage()` diubah menjadi `MyHomePage(title: "Baru")`). 
- menambahkan file asset baru (seperti gambar) atau font ke file `pubspec.yaml`. 
- Hot Reload gagal.
                    
Jadi, perbedaan utamanya adalah `Hot Reload` sangat cepat dan hanya memuat ulang perubahan tampilan (UI) seperti mengganti warna atau tata letak di `menu.dart` tanpa mengulang aplikasi. Sehingga data (state) yang sedang aktif di halaman itu tidak akan hilang. Sedangkan, `Hot Restart` akan memulai ulang seluruh aplikasi dari awal, yang membuatnya lebih lambat. Akan menghapus semua data (state) yang sedang berjalan dan mengembalikan aplikasi ke halaman utamanya.
</details>


</details>

---
<details>
<summary>📘 Tugas 8</summary>

<details>
<summary> Nomor 1</summary>

1. Jelaskan perbedaan antara `Navigator.push()` dan `Navigator.pushReplacement()` pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
[Jawab]   
Perbedaan kedua method tersebut terletak pada apa yang dilakukan kepada route (halaman) yang berada pada atas stack. `push()` akan menambahkan route baru di atas route yang sudah ada, sehingga route lama tetap tersimpan di dalam tumpukan. Sebaliknya, `pushReplacement()` akan menggantikan route yang sudah ada pada atas stack dengan route baru tersebut; route yang lama akan dibuang. Penting juga untuk memperhatikan urutan dan isi dari stack, karena jika kondisi stack menjadi kosong, maka sistem akan keluar dari aplikasi tersebut.

***Kasus yang tepat untuk `Navigator.push()`***
Pada file `lib/widgets/product_card.dart` saat tombol `add_product` ditekan
```dart
// Di file lib/widgets/product_card.dart
if (item.name == "Add Product") {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const ProductFormPage()));
}
```
Inilah kasus yang tepat karena pengguna melakukan tugas sementara (mengisi form). Setelah selesai dan menekan `save`, mereka pasti ingin kembali ke Halaman Utama. Maka dari itu, `push()` memastikan halaman utama tetap ada di stack (di bawah halaman form). `AppBar` di `Halaman Form` akan otomatis memunculkan tombol back agar pengguna bisa kembali.

Meskipun tombol panah back visual di AppBar tidak muncul, itu bukan karena stack-nya salah. Itu terjadi karena Scaffold di ProductFormPage juga memiliki drawer, dan AppBar lebih memprioritaskan untuk menampilkan tombol pembuka drawer daripada tombol back otomatis. Fungsionalitas untuk kembali (seperti tombol back fisik di HP Android atau gestur geser) tetap berfungsi seperti seharusnya.

***Kasus yang tepat untuk `Navigator.pushReplacement()`***
di file `lib/widgets/left_drawer.dart` saat memilih menu dari drawer.
```dart
ListTile(
  leading: const Icon(Icons.add_box),
  title: const Text('Add Product'),
  onTap: () {
    Navigator.pushReplacement( 
        context,
        MaterialPageRoute(builder: (context) => ProductFormPage(),
        ));
  }
)
```
Inilah kasus yang tepat karena Drawer berfungsi sebagai navigasi utama. Saat pengguna memilih item di drawer, mereka tidak sedang "masuk ke dalam", melainkan sedang berpindah bagian aplikasi. `pushReplacement()` memastikan halaman saat ini (halaman utama) dibuang dan diganti dengan halaman form. Hal ini menjaga stack navigasi tetap bersih.

</details>


<details>
<summary> Nomor 2</summary>

2. Bagaimana kamu memanfaatkan hierarchy widget seperti `Scaffold`, `AppBar`, dan `Drawer` untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
[Jawab]    
Dalam aplikasi Football Station ini, saya memanfaatkan hierarchy (hierarki) widget dengan menjadikan Scaffold sebagai "template" dasar untuk setiap halaman, yang kemudian mengatur AppBar dan Drawer untuk membuat struktur yang konsisten.

***Berikut penjelasannya***
1) `Scaffold` sebagai kerangka utama, yang mana `Scaffold` adalah widget induk level atas untuk setiap halaman, baik di `MyHomePage` maupun `ProductFormPage`. `Scaffold` menyediakan "slot" atau properti khusus seperti `appBar`, `drawer`, dan `body`. Dengan menempatkan widget lain ke dalam slot-slot ini, `Scaffold` secara otomatis mengurus layout dan memastikan semuanya berada di tempat yang seharusnya (misalnya, `AppBar` selalu di atas, `Drawer` selalu tersembunyi di samping).
2) `AppBar` untuk header yang seragam, dengan menempatkan  `AppBar` di dalam properti `appBar` milik `Scaffold`, saya memastikan bahwa setiap halaman memiliki header yang seragam. Baik di halaman utama maupun halaman form, `AppBar` secara konsisten menampilkan judul dan ikon untuk membuka drawer.
3) `Drawer` untuk navigasi pusat, bagian terpenting untuk konsistensi navigasi. Daripada membuat menu navigasi di setiap halaman, saya membuat satu widget kustom `LeftDrawer`. Kemudian, di setiap halaman baru (seperti `MyHomePage` dan `ProductFormPage`), saya hanya perlu menambahkan satu baris kode drawer: `LeftDrawer()` ke dalam Scaffold. Hierarkinya adalah `Scaffold` -> `drawer: LeftDrawer()`. Hal ini menghubungkan  `AppBar` dengan drawer tersebut. Hasilnya, semua halaman di aplikasi saya memiliki menu navigasi yang identik, dan jika saya perlu menambah menu baru, saya cukup mengedit file `left_drawer.dart` satu kali.


</details>

<details>
<summary> Nomor 3</summary>

3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti `Padding`, `SingleChildScrollView`, dan `ListView` saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
[Jawab]    
Berikut adalah kelebihan masing-masing widget dan contoh penggunaannya dari kode aplikasi saya:
***Padding***
Kelebihan utamanya adalah untuk memberi ruang pada elemen form. Tanpa `Padding`, `TextFormField` atau tombol akan menempel rapat satu sama lain dan juga menempel di tepi layar. Ini membuat form terlihat sempit, tidak profesional, dan sulit digunakan.

Contoh di Aplikasi saya: saya sudah menerapkan ini dengan sangat baik di file `lib/screens/productlist_form.dart`. Saya membungkus setiap elemen input (seperti "Nama Produk", "Harga", "Deskripsi", dll.) dengan widget `Padding`, lalu memberinya `padding: const EdgeInsets.all(8.0)`. Hal ini membuat jarak yang konsisten antar elemen dan antara elemen dengan tepi layar, membuat form terlihat lebih rapih.

***SingleChildScrollView***
Kelebihan utamanya adalah mencegah render overflow error, terutama saat keyboard muncul. Form seringkali lebih panjang dari layar HP. Saat pengguna tap `TextFormField`, keyboard akan muncul dan menutupi setengah bagian bawah layar. Tanpa `SingleChildScrollView`, elemen di bagian bawah (seperti tombol "Save") akan terpotong dan tidak bisa diakses, yang akan menyebabkan error "bottom overflowed".

Contoh di Aplikasi saya: Di file `lib/screens/productlist_form.dart`, saya membungkus seluruh Column yang berisi elemen-elemen form dengan `SingleChildScrollView`. Ini adalah penggunaan yang paling umum dan sangat penting. Ini memastikan bahwa meskipun form sangat panjang atau saat keyboard muncul, pengguna tetap bisa men-scroll ke bawah untuk mengakses tombol "Save".

***ListView***
`ListView` memiliki kelebihan yang mirip dengan `SingleChildScrollView` (yaitu membuat konten bisa di-scroll), namun `ListView` lebih efisien untuk menangani daftar item yang jumlahnya banyak, tidak diketahui, atau dinamis (bisa bertambah/berkurang).

Contoh di Aplikasi saya: saya tidak menggunakan ListView di dalam halaman form, karena saya menggunakan `SingleChildScrollView` yang sudah tepat untuk form dengan jumlah elemen yang tetap.

Namun, saya menggunakan ListView dengan sangat baik di dalam `lib/widgets/left_drawer.dart`. Di sana, ListView digunakan untuk menampung menu-menu drawer ("Home" dan "Add Product"). Jika memiliki 50 menu di drawer itu, `ListView` akan tetap efisien karena hanya me-render item yang terlihat di layar. Untuk form sendiri, `ListView` akan sangat berguna jika memiliki form di mana pengguna bisa menekan tombol "Tambah Item Lain" berulang kali.

</details>

<details>
<summary> Nomor 4</summary>

4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
[Jawab]    
Saya menyesuaikan warna tema untuk membuat identitas visual yang konsisten dengan cara mendefinisikan `ThemeData` terpusat di dalam widget `MaterialApp`, yang merupakan root (akar) dari seluruh aplikasi di file `lib/main.dart`.

***Berikut penjelasannya***
1) Pengaturan Terpusat di  `main.dart` Di dalam widget `MaterialApp`, saya menggunakan properti `theme`. Di sinilah saya menetapkan "warna brand" utama untuk seluruh aplikasi.
```dart
MaterialApp(
  title: 'Flutter Demo',
  theme: ThemeData(
    // warna brand utama
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue) 
        .copyWith(secondary: Colors.blueAccent[400]),
  ),
  home: MyHomePage(),
);
```
Dengan menentukan `primarySwatch: Colors.blue`, saya memberi tahu Flutter untuk secara otomatis membuat seluruh palet warna (terang, gelap, aksen) berdasarkan warna biru tersebut.
2) Pewarisan Tema (Theme Inheritance) Karena `MaterialApp` membungkus seluruh aplikasi, `ThemeData` ini secara otomatis "diwariskan" ke setiap halaman dan widget yang ada di bawahnya.
3) Widget lain di halaman berbeda bisa menggunakan warna brand ini secara konsisten. Contohnya, di `lib/screens/menu.dart`, `AppBar` tidak perlu menentukan warnanya sendiri (seperti Colors.blue). Ia cukup mengambil warna primer dari tema yang sudah diwariskan
```dart
AppBar(
  // ...
  // mengambil warna brand secara otomatis dari tema
  backgroundColor: Theme.of(context).colorScheme.primary, 
)
```
Dengan cara inilah jika suatu saat brand Football Station ingin berganti warna (misalnya, menjadi hijau), saya hanya perlu mengubah Colors.blue menjadi Colors.green di satu tempat (yaitu file `main.dart`), dan seluruh `AppBar`, tombol, dan drawer di aplikasi akan otomatis ikut berubah.

</details>


</details>


---
<details>
<summary>📘 Tugas 9</summary>


<details> <summary>1.  Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model (terkait validasi tipe, null-safety, maintainability)?</summary>

[Jawaban]

Kita perlu membuat model Dart (seperti kelas ProductEntry yang saya buat) karena model mengubah data JSON yang "mentah" dan tidak terstruktur menjadi objek Dart yang aman, terstruktur, dan mudah digunakan.

Konsekuensi jika hanya menggunakan `Map<String, dynamic>` lumayan berisiko karena,

1. Tidak Ada Keamanan Tipe (Type Safety): JSON tidak menjamin tipe data. Django mungkin mengirim `{"price": 200000}` (integer), tapi bisa juga mengirim `{"price": "200000"}` (string). Jika kita langsung memakai Map dan mencoba melakukan operasi seperti (`map['price'] * 2`), aplikasi akan crash saat runtime jika datanya ternyata string. Dengan Model, Model Dart `ProductEntry.fromJson` memaksa konversi tipe saat data pertama kali diterima (misalnya, `price: json["price"]` yang didefinisikan sebagai `int`). Jika data tidak valid bisa menanganinya saat itu juga, bukan nanti saat aplikasi crash.

2. Tidak Ada Keamanan Null (Null-Safety): yang terjadi jika JSON yang diterima tidak memiliki field `name` yaitu saat mencoba mengakses `map['name']`, nilainya akan null. Jika mencoba menampilkannya di `Text`, aplikasi akan error. Dengan model, constructor null-safe (misal pakai `required this.name`), Dart akan menjamin bahwa objek `ProductEntry` tidak akan pernah bisa dibuat jika data `name` tidak ada, sehingga mencegah error `null` kedepannya.

3. Sulit Dirawat (Maintainability): Menggunakan `Map` membuat kode kotor dan rawan typo. Untuk mengakses nama produk, mungkin harus menulis `data[index]['fields']['name']`. Jika salah ketik (`'naem'`), aplikasi akan error. Dengan Model, cukup menulis `product.name`. Kode jadi lebih bersih, autocomplete di IDE berfungsi, dan jika ingin mengganti nama field (misalnya dari `name` ke `productName`), kita bisa merefactor-nya sekali saja di model, dan IDE akan memperbaikinya di semua tempat.

</details>


<details> <summary>2. Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.</summary>

[Jawaban]

Keduanya berfungsi untuk melakukan komunikasi HTTP (API call) ke server Django, tapi memiliki peran yang sangat berbeda.

- `http` : package dasar untuk komunikasi HTTP. Fungsinya untuk mengirim permintaan (GET, POST) dan menerima respons. `http` bersifat stateless, tidak mengingat apapun tentang permintaan sebelumnya.    
- `CookieRequest`: package pembungkus (wrapper) dari `pbp_django_auth` yang internalnya menggunakan package `http`. Berfungsi untuk menambahkan manajemen sesi (session management).

**Perbedaan Perannya**: http bisa dianggap sebagai pengirim surat biasa yang setiap kali akan mengirim surat perlu menulis alamat pengirim dan alamat tujuan, yang mana petugas pos tidak mengingat si receiver.

Sedangkan `CookieRequest` adalah seperti pengirim surat yang memegang kartu identitas receiver. Saat pertama kali login (menggunakan `request.login`), server Django akan membalas, "OK, ini kartu identitasnya (cookie `sessionid`)." Dengan begitu, `CookieRequest` menyimpan cookie-nya.

Setiap kali membuat permintaan lain (seperti `request.get` atau `request.logout`), `CookieRequest` akan melampirkan cookie itu secara otomatis. Inilah yang membuat Django tahu "Oh, ini adalah pengguna yang sudah login," sehingga kita bisa mengakses data my products.

</details>

<details> <summary>3. Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.</summary>

[Jawaban]

Instance `CookieRequest` perlu dibagikan karena instance ini akan menyimpan state (status) login aplikasi kita, yaitu session cookie yang didapat dari Django.

Jika tidak membagikannya, maka akan terjadi:
1. Di `LoginPage`, kita membuat `CookieRequest` (Instansi A). Kita login. Instansi A sekarang menyimpan cookie sesi.
2. Kita pindah ke halaman `ProductEntryListPage`. Di halaman ini, kita membuat `CookieRequest` baru (Instansi B) untuk mengambil data.
3. Instansi B ini kosong. Ia tidak tahu apa-apa tentang cookie yang disimpan oleh Instansi A.
4. Saat Instansi B meminta data ke Django, Django melihatnya sebagai anonymous user (karena tidak ada cookie sesi) dan tidak akan bisa mengambil data my products.

Oleh karena itu, kita harus membuat satu instansi `CookieRequest` saja saat aplikasi pertama kali berjalan, dan membagikannya ke semua komponen (widget/halaman). Dalam proyek ini, saya melakukannya dengan `Provider` di `lib/main.dart`.

Dengan begitu, `LoginPage`, `ProductEntryListPage`, dan `LeftDrawer` semuanya mengakses dan menggunakan instansi yang sama persis, memastikan state login konsisten di seluruh aplikasi.

</details>

<details> <summary>4. Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django.</summary>

[Jawaban]

Ada 4 konfigurasi utama yang diperlukan:

1. `10.0.2.2` di `ALLOWED_HOSTS` (Django): 10.0.2.2 adalah alamat IP khusus yang digunakan di dalam Android Emulator untuk merujuk ke `localhost` (atau `127.0.0.1`) dari komputer host (laptop kita). `ALLOWED_HOSTS` di `settings.py` adalah fitur keamanan Django. Jika Django menerima request yang ditujukan ke host `10.0.2.2` dan IP itu tidak ada di daftar, Django akan menolaknya. Dan apabila tidak dilakukan, Aplikasi Flutter akan gagal total saat mencoba koneksi ke Django, dan di terminal Django akan muncul error "DisallowedHost".
2. Izin Internet (Android): Aplikasi Android berjalan dalam sandbox dan secara default tidak diizinkan mengakses internet, sehingga harus secara eksplisit meminta izin ini dengan menambahkan `<uses-permission android:name="android.permission.INTERNET"/>` ke dalam file `AndroidManifest.xml`. Dan apabila tidak dilakukan, sistem operasi Android akan memblokir semua upaya aplikasi Flutter untuk membuat panggilan HTTP. Aplikasi tidak akan bisa login, register, atau mengambil data, dan kemungkinan akan melempar `SocketException` (Network is unreachable).
3. Konfigurasi CORS (Django): CORS (Cross-Origin Resource Sharing) adalah kebijakan keamanan browser. Jika aplikasi Flutter kita dijalankan di web, browser akan melarang kode JavaScript (yang menjalankan Flutter web) di domain `A` (misal, `localhost:1234`) untuk mengambil data dari domain `B` (`localhost:8000`). Dengan menambahkan CORS_ALLOW_ALL_ORIGINS = True di settings.py, kita memberi tahu browser "Server saya diizinkan untuk diakses oleh domain manapun". Jika tidak dilakukan Aplikasi Flutter versi mobile mungkin masih bisa berjalan, tetapi aplikasi Flutter versi web akan gagal total mengambil data dan akan menampilkan "CORS policy" error di konsol browser.
4. Pengaturan `SameSite` Cookie (Django):hal ini terkait dengan CORS. Bahkan jika CORS mengizinkan request, browser modern mungkin tetap memblokir pengiriman cookie (seperti `sessionid`) jika request itu cross-origin. Dengan mengatur `CSRF_COOKIE_SAMESITE = 'None'` dan `SESSION_COOKIE_SAMESITE = 'None'`, kita memberi tahu browser untuk selalu mengirim cookie bahkan pada request cross-origin. Jika tidak dilakukan, Login mungkin terlihat berhasil, tetapi browser tidak akan pernah mengirimkan kembali session cookie pada request berikutnya. Akibatnya, Django akan selalu menganggap kita sebagai anonymous user setiap kali kita mencoba mengambil data yang butuh login.

</details>

<details> <summary>5. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.</summary>

[Jawaban]

Berikut  alur dari form ke list(Input -> Simpan -> Ambil -> Tampil):
1. Input (Flutter): Pengguna membuka `ProductFormPage`. Mereka mengisi `TextFormField` untuk "Nama Produk", "Harga", dll. Data ini disimpan dalam variabel state lokal (seperti _name, _price).
2. Pengiriman (Flutter): Pengguna menekan tombol "Save".
- Sebuah Map Python ({"name": _name, "price": _price, ...}) dibuat.
- jsonEncode mengubah Map ini menjadi sebuah string JSON.
- CookieRequest.postJson mengirimkan string JSON ini sebagai body dari HTTP POST request ke endpoint Django /create-flutter/.
3. Penerimaan & Penyimpanan (Django):
- Endpoint `/create-flutter/` terhubung ke view create_product_flutter.
- View ini membaca body request (json.loads(request.body)), mem-parsing string JSON kembali menjadi data Python.
- View ini membuat instance model Product baru dengan data tersebut (Product(name=...)), menghubungkannya dengan request.user, dan memanggil new_product.save().
- Data disimpan ke database. Django mengirim balasan JsonResponse({"status": "success"}).
4. Pengambilan (Flutter): Pengguna pindah ke halaman ProductEntryListPage.
- FutureBuilder memanggil fungsi fetchProduct.
- fetchProduct menggunakan CookieRequest.get untuk membuat HTTP GET request ke endpoint /get-products/.
5. Pengiriman (Django):
- View get_products_json dipanggil.
- View ini mengambil semua produk dari database (Product.objects.all()).
- Data ini diserialisasi menjadi format JSON (daftar besar berisi data produk, termasuk data yang baru saja kita simpan) dan dikirim sebagai JsonResponse.
6. Penampilan (Flutter):
- FutureBuilder di product_entry_list.dart menerima data JSON tersebut.
- ListView.builder diaktifkan. Ia mengulang data JSON itu.
- Untuk setiap item dalam daftar, ia memanggil ProductEntry.fromJson(item) untuk membuat objek Dart.
- Objek ProductEntry ini dilempar ke ProductEntryCard, yang kemudian me-render Text, Image.network, dll., ke layar.

</details>

<details> <summary>6. Jelaskan mekanisme autentikasi dari login, register, hingga logout.</summary>

[Jawaban]

Mekanisme ini berada pada pertukaran dan penyimpanan cookie yang dikelola oleh CookieRequest

1. Register
- Flutter: Pengguna mengisi form di RegisterPage. Saat "Register" ditekan, CookieRequest.postJson mengirim data (username, password1, password2) ke endpoint Django /auth/register/.
- Django: View register menerima data. Ia memvalidasi (apakah password cocok? apakah username unik?). Jika valid, User.objects.create_user() dipanggil untuk membuat user baru di database.
- Response: Django mengirim JsonResponse berisi status sukses. Flutter menampilkan SnackBar dan mengarahkan pengguna ke LoginPage. (Tidak ada cookie yang dibuat di tahap ini).

2. Login
- Flutter: Pengguna mengisi form di LoginPage. Saat "Login" ditekan, method khusus CookieRequest.login dipanggil. Ini mengirimkan username dan password ke /auth/login/.
- Django: View login menerima kredensial.
1. authenticate(username=..., password=...) dipanggil untuk memverifikasi apakah kredensial itu benar.
2. Jika benar, auth_login(request, user) dipanggil. Ini adalah inti prosesnya: Django membuat session baru di databasenya dan mengaitkannya dengan user tersebut.
- Response: Django mengirim JsonResponse berisi status sukses. Yang terpenting, respons ini juga menyertakan header Set-Cookie yang berisi sessionid dan csrftoken.
- Flutter: CookieRequest otomatis mendeteksi dan menyimpan cookie sessionid dan csrftoken ini di dalam memorinya. Properti request.loggedIn kini menjadi true. Flutter kemudian memakai Navigator.pushReplacement untuk membuang halaman login dan menampilkan MyHomePage.

3. Mengakses Halaman (Setelah Login)
- Flutter: Pengguna berada di MyHomePage dan menekan "My Products". Ini membuka ProductEntryListPage (dengan filter "my").
- Fungsi fetchProduct memanggil request.get ke /get-products/?filter=my.
- CookieRequest otomatis melampirkan sessionid dan csrftoken yang sudah disimpannya ke dalam header request ini.
- Django: View get_products_json menerima request. Berkat middleware Django, ia melihat sessionid, mencocokkannya di database, dan secara otomatis mengisi request.user dengan objek user yang sesuai.
- Response: Karena request.user sudah terisi (tidak lagi anonim), kode filter Product.objects.filter(user=request.user) berhasil dieksekusi, dan hanya produk milik user itu yang dikirim kembali ke Flutter.

4. Logout
- Flutter: Pengguna menekan "Logout" di LeftDrawer. Ini memanggil CookieRequest.logout ke endpoint /auth/logout/.
- Django: View logout memanggil auth_logout(request). Ini menghapus sesi pengguna dari database Django dan mengirim sinyal untuk menghapus cookie.
- Flutter: CookieRequest menghapus sessionid dan csrftoken dari memorinya. Properti request.loggedIn menjadi false. Flutter kembali menggunakan Navigator.pushReplacement untuk membuang MyHomePage dan kembali ke LoginPage.

</details>


<details> <summary>7. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step!</summary>

[Jawaban]

Berikut adalah langkah-langkah implementasi yang saya lakukan untuk tugas 9:

1. Konfigurasi Awal dan Autentikasi:
- Saya memulai dengan mengonfigurasi lib/main.dart. Saya membungkus MaterialApp dengan Provider agar satu instance CookieRequest bisa dipakai di seluruh aplikasi.
- Saya mengatur home di main.dart agar menunjuk ke LoginPage sebagai halaman pertama.
- Saya membuat lib/screens/login.dart dan lib/screens/register.dart. Saya menghubungkan keduanya (dari Login bisa ke Register, dan setelah Register sukses, kembali ke Login).
- Saya mengimplementasikan request.login di LoginPage dan request.postJson ke endpoint register di RegisterPage.
- Saya menambahkan fitur logout di lib/widgets/left_drawer.dart menggunakan request.logout.

2. Pembuatan Model Data:
- Saya membuat file lib/models/product_entry.dart.
- Di dalamnya, saya mendefinisikan kelas ProductEntry dengan semua atribut yang sesuai dengan JSON dari Django (termasuk name, price, description, thumbnail, category, is_featured, stock, brand, user_id, dan user_username).
- Saya mengimplementasikan factory constructor ProductEntry.fromJson untuk mengubah Map<String, dynamic> menjadi objek ProductEntry yang aman.

3. Halaman Daftar Item:
- Saya membuat file lib/screens/product_entry_list.dart.
- Di dalamnya, saya membuat fungsi Future<List<ProductEntry>> fetchProduct(CookieRequest request) yang menggunakan request.get untuk mengambil data dari endpoint /get-products/ Django.
- Saya menggunakan FutureBuilder untuk menangani loading state (menampilkan CircularProgressIndicator).
- Setelah data diterima, saya menggunakan ListView.builder untuk me-render daftar item.

4. Membuat Card Tampilan Item:
- Saya membuat widget kustom di lib/widgets/product_entry_card.dart.
- Widget ini menerima satu objek ProductEntry. Saya menatanya menggunakan Card, Column, Image.network (untuk thumbnail, lengkap dengan errorBuilder), dan beberapa Text widget untuk menampilkan name, price, dan description (dibatasi 100 karakter).
- Saya menggunakan Image.network dengan URL proxy (http://localhost:8000/proxy-image/?url=...) agar gambar eksternal bisa dimuat di emulator.

5. Halaman Detail Item:
- Saya membuat file lib/screens/product_detail.dart. Halaman ini menerima objek ProductEntry lewat constructor-nya.
- Saya menggunakan Scaffold dengan AppBar (yang otomatis memberi tombol kembali) dan SingleChildScrollView agar kontennya bisa di-scroll.
- Di dalamnya, saya menampilkan semua atribut produk, termasuk Image.network untuk gambar besar, name, price, category, brand, stock, dan description secara penuh.

6. Menghubungkan List dan Detail:
- Saya kembali ke product_entry_list.dart.
- Di ListView.builder, saya menambahkan properti onTap pada ProductEntryCard.
- onTap ini menjalankan Navigator.push yang mengarahkan pengguna ke ProductDetailPage, sambil mengirimkan objek product yang sesuai (MaterialPageRoute(builder: (context) => ProductDetailPage(product: snapshot.data![index]))).

7. Implementasi Filter "My Products":
- Di lib/screens/menu.dart dan lib/widgets/left_drawer.dart, saya menambahkan navigasi untuk "All Products" dan "My Products".
- Kedua tombol ini mengarah ke ProductEntryListPage, namun dengan parameter constructor yang berbeda: const ProductEntryListPage(filter: "all") dan const ProductEntryListPage(filter: "my").
- Terakhir, saya memodifikasi fungsi fetchProduct di product_entry_list.dart untuk memeriksa widget.filter. Jika widget.filter == "my", URL request diubah menjadi .../get-products/?filter=my. Jika tidak, URL default .../get-products/ yang digunakan.

Di lib/widgets/left_drawer.dart juga saya menambahkan tombol Logout, yang memanggil request.logout dan mengembalikan pengguna ke LoginPage.

</details>

</details>