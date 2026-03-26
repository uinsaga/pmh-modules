# Dasar Pemrograman Dart

## BAB 1: PENGENALAN DART

### 1.1 Apa Itu Dart dan Mengapa Dibuat?

#### Konsep Dasar

Dart adalah bahasa pemrograman yang dikembangkan oleh Google pada tahun 2011. Awalnya, Dart diciptakan untuk mengatasi keterbatasan JavaScript dalam pengembangan aplikasi web berskala besar. Namun, sejak tahun 2017 dengan hadirnya Flutter, Dart berkembang menjadi bahasa utama untuk pengembangan aplikasi multiplatform.

#### Mengapa Dart Penting?

1. **Satu Bahasa untuk Semua Platform**
   - Dart memungkinkan Anda menulis kode **sekali**, berjalan di **iOS, Android, Web, Windows, macOS, Linux**
   - Tidak perlu belajar bahasa berbeda untuk platform berbeda

2. **Performa Tinggi**
   - Dart dapat dikompilasi ke **native code** (AOT/Ahead-of-Time) sehingga aplikasi berjalan cepat seperti aplikasi native
   - Juga mendukung **JIT** (Just-in-Time) untuk hot reload saat development

3. **Modern dan Aman**
   - Dibuat dengan pengalaman 20+ tahun evolusi bahasa pemrograman
   - Fitur **null safety** menghilangkan error `NullPointerException` yang terkenal di Java/C#

#### Karakteristik Utama Dart

| Karakteristik         | Penjelasan                                                                      |
| --------------------- | ------------------------------------------------------------------------------- |
| **Object-Oriented**   | Segala sesuatu di Dart adalah object (termasuk angka, function, null)           |
| **Strongly Typed**    | Tipe data diperiksa saat compile time, mengurangi bug runtime                   |
| **Type Inference**    | Dart bisa menebak tipe data, sehingga kode tetap bersih meskipun strongly typed |
| **Garbage Collected** | Manajemen memori otomatis                                                       |
| **Async/Await**       | Dukungan bawaan untuk pemrograman asynchronous                                  |

---

## BAB 2: INSTALASI DAN SETUP

### Pengenalan Lingkungan Pengembangan

Sebelum mulai menulis kode, kita perlu menyiapkan lingkungan (environment) agar program Dart bisa dijalankan.

Ada dua cara yang bisa digunakan:

1. **Online (DartPad)**  
   Cocok untuk belajar dasar tanpa perlu instalasi.

2. **Local (Instalasi SDK)**  
   Digunakan untuk pengembangan yang lebih kompleks, seperti membuat project dan menggunakan package.

---

### Konsep SDK (Software Development Kit)

Untuk mengembangkan aplikasi menggunakan Dart, kita membutuhkan **Dart SDK**

Dart SDK berfungsi sebagai alat utama untuk:

- Mengkompilasi kode Dart
- Menjalankan program
- Mengelola package (dependency)
- Membuat dan mengelola project

---

### Menginstall Dart SDK

Untuk menginstall Dart SDK kita bisa mendownload aplikasinya di - [Get Dart SDK](https://dart.dev/get-dart)

### PATH Environment Variable

Saat proses instalasi, Dart biasanya ditambahkan ke dalam **PATH**.

PATH adalah daftar lokasi di sistem operasi yang digunakan untuk mencari perintah saat dijalankan di terminal.

Dengan adanya PATH, kita bisa menjalankan perintah seperti:

```bash
dart --version

```

Jika muncul versi Dart, maka instalasi berhasil.

---

### Membuat Project

Untuk membuat project dart kita bisa gunakan perintah:

```bash
dart create nama_project

```

### STRUKTUR DASAR PROGRAM DART

Setiap program Dart harus memiliki fungsi main() sebagai titik awal eksekusi program.

Program akan selalu mulai berjalan dari fungsi ini.

#### Contoh Program Sederhana

```dart
void main() {
  print('Hello, Dart!');
}

```

#### Penjelasan Komponen

`void` → tipe kembalian (tidak mengembalikan nilai)
`main` → nama fungsi utama (entry point)
`()` → parameter (opsional)
`{}` → blok kode program
`print()` → fungsi bawaan untuk menampilkan output

#### Catatan Penting

Fungsi main() wajib ada dalam setiap program Dart
Tanpa main(), program tidak dapat dijalankan
Semua kode pertama kali dieksekusi dari fungsi ini

---

## BAB 3: VARIABEL DAN TIPE DATA

### 3.1 Variabel: Wadah Penyimpanan Data

#### Konsep Dasar

Variabel adalah **tempat di memori komputer** yang diberi nama untuk menyimpan data. Bayangkan variabel seperti **kotak dengan label**:

- **Nama variabel** = label pada kotak
- **Nilai** = isi di dalam kotak
- **Tipe data** = jenis barang yang boleh dimasukkan (misalnya hanya angka, atau hanya teks)

#### Mengapa Kita Perlu Variabel?

1. **Menyimpan data** yang akan digunakan kembali
2. **Memberi makna** pada data (misalnya `umur` lebih jelas daripada `20`)
3. **Mengubah data** selama program berjalan

#### Cara Deklarasi Variabel di Dart

```dart
// Cara 1: Eksplisit (menyebutkan tipe data)
// Kelebihan: jelas dan aman
String nama = "Budi Santoso";
int umur = 25;
double tinggi = 175.5;
bool menikah = false;

// Cara 2: Type Inference (menggunakan var)
// Dart akan menebak tipe data berdasarkan nilai yang diberikan
// Kelebihan: kode lebih ringkas
var alamat = "Jl. Merdeka No. 10";  // Otomatis menjadi String
var nilai = 85.5;                    // Otomatis menjadi double
var isActive = true;                 // Otomatis menjadi bool

// Cara 3: Dynamic (menunda penentuan tipe)
// HATI-HATI: dapat menyebabkan error runtime
dynamic data = "Bisa berubah tipe";
data = 100;  // Boleh, tapi berisiko karena tidak ada pengecekan tipe
```

**Penjelasan Perbedaan:**

- **Eksplisit** → aman, jelas, direkomendasikan untuk kode yang akan dibaca banyak orang
- **var** → efisien, tetap aman karena tipe ditentukan di awal dan tidak bisa berubah
- **dynamic** → fleksibel tapi berisiko, hindari kecuali memang diperlukan

---

### 3.2 Tipe Data Dasar: Apa Saja dan Kapan Menggunakannya?

#### Konsep: Tipe Data

Tipe data adalah **klasifikasi** yang memberi tahu komputer:

- Berapa banyak memori yang diperlukan
- Operasi apa yang bisa dilakukan pada data tersebut

#### Jenis Tipe Data di Dart

| Tipe Data  | Ukuran Memori | Kapan Digunakan                                             | Contoh                          |
| ---------- | ------------- | ----------------------------------------------------------- | ------------------------------- |
| **int**    | 64 bit        | Untuk bilangan bulat (tanpa koma)                           | umur, jumlah, tahun             |
| **double** | 64 bit        | Untuk bilangan desimal                                      | tinggi, berat, nilai ujian      |
| **String** | Dinamis       | Untuk teks                                                  | nama, alamat, deskripsi         |
| **bool**   | 1 bit         | Untuk kondisi benar/salah                                   | status login, aktif/tidak       |
| **num**    | 64 bit        | Supertype int & double, jika tipe bisa integer atau desimal | nilai yang bisa bulat atau koma |

```dart
// int: bilangan bulat
int umur = 25;
int jumlahAnak = 2;
int tahunLahir = 1998;

// double: bilangan desimal
double tinggiBadan = 175.5;
double beratBadan = 68.3;
double phi = 3.14159265359;

// String: teks (bisa dengan petik satu atau dua)
String nama = "Budi Santoso";
String alamat = 'Jl. Merdeka No. 10';
String multiLine = '''
Ini adalah teks
yang terdiri dari
beberapa baris
''';

// bool: hanya true atau false
bool isLogin = true;
bool isPremium = false;
bool isActive = true;

// num: bisa int atau double
num nilai = 85;      // bisa integer
num nilaiDesimal = 85.5;  // bisa double
```

#### Konsep: String Interpolation

String interpolation adalah cara **menyisipkan nilai variabel ke dalam string** tanpa perlu operator +.

```dart
String nama = "Budi";
int umur = 25;

// Tanpa interpolation (konkatenasi)
print("Halo " + nama + ", umur Anda " + umur.toString() + " tahun");

// Dengan interpolation (lebih bersih)
print("Halo $nama, umur Anda $umur tahun");

// Untuk ekspresi, gunakan ${}
print("5 tahun lagi umur Anda ${umur + 5} tahun");
```

---

### 3.3 Null Safety: Fitur Revolusioner Dart

#### Konsep: Apa Itu Null?

**Null** adalah nilai khusus yang berarti "tidak ada nilai" atau "kosong". Dalam banyak bahasa pemrograman (Java, C#, JavaScript), null bisa menyebabkan error yang terkenal: **NullPointerException** atau **Cannot read property of null**.

#### Masalah yang Diselesaikan Null Safety

Bayangkan skenario ini:

```dart
// Tanpa null safety (contoh di bahasa lain)
String nama = null;  // Diperbolehkan
print(nama.length);  // ERROR! Karena null tidak punya property length
```

Error seperti ini sering terjadi dan sulit dilacak karena muncul saat runtime (saat program berjalan), bukan saat coding.

#### Solusi Dart: Null Safety

Dart memperkenalkan **null safety** yang memisahkan tipe data menjadi:

1. **Non-nullable** (tidak boleh null) → default
2. **Nullable** (boleh null) → ditandai dengan `?`

```dart
// Non-nullable (default)
// Variabel ini WAJIB memiliki nilai, tidak boleh null
String nama = "Budi";
// nama = null;  // ERROR! Tidak bisa diisi null

// Nullable (boleh null)
// Variabel ini bisa diisi null
String? alamat = null;  // Diperbolehkan

// Dengan null safety, error terdeteksi saat coding!
// print(alamat.length);  // ERROR! Alamat bisa null, tidak aman
```

#### Kenapa Null Safety Penting?

1. **Error Terdeteksi Sejak Coding** → bukan saat program jalan
2. **Kode Lebih Aman** → tidak ada kejutan NullPointerException
3. **Dokumentasi Implisit** → tanda `?` menunjukkan variabel boleh kosong

#### Null-Aware Operators: Operator untuk Menangani Null

```dart
String? text;  // nullable, nilainya null

// 1. ?. (Conditional Access)
// Hanya akses property jika tidak null
print(text?.length);  // null, bukan error

// 2. ?? (Null Coalescing)
// Berikan nilai default jika null
String hasil = text ?? "default";  // "default"

// 3. ??= (Null Coalescing Assignment)
// Assign nilai hanya jika null
text ??= "nilai baru";  // text menjadi "nilai baru"

// 4. ! (Assertion Operator)
// Beri tahu compiler bahwa kita yakin nilai tidak null
// HATI-HATI: jika ternyata null, tetap error!
String pastiAda = text!;  // Programmer bertanggung jawab
```

#### Konsep: Mengapa Tidak Semua Nullable?

Dart memilih **non-nullable sebagai default** karena:

- Mayoritas variabel seharusnya tidak pernah null
- Memaksa programmer memikirkan penanganan null sejak awal
- Menghasilkan kode yang lebih aman dan terprediksi

---

### 3.4 Final dan Const: Membuat Variabel yang Tidak Berubah

#### Konsep: Immutability (Kekekalan Nilai)

Terkadang kita ingin nilai variabel **tidak dapat diubah** setelah ditetapkan. Ini berguna untuk:

- Nilai konstanta matematika (phi, kecepatan cahaya)
- Konfigurasi yang tidak berubah
- Mencegah bug karena perubahan tidak sengaja

#### Perbedaan final vs const

| Aspek               | final                                    | const                                      |
| ------------------- | ---------------------------------------- | ------------------------------------------ |
| **Waktu penetapan** | Runtime (saat program berjalan)          | Compile-time (saat kode dikompilasi)       |
| **Nilai**           | Ditentukan sekali, bisa dari perhitungan | Harus diketahui sebelum program dijalankan |
| **Contoh**          | `final sekarang = DateTime.now()`        | `const phi = 3.14`                         |

```dart
// final: nilai ditentukan saat program berjalan
final DateTime waktuSekarang = DateTime.now();  // Waktu saat program dijalankan
final int angkaAcak = Random().nextInt(100);    // Bisa dari fungsi

// const: nilai harus diketahui saat compile time
const double phi = 3.14159265359;
const String appName = "Aplikasi Saya";
const List<int> angkaTetap = [1, 2, 3];  // List ini juga immutable

// const dengan ekspresi yang bisa dievaluasi compile-time
const int hasil = 10 * 5;  // Boleh, karena 10*5 bisa dihitung saat compile
// const int sekarang = DateTime.now().year;  // ERROR! DateTime.now() adalah runtime
```

#### Kapan Menggunakan?

- **const** → nilai benar-benar tetap dan diketahui sebelum program jalan
- **final** → nilai ditentukan sekali saat program berjalan, lalu tidak berubah

---

### 3.5 Lazy Initialization (late): Menunda Inisialisasi

#### Konsep: Mengapa Perlu Lazy?

Dengan null safety, semua variabel non-nullable **harus diinisialisasi** saat dideklarasikan atau di constructor. Namun ada situasi di mana:

1. Nilai belum tersedia saat deklarasi
2. Inisialisasi memakan waktu (misalnya baca file besar)
3. Kita ingin inisialisasi hanya saat variabel benar-benar digunakan

#### Solusi: Keyword `late`

`late` memberi tahu Dart: "Variabel ini akan diisi nanti, saya janji sebelum digunakan".

```dart
// Tanpa late: error karena belum diinisialisasi
// String nama;  // ERROR: Non-nullable variable must be assigned

// Dengan late: diizinkan
late String nama;
// ... kode lain ...
nama = "Budi";  // Diisi sebelum digunakan
print(nama);    // Boleh

// Lazy initialization: hanya dijalankan saat pertama kali diakses
class DatabaseService {
  // Koneksi database baru dibuat saat pertama kali diakses
  late final DatabaseConnection _connection = _createConnection();

  DatabaseConnection _createConnection() {
    print("Membuat koneksi database...");  // Hanya dijalankan sekali
    return DatabaseConnection();
  }

  void query() {
    // Saat method ini dipanggil, _connection akan dibuat
    _connection.execute("SELECT * FROM users");
  }
}
```

#### Manfaat Lazy Initialization

1. **Efisiensi** → objek berat hanya dibuat jika benar-benar dibutuhkan
2. **Circular Reference** → memungkinkan dua objek saling mereferensi
3. **Keterbacaan** → tidak perlu nullable hanya karena inisialisasi tertunda

---

### 3.6 Type Conversion: Mengubah Tipe Data

#### Konsep: Mengapa Perlu Konversi?

Terkadang data dalam satu tipe perlu digunakan sebagai tipe lain, misalnya:

- Input dari pengguna selalu berupa String, tapi kita butuh int untuk perhitungan
- Hasil perhitungan double perlu ditampilkan sebagai String

```dart
// String ke int
String strAngka = "123";
int angka = int.parse(strAngka);  // 123

// String ke double
String strDesimal = "45.67";
double desimal = double.parse(strDesimal);  // 45.67

// String ke int dengan tryParse (aman dari error)
int? aman = int.tryParse("abc");  // null, bukan error
if (aman != null) {
  print("Berhasil: $aman");
} else {
  print("Gagal konversi");
}

// int/double ke String
String teksInt = 100.toString();  // "100"
String teksDouble = 3.14159.toStringAsFixed(2);  // "3.14"

// Konversi antar numerik
int keDouble = 10.toDouble();   // 10.0
double keInt = 10.9.toInt();    // 10 (pembulatan ke bawah)
double keIntRound = 10.9.round();  // 11 (pembulatan matematis)
```

---

## BAB 4: OPERATOR

### 4.1 Konsep Dasar Operator

#### Apa Itu Operator?

Operator adalah **simbol khusus** yang memberi tahu compiler untuk melakukan operasi tertentu terhadap operand (nilai/variabel). Contoh: `+` memberi tahu untuk menjumlahkan.

#### Jenis Operator Berdasarkan Jumlah Operand

- **Unary**: satu operand (`!true`, `i++`)
- **Binary**: dua operand (`a + b`)
- **Ternary**: tiga operand (`condition ? true : false`)

---

### 4.2 Operator Aritmatika: Untuk Perhitungan Matematika

#### Konsep

Operator aritmatika digunakan untuk melakukan operasi matematika dasar. Semua operator ini mengembalikan nilai numerik.

```dart
int a = 10, b = 3;

print(a + b);   // 13  (penjumlahan)
print(a - b);   // 7   (pengurangan)
print(a * b);   // 30  (perkalian)
print(a / b);   // 3.333... (pembagian, hasil selalu double)
print(a ~/ b);  // 3   (pembagian integer, hasil dibulatkan ke bawah)
print(a % b);   // 1   (modulo/sisa bagi)
```

**Penjelasan Tambahan:**

- **`/` vs `~/`** : Dart secara eksplisit membedakan pembagian yang menghasilkan desimal (`/`) dengan pembagian integer (`~/`). Ini menghindari kebingungan seperti di JavaScript.
- **`%` (modulo)** : sangat berguna untuk menentukan ganjil/genap (`angka % 2 == 0`)

---

### 4.3 Operator Penugasan (Assignment)

#### Konsep

Operator penugasan digunakan untuk **memberi nilai** ke variabel. Selain operator dasar `=`, ada operator kombinasi yang melakukan operasi sekaligus penugasan.

```dart
int x = 5;

// Operator dasar
x = 10;  // x menjadi 10

// Operator kombinasi (shorthand)
x += 3;   // x = x + 3  -> 13
x -= 2;   // x = x - 2  -> 11
x *= 2;   // x = x * 2  -> 22
x ~/= 3;  // x = x ~/ 3 -> 7
x %= 3;   // x = x % 3  -> 1

// Null-aware assignment (khusus nullable)
String? nama;
nama ??= "Anonim";  // Assign hanya jika null
// Sekarang nama = "Anonim"
nama ??= "Budi";    // Tidak berubah karena sudah tidak null
```

**Mengapa Ada Operator Kombinasi?**

- **Keringkasan**: `x += 3` lebih singkat dari `x = x + 3`
- **Efisiensi**: Dalam beberapa kasus, variabel hanya dievaluasi sekali
- **Readability**: Ekspresi yang umum dan dikenal luas

---

### 4.4 Operator Perbandingan (Relational)

#### Konsep

Operator perbandingan digunakan untuk **membandingkan dua nilai**. Hasilnya selalu berupa boolean (`true` atau `false`). Ini adalah fondasi untuk pengambilan keputusan dalam program.

```dart
int a = 5, b = 10;

print(a == b);   // false (sama dengan)
print(a != b);   // true  (tidak sama dengan)
print(a > b);    // false (lebih besar dari)
print(a < b);    // true  (lebih kecil dari)
print(a >= b);   // false (lebih besar atau sama dengan)
print(a <= b);   // true  (lebih kecil atau sama dengan)
```

**Catatan Penting:**

- `==` untuk **kesetaraan nilai** (bukan `=` yang merupakan assignment)
- Untuk membandingkan objek, Dart menggunakan `identical()` untuk memeriksa apakah dua referensi menunjuk objek yang sama

---

### 4.5 Operator Logika

#### Konsep

Operator logika digunakan untuk **mengkombinasikan ekspresi boolean**. Ini memungkinkan kita membuat kondisi yang kompleks.

```dart
bool isLogin = true;
bool isAdmin = false;

// && (AND): true hanya jika kedua operand true
print(isLogin && isAdmin);  // false

// || (OR): true jika salah satu operand true
print(isLogin || isAdmin);  // true

// ! (NOT): membalik nilai boolean
print(!isLogin);  // false
```

#### Short-Circuit Evaluation

Dart menggunakan **short-circuit evaluation**:

- `&&` : jika operand kiri `false`, operand kanan TIDAK dievaluasi
- `||` : jika operand kiri `true`, operand kanan TIDAK dievaluasi

```dart
// Contoh short-circuit
bool isLoggedIn = false;
bool hasPermission = isLoggedIn && _checkExpensivePermission();
// _checkExpensivePermission() TIDAK dipanggil karena isLoggedIn sudah false
```

Ini berguna untuk:

- **Optimasi performa**
- **Menghindari error** (misalnya cek null dulu sebelum akses property)

---

### 4.6 Operator Increment/Decrement

#### Konsep

Operator ini digunakan untuk **menambah atau mengurangi nilai variabel sebesar 1**. Ada dua bentuk dengan perbedaan perilaku:

```dart
int count = 0;

// Post-increment (count++)
// Urutan: ambil nilai dulu, baru tambah
print(count++);  // Output: 0, setelah ini count = 1
print(count);    // Output: 1

// Pre-increment (++count)
// Urutan: tambah dulu, baru ambil nilai
print(++count);  // count jadi 2, output: 2
```

**Perbedaan Penting:**

- **Post** (`x++`): nilai LAMA digunakan dulu, baru diubah
- **Pre** (`++x`): nilai diubah dulu, baru digunakan

**Kapan Menggunakan?**

- Dalam loop: `for (int i = 0; i < 10; i++)` (post-increment)
- Saat perlu nilai setelah/tambah dalam satu ekspresi

---

### 4.7 Operator Ternary dan Cascade

#### Ternary Operator (`? :`)

Operator ternary adalah **shorthand untuk if-else sederhana**. Ini adalah satu-satunya operator dengan tiga operand.

```dart
// Sintaks: kondisi ? nilai_jika_true : nilai_jika_false
int nilai = 75;
String status = nilai >= 70 ? "Lulus" : "Tidak Lulus";

// Contoh bersarang (tidak disarankan karena sulit dibaca)
String grade = nilai >= 90 ? "A" :
               nilai >= 80 ? "B" :
               nilai >= 70 ? "C" : "D";
```

#### Cascade Notation (`..`)

Cascade notation memungkinkan kita **melakukan beberapa operasi pada objek yang sama** tanpa harus menulis ulang referensi objek.

```dart
class User {
  String name = "";
  int age = 0;

  void printInfo() => print("$name, $age tahun");
}

// Tanpa cascade
var user1 = User();
user1.name = "Budi";
user1.age = 25;
user1.printInfo();

// Dengan cascade
var user2 = User()
  ..name = "Budi"
  ..age = 25
  ..printInfo();
```

**Penjelasan Cascade:**

- `..` mengembalikan objek yang sama, bukan hasil operasi
- Sangat berguna untuk inisialisasi objek yang berantai
- Juga ada `?..` untuk cascade yang aman terhadap null

---

## BAB 5: PERCABANGAN (CONTROL FLOW)

### 5.1 Konsep Dasar Percabangan

#### Mengapa Program Perlu Bercabang?

Program komputer tidak selalu berjalan linear dari atas ke bawah. Kita perlu **membuat keputusan** berdasarkan kondisi tertentu. Percabangan memungkinkan program:

- **Merespons input** pengguna
- **Menangani error**
- **Menjalankan logika bisnis** yang berbeda berdasarkan keadaan

---

### 5.2 If-Else: Percabangan Dasar

#### Konsep

`if-else` adalah bentuk percabangan paling dasar. Program akan mengevaluasi kondisi (boolean) dan memutuskan blok mana yang dijalankan.

```dart
int nilai = 85;

// if sederhana: hanya jika kondisi true
if (nilai >= 75) {
  print("Lulus");  // Akan dijalankan karena 85 >= 75
}

// if-else: dua arah
if (nilai >= 75) {
  print("Lulus");
} else {
  print("Tidak Lulus");  // Hanya jika kondisi false
}

// if-else if: banyak arah
if (nilai >= 90) {
  print("A");  // Range: 90-100
} else if (nilai >= 80) {
  print("B");  // Range: 80-89
} else if (nilai >= 70) {
  print("C");  // Range: 70-79
} else {
  print("D");  // Range: <70
}
```

#### Prinsip Evaluasi

1. Kondisi dievaluasi **berurutan dari atas**
2. Blok **pertama yang kondisinya true** yang dijalankan
3. Setelah itu, keluar dari struktur if-else (tidak melanjutkan ke kondisi berikutnya)

---

### 5.3 Switch-Case: Percabangan Berbasis Nilai

#### Konsep

`switch-case` adalah alternatif untuk `if-else if` ketika kondisi didasarkan pada **kesetaraan nilai** (bukan range). Switch lebih efisien dan lebih mudah dibaca untuk banyak cabang.

```dart
String hari = "Senin";

switch (hari) {
  case "Senin":
    print("Hari kerja");
    break;  // break penting untuk keluar dari switch

  case "Selasa":
  case "Rabu":
  case "Kamis":
  case "Jumat":
    print("Hari kerja");  // Beberapa case bisa share blok yang sama
    break;

  case "Sabtu":
  case "Minggu":
    print("Hari libur");
    break;

  default:  // Jika tidak ada case yang cocok
    print("Hari tidak valid");
}
```

#### Pentingnya `break`

Tanpa `break`, eksekusi akan **fall through** (lanjut ke case berikutnya). Ini bisa disengaja untuk beberapa case yang membutuhkan logika yang sama.

#### Switch Expression (Dart 3.0+)

Dart 3.0 memperkenalkan switch sebagai **expression** (mengembalikan nilai):

```dart
// Switch sebagai expression
String status = switch (nilai) {
  >= 90 => "A",
  >= 80 => "B",
  >= 70 => "C",
  _ => "D"  // underscore = default
};
```

---

### 5.4 Pattern Matching (Dart 3.0+)

#### Konsep

Pattern matching adalah fitur modern yang memungkinkan **destructuring** dan **pencocokan struktur data**. Ini lebih powerful daripada switch tradisional.

```dart
// Destructuring record
var (x, y) = (10, 20);
print("x = $x, y = $y");

// Pattern matching dengan tipe
void processValue(Object value) {
  switch (value) {
    case String s when s.length > 5:  // dengan guard condition
      print("String panjang: $s");
    case int i:
      print("Integer: $i");
    case List<int> list:
      print("List of ints: $list");
    case _:
      print("Tipe lain");
  }
}
```

**Manfaat Pattern Matching:**

- Kode lebih ekspresif
- Menangani struktur data kompleks dengan elegan
- Type-safe dan exhaustive (compiler memastikan semua kemungkinan tertangani)

---

## BAB 6: PERULANGAN (LOOP)

### 6.1 Konsep Dasar Perulangan

#### Mengapa Program Perlu Mengulang?

Perulangan memungkinkan program menjalankan blok kode **berulang kali** tanpa menulis ulang. Ini penting untuk:

- Memproses **koleksi data** (list, map)
- Menunggu **kondisi tertentu**
- **Menghemat penulisan kode** (DRY - Don't Repeat Yourself)

#### Komponen Perulangan

Semua perulangan memiliki tiga komponen utama:

1. **Inisialisasi** → nilai awal
2. **Kondisi** → kapan berhenti
3. **Iterasi** → perubahan setelah setiap pengulangan

---

### 6.2 For Loop: Perulangan dengan Hitungan

#### Konsep

`for` loop adalah perulangan yang **paling umum digunakan** ketika kita tahu berapa kali ingin mengulang.

```dart
// Struktur: for (inisialisasi; kondisi; iterasi)
for (int i = 1; i <= 5; i++) {
  print("Iterasi ke-$i");
}
```

#### Penjelasan Alur Eksekusi

1. **Inisialisasi** `int i = 1` → dijalankan sekali di awal
2. **Cek kondisi** `i <= 5` → jika true lanjut, jika false berhenti
3. **Jalankan body** `print(...)`
4. **Iterasi** `i++` → tambah nilai i
5. Kembali ke langkah 2

#### Break dan Continue

```dart
// break: menghentikan perulangan sepenuhnya
for (int i = 1; i <= 10; i++) {
  if (i == 5) break;  // Berhenti saat i=5
  print(i);  // Output: 1,2,3,4
}

// continue: melompati iterasi saat ini
for (int i = 1; i <= 5; i++) {
  if (i == 3) continue;  // Lompati i=3
  print(i);  // Output: 1,2,4,5
}
```

---

### 6.3 While dan Do-While: Perulangan Berbasis Kondisi

#### Konsep

`while` dan `do-while` digunakan ketika kita **tidak tahu pasti** berapa kali perulangan terjadi, dan berhenti berdasarkan kondisi.

```dart
// while: cek kondisi DULU, baru jalan
int i = 1;
while (i <= 5) {
  print(i);
  i++;
}

// do-while: jalan DULU minimal sekali, baru cek kondisi
int j = 1;
do {
  print(j);
  j++;
} while (j <= 5);
```

#### Perbedaan Utama

| Aspek                  | while                              | do-while                        |
| ---------------------- | ---------------------------------- | ------------------------------- |
| **Pengecekan kondisi** | Sebelum eksekusi                   | Setelah eksekusi                |
| **Minimal eksekusi**   | 0 kali                             | 1 kali                          |
| **Kapan digunakan**    | Kemungkinan tidak perlu dijalankan | Harus dijalankan minimal sekali |

#### Contoh Kasus

```dart
// while: validasi input (mungkin tidak perlu input jika sudah valid)
String? input;
while (input == null || input.isEmpty) {
  print("Masukkan nama: ");
  input = stdin.readLineSync();
}

// do-while: menu (minimal tampil sekali)
int pilihan;
do {
  print("1. Tambah");
  print("2. Hapus");
  print("3. Keluar");
  pilihan = int.parse(stdin.readLineSync()!);
  // proses pilihan
} while (pilihan != 3);
```

---

### 6.4 For-In: Iterasi Koleksi

#### Konsep

`for-in` adalah **cara paling bersih** untuk mengiterasi elemen dalam koleksi (List, Set, Map). Ini menghilangkan kebutuhan untuk mengelola index secara manual.

```dart
List<String> buah = ["Apel", "Mangga", "Jeruk"];

// For-in sederhana
for (var item in buah) {
  print(item);
}

// Dengan index (jika perlu)
for (var i = 0; i < buah.length; i++) {
  print("${i+1}. ${buah[i]}");
}

// Dengan forEach (style functional)
buah.forEach((item) => print(item));
```

#### Manfaat For-in

- **Lebih aman**: tidak ada risiko index out of bounds
- **Lebih bersih**: tidak perlu variabel counter
- **Lebih ekspresif**: fokus pada data, bukan mekanisme iterasi

---

### 6.5 Labeled Loop: Kontrol Perulangan Bertingkat

#### Konsep

Saat memiliki perulangan bersarang (nested loop), `break` dan `continue` hanya mempengaruhi perulangan **terdalam**. Label memungkinkan kita mengontrol perulangan **luar**.

```dart
// Tanpa label: break hanya keluar dari inner loop
for (int i = 1; i <= 3; i++) {
  for (int j = 1; j <= 3; j++) {
    if (i == 2 && j == 2) {
      break;  // Hanya keluar dari loop j, loop i tetap lanjut
    }
    print("$i, $j");
  }
}
// Output tetap mencetak (2,3) dst

// Dengan label: bisa keluar dari outer loop
outerLoop:
for (int i = 1; i <= 3; i++) {
  for (int j = 1; j <= 3; j++) {
    if (i == 2 && j == 2) {
      break outerLoop;  // Keluar dari loop yang diberi label
    }
    print("$i, $j");
  }
}
// Output berhenti di (2,1)
```

**Kapan Menggunakan?**

- Matriks traversal dengan kondisi berhenti
- Pencarian data dalam struktur bertingkat
- Optimasi dengan early exit

---

## BAB 7: FUNCTION

### 7.1 Konsep Dasar Function

#### Apa Itu Function?

Function adalah **blok kode yang diberi nama** dan dapat **dipanggil berulang kali**. Function adalah fondasi **modularitas** dalam pemrograman.

#### Mengapa Kita Perlu Function?

1. **Reusability**: tulis sekali, gunakan berkali-kali
2. **Modularitas**: pecah program besar menjadi bagian kecil
3. **Abstraksi**: sembunyikan kompleksitas
4. **Testing**: uji bagian program secara terpisah
5. **Maintainability**: perbaiki di satu tempat, berdampak di seluruh program

#### Anatomi Function

```dart
// [returnType] namaFunction([parameter]) { body }
int tambah(int a, int b) {  // return type: int
  return a + b;              // mengembalikan nilai
}

void sapa(String nama) {     // return type: void (tidak mengembalikan)
  print("Halo $nama");
}
```

---

### 7.2 Parameter dan Argument

#### Konsep: Parameter vs Argument

- **Parameter**: variabel yang didefinisikan dalam function (placeholder)
- **Argument**: nilai konkret yang diberikan saat memanggil function

#### Jenis Parameter di Dart

```dart
// 1. Positional Parameters (default)
// Urutan parameter harus sesuai saat pemanggilan
void register(String name, int age) {
  print("$name, $age tahun");
}
register("Budi", 25);  // Urutan harus name, age

// 2. Optional Positional Parameters ([ ])
// Parameter yang boleh tidak disertakan
void greet(String name, [String? greeting]) {
  print("${greeting ?? 'Halo'}, $name");
}
greet("Budi");              // "Halo, Budi"
greet("Budi", "Hi");        // "Hi, Budi"

// 3. Named Parameters ({ })
// Parameter dipanggil dengan nama, urutan bebas
void createUser({required String name, int age = 0}) {
  print("$name, $age tahun");
}
createUser(name: "Budi", age: 25);  // Jelas dan aman
createUser(name: "Ani");            // age default 0

// 4. Required vs Optional
// required: wajib diisi
// tanpa required: optional, bisa punya default value
```

#### Mengapa Named Parameters Berguna?

- **Dokumentasi implisit**: nama parameter menjelaskan makna
- **Fleksibilitas urutan**: tidak perlu mengingat urutan
- **Default value**: mudah memberikan nilai bawaan
- **API yang stabil**: menambah parameter baru tanpa merusak kode lama

---

### 7.3 Return Value

#### Konsep

Function dapat **mengembalikan nilai** menggunakan keyword `return`. Tipe kembalian harus sesuai dengan deklarasi return type.

```dart
// Mengembalikan nilai
int kali(int a, int b) {
  return a * b;
}
int hasil = kali(5, 3);  // hasil = 15

// Function dengan return type tapi tidak return (error)
// int salah() { }  // ERROR: missing return

// void: tidak mengembalikan nilai
void printMessage(String msg) {
  print(msg);
  // Tidak ada return, atau bisa return; (untuk keluar lebih awal)
}

// Return lebih awal
String cekNilai(int nilai) {
  if (nilai < 0) {
    return "Nilai tidak valid";  // Keluar lebih awal
  }
  // Logika lain
  return "Nilai valid";
}
```

---

### 7.4 Arrow Function (Fat Arrow)

#### Konsep

Arrow function adalah **sintaks singkat** untuk function yang hanya memiliki **satu ekspresi**. Hasil ekspresi langsung menjadi nilai return.

```dart
// Function biasa
int tambah(int a, int b) {
  return a + b;
}

// Arrow function (setara)
int tambah(int a, int b) => a + b;

// Untuk void function
void sapa(String nama) => print("Halo $nama");

// Dalam collection operations
var genap = [1,2,3,4,5].where((n) => n % 2 == 0).toList();
```

**Kapan Menggunakan Arrow Function?**

- **Ya**: untuk function sederhana satu baris
- **Tidak**: jika ada logika kompleks, multiple statements

---

### 7.5 Anonymous Function (Lambda)

#### Konsep

Anonymous function adalah function **tanpa nama**. Ini berguna untuk:

- **Callback** yang hanya digunakan sekali
- **Operasi pada collection** (map, where, forEach)
- **Closure** yang membutuhkan function

```dart
// Anonymous function sebagai parameter
List<int> angka = [1, 2, 3, 4, 5];

// Menggunakan anonymous function
angka.forEach((item) {
  print(item * 2);
});

// Dengan arrow (lebih ringkas)
angka.forEach((item) => print(item * 2));

// Assign ke variabel
var kuadrat = (int x) => x * x;
print(kuadrat(5));  // 25
```

---

### 7.6 Closure

#### Konsep

Closure adalah function yang **dapat mengakses variabel dari scope di mana ia dibuat**, bahkan setelah scope tersebut selesai dieksekusi.

```dart
// Function yang mengembalikan function (closure)
Function makeCounter() {
  int count = 0;  // Variabel lokal

  // Function ini "menutup" (close over) variabel count
  return () {
    count++;  // Masih bisa mengakses count
    return count;
  };
}

void main() {
  var counter = makeCounter();
  print(counter());  // 1
  print(counter());  // 2
  print(counter());  // 3
  // Variabel count tetap hidup meskipun makeCounter() sudah selesai
}
```

#### Mengapa Closure Penting?

- **State encapsulation**: menyimpan state tanpa global variable
- **Factory functions**: membuat function dengan "ingatan"
- **Callbacks dengan data**: setiap callback bisa punya data sendiri

---

### 7.7 Higher-Order Function

#### Konsep

Higher-order function adalah function yang:

1. **Menerima function sebagai parameter**, atau
2. **Mengembalikan function**

Ini adalah konsep inti **functional programming**.

```dart
// Function sebagai parameter
void processNumbers(List<int> numbers, int Function(int) processor) {
  for (var n in numbers) {
    print(processor(n));
  }
}

// Penggunaan
processNumbers([1,2,3], (n) => n * n);  // 1,4,9
processNumbers([1,2,3], (n) => n + 10); // 11,12,13

// Function yang mengembalikan function
Function(String) createGreeting(String greeting) {
  return (String name) => "$greeting, $name!";
}

var sayHello = createGreeting("Halo");
print(sayHello("Budi"));  // "Halo, Budi!"

var sayHi = createGreeting("Hi");
print(sayHi("Ani"));  // "Hi, Ani!"
```

#### Higher-Order Function Bawaan Dart

```dart
List<int> numbers = [1, 2, 3, 4, 5];

// map: transformasi setiap elemen
var kuadrat = numbers.map((n) => n * n).toList();  // [1,4,9,16,25]

// where: filter berdasarkan kondisi
var genap = numbers.where((n) => n % 2 == 0).toList();  // [2,4]

// reduce: agregasi nilai
var jumlah = numbers.reduce((a, b) => a + b);  // 15

// fold: agregasi dengan nilai awal
var total = numbers.fold(0, (sum, n) => sum + n);  // 15
```

---

## BAB 8: KOLEKSI DATA

### 8.1 Konsep Dasar Koleksi

#### Apa Itu Koleksi?

Koleksi adalah struktur data yang **menyimpan sekumpulan objek**. Dart menyediakan tiga jenis koleksi utama:

1. **List** → kumpulan berurutan, bisa duplikat
2. **Set** → kumpulan unik, tidak berurutan
3. **Map** → pasangan key-value

#### Mengapa Perlu Koleksi?

Tanpa koleksi, kita harus membuat variabel terpisah untuk setiap data:

```dart
// Tanpa koleksi (tidak scalable)
String nama1 = "Budi";
String nama2 = "Ani";
String nama3 = "Joko";
// ... bagaimana jika 1000 data?

// Dengan koleksi (scalable)
List<String> nama = ["Budi", "Ani", "Joko"];
```

---

### 8.2 List (Array)

#### Konsep

List adalah **koleksi berurutan** dengan **index** mulai dari 0. Setiap elemen dapat diakses melalui posisinya. List bisa menyimpan duplikat.

#### Membuat dan Menggunakan List

```dart
// Cara membuat List
List<int> angka = [1, 2, 3, 4, 5];
var buah = ["Apel", "Mangga", "Jeruk"];  // type inference
List<dynamic> campuran = [1, "dua", true];  // campuran tipe

// List kosong
var kosong = <int>[];  // list int kosong
var dinamis = [];      // list dynamic (bisa diisi apa saja)

// List fixed-length (panjang tetap)
var fixed = List<int>.filled(3, 0);  // [0,0,0]
fixed[0] = 10;  // bisa ubah nilai
// fixed.add(4);  // ERROR! tidak bisa tambah elemen
```

#### Operasi pada List

```dart
var list = [1, 2, 3];

// Menambah
list.add(4);           // [1,2,3,4]
list.addAll([5, 6]);   // [1,2,3,4,5,6]
list.insert(0, 0);     // [0,1,2,3,4,5,6]
list.insertAll(2, [10, 11]);  // [0,1,10,11,2,3,4,5,6]

// Menghapus
list.remove(10);       // hapus nilai 10
list.removeAt(0);      // hapus index 0
list.removeLast();     // hapus elemen terakhir
list.removeRange(1, 3); // hapus index 1 sampai 2
list.clear();          // kosongkan semua

// Mengakses
print(list[0]);        // akses index
print(list.length);    // jumlah elemen
print(list.contains(5)); // cek keberadaan
print(list.indexOf(3));  // cari index nilai 3

// Mengubah
list[0] = 100;         // ubah nilai di index
```

#### Spread Operator (`...`)

Spread operator **memasukkan elemen dari list lain** ke dalam list baru.

```dart
var list1 = [1, 2];
var list2 = [0, ...list1, 3];  // [0,1,2,3]

// Null-aware spread
List<int>? maybeNull;
var list3 = [0, ...?maybeNull, 1];  // [0,1] (aman)
```

#### Collection If dan For

Fitur untuk **membuat list secara dinamis**.

```dart
bool showExtra = true;

var list = [
  1,
  2,
  if (showExtra) 3,  // Conditional: hanya ditambahkan jika true
  for (var i = 4; i <= 6; i++) i,  // For loop: menambahkan 4,5,6
];  // [1,2,3,4,5,6]
```

---

### 8.3 Set

#### Konsep

Set adalah koleksi yang **menyimpan nilai unik** (tanpa duplikat). Set tidak memiliki urutan dan tidak bisa diakses dengan index.

#### Kapan Menggunakan Set?

- **Menghilangkan duplikat** dari list
- **Operasi himpunan** (union, intersection, difference)
- **Pengecekan keanggotaan** yang cepat (O(1))

```dart
// Membuat Set
Set<int> angkaUnik = {1, 2, 3, 3, 3};  // {1,2,3} (duplikat diabaikan)
var buahSet = {"Apel", "Mangga", "Jeruk"};

// Set kosong
var kosong = <int>{};  // set kosong dengan tipe int
var dinamis = {};      // HATI-HATI: ini Map, bukan Set!

// Operasi Set
var set1 = {1, 2, 3};
var set2 = {3, 4, 5};

set1.add(4);           // {1,2,3,4}
set1.addAll([5, 6]);   // {1,2,3,4,5,6}
set1.remove(3);        // {1,2,4,5,6}

// Operasi himpunan
print(set1.union(set2));        // {1,2,4,5,6,3}
print(set1.intersection(set2)); // {4,5}
print(set1.difference(set2));   // {1,2,6}
print(set1.contains(4));        // true
```

---

### 8.4 Map

#### Konsep

Map adalah koleksi **key-value pair**. Setiap key bersifat unik dan digunakan untuk mengakses value-nya. Map sangat berguna untuk:

- **Data terstruktur** seperti record database
- **Cache/lookup table**
- **Konfigurasi** dengan nama parameter

#### Membuat dan Menggunakan Map

```dart
// Cara membuat Map
Map<String, int> umur = {
  "Budi": 25,
  "Ani": 23,
  "Joko": 30,
};

// Type inference
var data = {
  "nama": "Budi",
  "umur": 25,
};

// Map kosong
var kosong = <String, int>{};

// Operasi Map
print(umur["Budi"]);           // 25 (akses)
print(umur["TidakAda"]);       // null

umur["Cici"] = 28;              // tambah/ubah
umur["Budi"] = 26;              // ubah nilai

umur.remove("Joko");            // hapus

print(umur.keys);               // (Budi, Ani, Cici)
print(umur.values);             // (26, 23, 28)
print(umur.length);             // 3
print(umur.containsKey("Budi")); // true

// Iterasi Map
umur.forEach((nama, usia) {
  print("$nama berusia $usia tahun");
});

for (var entry in umur.entries) {
  print("${entry.key}: ${entry.value}");
}
```

#### Map Comprehension

Dart mendukung pembuatan map dengan **collection for**:

```dart
// Map dari list
var names = ["Budi", "Ani", "Joko"];
var nameMap = {for (var name in names) name: name.length};
// {"Budi":4, "Ani":3, "Joko":4}

// Map dengan range
var kuadrat = {for (var i = 1; i <= 5; i++) i: i * i};
// {1:1, 2:4, 3:9, 4:16, 5:25}
```

---

### 8.5 Queue

#### Konsep

Queue adalah koleksi dengan prinsip **FIFO** (First In, First Out). Elemen ditambahkan di akhir dan diambil dari awal. Berguna untuk:

- **Antrian** pemrosesan
- **BFS** (Breadth-First Search)
- **Buffer** data

```dart
import 'dart:collection';

Queue<int> antrian = Queue();

// Menambah
antrian.add(1);        // tambah di belakang
antrian.add(2);
antrian.addFirst(0);   // tambah di depan
antrian.addLast(3);    // tambah di belakang

// Mengambil
print(antrian.removeFirst());  // 0
print(antrian.removeLast());   // 3
print(antrian.first);          // 1 (lihat tanpa hapus)
print(antrian.last);           // 2
```

---
