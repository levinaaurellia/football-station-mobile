## Jawab Pertanyaan Tugas
---
<details>
<summary>📘 Tugas 7</summary>

1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) 
bekerja antar widget.   
[Jawab]    
*Widget Tree*    
Pada Flutter, semua UI dibangun dari widget. Saat aplikasi berjalan, Flutter mengatur widget-widget 
itu dalam hierarki (tree) yang merepresentasikan tampilan pada state/config saat ini. Widget 
bersifat deklaratif dan immutable; ketika state berubah, Flutter membangun ulang deskripsi UI 
dan hanya menerapkan perubahan yang diperlukan.

Flutter memisahkan tiga pohon yang saling terkait:
- Widget tree: deklarasi/config UI. 
- Element tree: objek aktif yang menjembatani widget dengan sistem render. 
- RenderObject tree: menangani perhitungan ukuran, layout, dan proses menggambar di layar. 
Memisahkan ketiga pohon ini membuat update UI efisien dan terkontrol.

*Hubungan Parent-Child Bekerja Antar Widget*
1) Constraints mengalir ke bawah: parent mengirim batas ukuran (min/max) ke child. 
2) Size mengalir ke atas: child memilih ukuran di dalam constraint tersebut dan melaporkannya ke parent. 
3) Parent memposisikan child di areanya.

Hal ini menjelaskan mengapa sebuah widget tidak bisa semudah itu  menentukan ukuran/posisinya sendiri.
Selain layout, banyak hal yang berkaitan dari parent ke child melalui `BuildContext` 
(mis. `Theme.of(context)`, `Navigator.of(context)`, `InheritedWidget/state-management`). 
`BuildContext` sebenarnya sebuah Element penunjuk lokasi widget di tree sehingga ia tahu siapa 
parent/ancestor-nya.

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


2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
[Jawab]   
Berdasarkan file `lib/main.dart` dan `lib/menu.dart`, berikut adalah semua widget yang saya gunakan 
dalam proyek "football_station" beserta fungsinya:
*Widget Utama (Aplikasi & Halaman)*
1) `StatelessWidget`: Ini adalah kelas dasar (induk) yang digunakan untuk membuat widget sendiri 
yang tidak memiliki status internal (tidak bisa berubah sendiri). `MyApp`, `MyHomePage`, `InfoCard`,
dan `ItemCard` semuanya adalah turunan dari `StatelessWidget`.
2) `MaterialApp`: Ini adalah widget root dari seluruh aplikasi. Fungsinya adalah menyediakan banyak 
fitur standar Material Design, seperti navigasi (perpindahan halaman) dan tema (termasuk warna utama 
yang  diatur). 
3) `Scaffold`: Widget ini menyediakan struktur visual dasar untuk halaman (layar). Di `MyHomePage`, 
saya menggunakannya untuk menampung `AppBar` (di bagian atas) dan `body` (konten utama halaman). 
4) `AppBar`: Ini adalah bar judul di bagian atas layar. Kamu menggunakannya untuk menampilkan 
judul 'Football Station'.

*Widget Layout (Tata Letak)*
1) `Padding`: Memberikan ruang kosong di sekeliling child-nya. Digunakan untuk memberi jarak 16.0 
piksel di sekeliling seluruh konten di dalam `body`. 
2) `Column`: Mengatur children (anak-anaknya) dalam daftar vertikal (dari atas ke bawah). Digunakan 
sebagai penampung utama di `body` dan juga di `InfoCard` dan `ItemCard`. 
3) `Row`: Mengatur children (anak-anaknya) dalam daftar horizontal (dari kiri ke kanan). Digunakan 
untuk menyusun tiga `InfoCard` (NPM, Nama, Kelas). 
4) `SizedBox`: Membuat sebuah kotak kosong dengan ukuran tetap. Digunakan untuk memberi jarak 
vertikal (spasi) setinggi 16.0 piksel antara Row info dan Center di bawahnya. 
5) `Center`: Menempatkan child-nya di tengah-tengah ruang yang tersedia. Digunakan untuk memusatkan 
`Column` yang berisi teks sambutan dan `GridView`. 
6) `GridView`: Menampilkan children-nya dalam sebuah grid, menggunakan `GridView.count` untuk 
membuat grid dengan 3 kolom yang menampilkan `ItemCard`. 
7) `Container`: Widget serbaguna untuk tata letak, pewarnaan, dan ukuran. Digunakan di dalam 
`InfoCard` untuk mengatur lebar (width) dan padding, serta di dalam `ItemCard` untuk mengatur padding.

*Widget Kustom*
1) `MyHomePage`: Widget kustom sebagai halaman utama aplikasi. 
2) `InfoCard`: Widget kustom untuk menampilkan kotak kartu berisi judul (NPM/Nama/Kelas) dan isinya. 
3) `ItemCard`: untuk menampilkan tombol-tombol di GridView, lengkap dengan ikon, teks, warna latar 
belakang, dan event saat ditekan.

*Widget Tampilan & Interaksi*
1) `Text`: Menampilkan string (teks) di layar untuk semua teks yang terlihat di aplikasi. 
2) `Icon`: Menampilkan ikon grafis di dalam `ItemCard` untuk menampilkan ikon (seperti Icons.grid_view, dll.). 
3) `Card`: Widget dasar dari `InfoCard` yang juga merupaka design yang memiliki sudut sedikit 
membulat dan bayangan. 
4) `Material`: menyediakan "kanvas" Material Design. Digunakan di `ItemCard` sebagai dasar untuk 
memberikan warna latar belakang, bentuk melengkung (borderRadius), dan efek splash saat ditekan. 
5) `InkWell`: Membuat child-nya (dalam hal ini Container di ItemCard) dapat merespons sentuhan dan 
menampilkan efek percikan saat ditekan. Digunakan untuk menangani `onTap`. 
6) `ScaffoldMessenger`: Mengelola `SnackBar`. Memanggilnya (`ScaffoldMessenger.of(context)`) untuk 
menampilkan pesan `SnackBar` saat `ItemCard` ditekan. 
7) `SnackBar`: Pesan sementara yang muncul di bagian bawah layar. Digunakan untuk memberi tahu 
pengguna tombol mana yang telah mereka tekan.

*Widget Data & Styling*
1) `ThemeData`: Mendefinisikan konfigurasi visual untuk `MaterialApp`, seperti warna. Digunakan 
untuk mengatur warna primer aplikasi. 
2) `ColorScheme`: Bagian dari `ThemeData` yang secara spesifik mengatur skema warna aplikasi. 
3) `TextStyle`: Mendefinisikan properti visual untuk `Text`, seperti `color`, `fontWeight`, `fontSize`. 
4) `MediaQuery`: Digunakan untuk mendapatkan informasi tentang media saat ini (seperti ukuran layar). 
Digunakan di `InfoCard` untuk mengatur lebarnya secara responsif (`MediaQuery.of(context).size.width / 3.5`).


3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
[Jawab]     
`MaterialApp` adalah widget inti yang membungkus seluruh aplikasi. Bisa dianggap rangka utama untuk 
aplikasi yang menggunakan gaya Material Design. Fungsi utamanya adalah menyediakan berbagai fitur 
level aplikasi yang dibutuhkan agar semua halaman dan widget di dalamnya bisa berfungsi dengan baik.

Dia harus berada di level tertinggi (seperti di dalam `MyApp`) karena dia menyediakan tiga hal penting 
yang harus bisa diakses oleh semua widget di bawahnya:
1) Mengatur Tema (Styling) `MaterialApp` adalah tempat menentukan `ThemeData` untuk aplikasi. 
Tema ini (seperti `colorScheme` yang diatur ke `Colors.blue`) akan secara otomatis diwariskan ke 
semua widget lain di bawahnya. Maka dari itu,  `AppBar` dan `ItemCard` di proyek tahu harus memakai 
warna biru tanpa perlu atur warnanya satu per satu di widget tersebut. 
2) Mengatur Navigasi (Pindah Halaman) `MaterialApp`lah yang mengelola rute di aplikasi. Saat ingin 
pindah dari satu layar ke layar lain, `MaterialApp` yang menangani prosesnya. Properti `home: MyHomePage()`
adalah cara memberi tahu `MaterialApp` widget mana yang harus ditampilkan sebagai halaman pertama 
saat aplikasi dibuka. 
3) Menyediakan Layanan Dasar yang dibutuhkan aplikasi, seperti: `title` (judul aplikasi yang digunakan 
oleh sistem operasi), Lokalisasi (Bahasa) untuk mengatur dukungan berbagai bahasa, Builder untuk 
kustomisasi level atas lainnya.

Tanpa `MaterialApp` di paling atas, widget-widget seperti `Scaffold`, `AppBar`, dan lainnya tidak 
akan tahu tema apa yang harus dipakai atau bagaimana cara berpindah halaman.


4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
[Jawab]    
- `StatelessWidget` (Widget Statis) adalah widget yang tidak bisa berubah setelah digambar. 
Tampilannya murni ditentukan oleh data (konfigurasi) yang dikirimkan oleh parent-nya. 
- `StatefulWidget` (Widget Dinamis) adalah widget yang bisa berubah secara internal. Ia memiliki 
objek "State" (status) khusus yang bisa menyimpan data dan bisa diperbarui kapan saja kemudian 
meminta Flutter untuk menampilkan ulang widget itu di layar dengan tampilan yang baru.

Untuk memicu penggambaran ulang di StatefulWidget, panggil fungsi setState(). `StatelessWidget` tidak 
memiliki fungsi ini.

*Kapan Memilihnya*
1) Pilih `StatelessWidget` (Default)
- Widget tersebut "statis" dan hanya perlu menampilkan data yang dikirimkan padanya. 
- Widget tidak perlu mengingat apapun. 
- Tampilannya tidak akan pernah berubah berdasarkan input pengguna.
Contoh di football station: `InfoCard` adalah contoh Stateless. Ia menerima title dan content, 
menampilkannya, dan selesai. Ia tidak akan pernah mengubah title atau content itu sendiri.
2) Pilih `StatefulWidget` (Jika Perlu Berubah)
- Berubah karena interaksi pengguna. Contoh: `Checkbox` yang dicentang, `Slider` yang digeser, 
atau `TextField` tempat pengguna mengetik. 
- Menyimpan data internal yang bisa berubah. Contoh: Menghitung berapa kali tombol ditekan, 
menyimpan daftar item yang bisa ditambah atau dikurangi. 
- Menunggu data. Contoh: Menampilkan indikator loading selagi mengambil data dari internet, lalu 
menampilkan data itu setelah selesai.


5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
[Jawab]   
`BuildContext` itu seperti alamat-nya sebuah widget. Fungsi utamanya adalah memberi tahu sebuah 
widget di mana tepatnya lokasinya di dalam keseluruhan widget tree. Setiap widget yang sedang 
ditampilkan di layar memiliki `BuildContext`-nya sendiri yang unik, yang berisi informasi tentang 
posisinya relatif terhadap widget lain. `BuildContext` penting karena satu-satunya cara bagi sebuah 
widget untuk berinteraksi dengan widget yang ada di atasnya (parent, kakek, atau leluhurnya di dalam tree).
Widget tidak bisa "melihat ke atas" secara langsung. Ia harus menggunakan alamat-nya untuk meminta sesuatu.
Fungsi terpentingnya adalah untuk lookup data atau layanan dari widget ancestor terdekat.

*Penggunaannya di Metode `build`*
`Widget build(BuildContext context) { ... }`
Setiap kali Flutter ingin menggambar widget, ia akan memanggil metode `build` dan memberikan context 
sebagai parameter.

Di dalam metode `build` itulah kita gunakan context tersebut untuk:
1) Mengambil data dari atas di dalam `MyHomePage`, `AppBar` bisa berwarna biru karena 
`Theme.of(context).colorScheme.primary` secara internal menggunakan `context` untuk bertanya pada 
`MaterialApp` (yang ada di atasnya) apa warna primernya.
2) Menjalankan aksi di `ItemCard`, dengan menggunakan `ScaffoldMessenger.of(context).showSnackBar(...)`
hanya bisa bekerja karena context tersebut tahu di mana `Scaffold` (leluhurnya) berada, 
yang menyediakan layanan `ScaffoldMessenger`. 
3) Mengatur ukuran responsif Di `InfoCard`, dengan menggunakan `MediaQuery.of(context).size.width`. 
context digunakan untuk mencari info ukuran layar yang disediakan oleh `MaterialApp`.

Dengan begitu, `BuildContext` hanya bisa menemukan data dari widget yang posisinya di atas dia 
di dalam tree. Inilah mengapa  `MaterialApp` (yang menyediakan `Theme` dan `MediaQuery`) harus 
selalu berada di paling atas (root).


6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
[Jawab]   
`hot reload` memberikan file kode Dart yang baru diubah ke dalam Dart Virtual Machine (VM) yang 
sedang berjalan. VM kemudian langsung menggambar ulang widget tree. Kecepatannya sangat cepat yaitu
kurang dari 1 detik. Status (State) aplikasi tetap terjaga, jika sedang berada di halaman kelima 
aplikasi, sudah mengisi formulir, atau ada counter yang menunjukkan angka 10, setelah hot reload,
akan tetap berada di halaman kelima, formulir tetap terisi, dan counter tetap 10. Digunakan setiap 
kali mengubah tampilan (layout), warna, ukuran, atau teks di `StatelessWidget` atau `StatefulWidget`.

Sedangkan `hot restart` mematikan aplikasi yang sedang berjalan dan me-restart-nya dari awal. Ia 
memuat ulang semua kode (termasuk state awal). Kecepatannya auh lebih cepat daripada menghentikan 
dan menjalankan ulang aplikasi (Full Restart), tetapi lebih lambat dari Hot Reload (biasanya 
beberapa detik). Status (State) aplikasi hilang / direset, aplikasi akan kembali ke kondisi awal 
seperti baru saja dibuka. Digunakan saat:
- mengubah state awal dari `StatefulWidget`. 
- mengubah konstruktor widget (misalnya, `MyHomePage()` diubah menjadi `MyHomePage(title: "Baru")`). 
- menambahkan file asset baru (seperti gambar) atau font ke file `pubspec.yaml`. 
- Hot Reload gagal.

Jadi, perbedaan utamanya adalah `Hot Reload` sangat cepat dan hanya memuat ulang perubahan tampilan 
(UI) seperti mengganti warna atau tata letak di `menu.dart` tanpa mengulang aplikasi. Sehingga data 
(state) yang sedang aktif di halaman itu tidak akan hilang. Sedangkan, `Hot Restart` akan memulai 
ulang seluruh aplikasi dari awal, yang membuatnya lebih lambat. Akan menghapus semua data (state) 
yang sedang berjalan dan mengembalikan aplikasi ke halaman utamanya.

</details>

