# BAB 9: OBJECT-ORIENTED PROGRAMMING

## 9.1 Konsep Dasar OOP

### Apa Itu OOP?

Object-Oriented Programming adalah **paradigma pemrograman** yang memodelkan dunia nyata sebagai **objek** yang memiliki:

- **State** (data/properti) → apa yang dimiliki objek
- **Behavior** (method/fungsi) → apa yang bisa dilakukan objek

### Mengapa OOP Penting?

1. **Abstraksi** → menyembunyikan kompleksitas
2. **Enkapsulasi** → melindungi data dari akses tidak sah
3. **Inheritance** → menggunakan ulang kode
4. **Polymorphism** → fleksibilitas dalam menggunakan objek

---

## 9.2 Class dan Object

### Konsep

- **Class** adalah blueprint (cetakan) untuk membuat objek
- **Object** adalah instance (hasil cetakan) dari class

```dart
class Mahasiswa {
  // Properties (state)
  String nama;
  int nim;
  String? jurusan;  // nullable, optional

  // Constructor (cara membuat objek)
  Mahasiswa(this.nama, this.nim, [this.jurusan]);

  // Named constructor (alternatif cara membuat)
  Mahasiswa.fromMap(Map<String, dynamic> map)
      : nama = map['nama'],
        nim = map['nim'],
        jurusan = map['jurusan'];

  // Method (behavior)
  void perkenalan() {
    print("Halo, saya $nama ($nim)");
  }

  // Getter (mengakses seperti properti)
  String get info => "$nama - $nim";

  // Setter (mengubah seperti properti)
  set ubahNama(String namaBaru) => nama = namaBaru;
}

// Membuat objek
var mhs1 = Mahasiswa("Budi", 12345, "Informatika");
var mhs2 = Mahasiswa.fromMap({
  'nama': 'Ani',
  'nim': 12346,
  'jurusan': 'Sistem Informasi'
});

// Menggunakan objek
mhs1.perkenalan();
print(mhs1.info);     // getter
mhs1.ubahNama = "Budi Santoso";  // setter
```

### Constructor Detail

```dart
class Person {
  String name;
  int age;

  // Constructor dengan initialization list
  Person(this.name, this.age) {
    // Body constructor
    print("Person created: $name");
  }

  // Constructor redirect
  Person.guest() : this("Guest", 0);

  // Factory constructor (dapat mengembalikan objek yang sudah ada)
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(json['name'], json['age']);
  }
}
```

---

## 9.3 Inheritance (Pewarisan)

### Konsep

Inheritance memungkinkan class **mewarisi** properti dan method dari class lain. Ini menciptakan hubungan **"is-a"** (adalah).

```dart
// Parent class (superclass)
class Animal {
  String name;

  Animal(this.name);

  void makeSound() {
    print("$name makes a sound");
  }

  void move() {
    print("$name moves");
  }
}

// Child class (subclass)
class Dog extends Animal {
  String breed;

  // Constructor harus memanggil super
  Dog(String name, this.breed) : super(name);

  // Override method
  @override
  void makeSound() {
    print("$name barks: Woof!");
  }

  // Method tambahan
  void wagTail() {
    print("$name wags tail");
  }
}

// Penggunaan
var dog = Dog("Rex", "German Shepherd");
dog.makeSound();  // Rex barks: Woof!
dog.move();       // Rex moves (inherited)
dog.wagTail();    // Rex wags tail
```

### Mengapa Inheritance?

- **Reusability**: kode di superclass digunakan di semua subclass
- **Extensibility**: bisa menambah fitur tanpa mengubah kode yang sudah ada
- **Polymorphism**: objek berbeda bisa diperlakukan sebagai tipe yang sama

---

## 9.4 Abstract Class

### Konsep

Abstract class adalah class yang **tidak bisa diinstansiasi** langsung. Fungsinya sebagai **kerangka** yang mendefinisikan apa yang harus dilakukan, tapi tidak bagaimana melakukannya.

```dart
// Abstract class
abstract class Shape {
  // Abstract method (tanpa implementasi)
  double area();

  // Concrete method (dengan implementasi)
  void printArea() {
    print("Area: ${area()}");
  }
}

// Concrete class harus implement semua abstract method
class Circle extends Shape {
  double radius;

  Circle(this.radius);

  @override
  double area() => 3.14 * radius * radius;
}

class Rectangle extends Shape {
  double width, height;

  Rectangle(this.width, this.height);

  @override
  double area() => width * height;
}

// Tidak bisa: var shape = Shape();  // ERROR!
// Tapi bisa sebagai tipe referensi
Shape circle = Circle(5);
circle.printArea();  // Area: 78.5
```

### Kapan Menggunakan Abstract Class?

- Mendefinisikan **kontrak** untuk subclass
- Menyediakan **implementasi umum** yang bisa digunakan bersama
- Mencegah instansiasi class yang tidak lengkap

---

## 9.5 Interface (Implicit Interface)

### Konsep

Setiap class di Dart secara otomatis mendefinisikan **implicit interface**. Class lain bisa **mengimplementasikan** interface tersebut (bukan mewarisi).

```dart
// Interface (didefinisikan oleh class)
class Flyable {
  void fly() {
    print("Flying");
  }

  void land() {
    print("Landing");
  }
}

// Class mengimplementasikan interface
class Bird implements Flyable {
  // Harus mengimplementasikan SEMUA method dari interface
  @override
  void fly() {
    print("Bird flaps wings and flies");
  }

  @override
  void land() {
    print("Bird lands on branch");
  }
}

// Multiple interfaces
class Airplane implements Flyable, Vehicle {
  // Harus implement semua method dari semua interface
  @override
  void fly() => print("Airplane takes off");

  @override
  void land() => print("Airplane lands on runway");

  @override
  void start() => print("Engine starts");
}
```

### Interface vs Abstract Class

| Aspek            | Interface                         | Abstract Class                            |
| ---------------- | --------------------------------- | ----------------------------------------- |
| **Tujuan**       | Mendefinisikan kontrak            | Menyediakan kerangka + implementasi dasar |
| **Multiple**     | Bisa implement banyak             | Hanya extends satu                        |
| **State**        | Tidak bisa punya state (properti) | Bisa punya state                          |
| **Implementasi** | Harus implement semua             | Bisa override sebagian                    |

---

## 9.6 Mixin

### Konsep

Mixin adalah cara **menggunakan ulang kode** dari beberapa class tanpa inheritance (yang single inheritance). Mixin seperti **"potongan kode"** yang bisa ditambahkan ke class.

```dart
// Mixin (tanpa constructor)
mixin Logger {
  void log(String message) {
    var now = DateTime.now();
    print("[${now.hour}:${now.minute}] $message");
  }
}

mixin Validator {
  bool isValidEmail(String email) {
    return email.contains('@') && email.contains('.');
  }

  bool isValidPhone(String phone) {
    return phone.length >= 10;
  }
}

// Menggunakan mixin dengan 'with'
class UserService with Logger, Validator {
  void register(String email, String phone) {
    if (isValidEmail(email) && isValidPhone(phone)) {
      log("User registered: $email");
    } else {
      log("Invalid registration data");
    }
  }
}

// Mixin bisa membatasi class yang bisa menggunakannya
mixin Timestamp on DatabaseModel {
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
}

class DatabaseModel {
  int id = 0;
}

class User extends DatabaseModel with Timestamp {
  String name;
  User(this.name);
}
```

### Kapan Menggunakan Mixin?

- **Cross-cutting concerns**: logging, validation, serialization
- **Code reuse** ketika inheritance tidak tepat (multiple inheritance tidak didukung)
- **Composition over inheritance**: membangun class dengan menggabungkan fitur

---

## 9.7 Generic

### Konsep

Generic memungkinkan class, function, atau interface untuk **bekerja dengan berbagai tipe data** tanpa harus menulis ulang kode.

### Mengapa Generic Penting?

1. **Type Safety**: kesalahan tipe terdeteksi saat compile
2. **Code Reusability**: satu class bisa digunakan untuk banyak tipe
3. **No Casting**: tidak perlu konversi tipe manual

```dart
// Class generic
class Box<T> {
  T value;

  Box(this.value);

  T getValue() => value;

  void setValue(T newValue) {
    value = newValue;
  }
}

// Penggunaan dengan berbagai tipe
Box<int> intBox = Box(123);
Box<String> stringBox = Box("Hello");
Box<List<int>> listBox = Box([1, 2, 3]);

print(intBox.getValue());     // 123
print(stringBox.getValue());  // Hello
print(listBox.getValue());    // [1,2,3]

// Generic function
T first<T>(List<T> list) {
  return list[0];
}

print(first([1, 2, 3]));      // 1 (int)
print(first(["a", "b"]));     // "a" (String)

// Type constraint (membatasi tipe)
class NumberBox<T extends num> {
  T value;
  NumberBox(this.value);

  T add(T other) => value + other as T;
}

// Bisa: NumberBox<int> atau NumberBox<double>
// Tidak bisa: NumberBox<String>  // ERROR! String bukan num
```

---

## 9.8 Extension Methods

### Konsep

Extension methods memungkinkan kita **menambah method ke class yang sudah ada** tanpa mengubah class aslinya.

```dart
// Extension untuk String
extension StringExtension on String {
  bool get isEmail {
    return contains('@') && contains('.');
  }

  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  int toIntOrZero() {
    return int.tryParse(this) ?? 0;
  }
}

// Penggunaan
String email = "user@example.com";
print(email.isEmail);  // true

String name = "budi";
print(name.capitalize());  // "Budi"

String number = "123abc";
print(number.toIntOrZero());  // 0

// Extension untuk List
extension ListExtension<T> on List<T> {
  T? second() {
    return length >= 2 ? this[1] : null;
  }

  List<T> unique() {
    return toSet().toList();
  }
}

var list = [1, 2, 2, 3];
print(list.second());  // 2
print(list.unique());  // [1,2,3]
```

### Kapan Menggunakan Extension?

- **Menambah fungsionalitas** ke class dari library eksternal
- **Membuat helper** yang lebih natural (method chaining)
- **Organisasi kode** tanpa perlu class helper terpisah

---

## BAB 10: STUDI KASUS

### Aplikasi Manajemen Tugas (To-Do List)

### Konsep Desain

Aplikasi ini mengimplementasikan konsep-konsep yang telah dipelajari:

- **Class & Object**: Task, TaskManager
- **Koleksi**: List untuk menyimpan tasks
- **Method**: operasi CRUD
- **Null Safety**: penanganan input nullable
- **Functional Programming**: forEach, where, map

### Struktur Class

```dart
import 'dart:io';

/// Class Task: merepresentasikan satu tugas
/// Mengimplementasikan konsep encapsulation (properties private)
class Task {
  // Private properties (dengan underscore)
  String _title;
  bool _isCompleted;
  final DateTime _createdAt;

  // Constructor
  Task({
    required String title,
    bool isCompleted = false,
    DateTime? createdAt,
  })  : _title = title,
        _isCompleted = isCompleted,
        _createdAt = createdAt ?? DateTime.now();

  // Getters (public access)
  String get title => _title;
  bool get isCompleted => _isCompleted;
  DateTime get createdAt => _createdAt;

  // Setter dengan validasi
  set title(String newTitle) {
    if (newTitle.trim().isEmpty) {
      throw ArgumentError("Title cannot be empty");
    }
    _title = newTitle;
  }

  // Method untuk mengubah status
  void complete() {
    _isCompleted = true;
  }

  void uncomplete() {
    _isCompleted = false;
  }

  // Factory method untuk konversi dari Map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      isCompleted: map['isCompleted'] ?? false,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : null,
    );
  }

  // Konversi ke Map (untuk penyimpanan)
  Map<String, dynamic> toMap() {
    return {
      'title': _title,
      'isCompleted': _isCompleted,
      'createdAt': _createdAt.toIso8601String(),
    };
  }

  // Override toString untuk representasi yang bagus
  @override
  String toString() {
    String status = _isCompleted ? '✓' : '○';
    String date = "${_createdAt.day}/${_createdAt.month} ${_createdAt.hour.toString().padLeft(2, '0')}:${_createdAt.minute.toString().padLeft(2, '0')}";
    return "[$status] $_title ($date)";
  }
}

/// Class TaskManager: mengelola kumpulan Task
/// Mengimplementasikan konsep composition
class TaskManager {
  // Private list of tasks
  final List<Task> _tasks = [];

  // Read-only getter untuk statistik
  int get totalTasks => _tasks.length;
  int get completedTasks => _tasks.where((t) => t.isCompleted).length;
  int get pendingTasks => totalTasks - completedTasks;

  // CRUD Operations

  /// Menambah task baru
  /// Menggunakan named parameter untuk kejelasan
  void addTask({required String title}) {
    if (title.trim().isEmpty) {
      throw ArgumentError("Task title cannot be empty");
    }

    final task = Task(title: title);
    _tasks.add(task);
    print("✓ Task '$title' berhasil ditambahkan");
  }

  /// Mendapatkan semua tasks (opsional filter)
  List<Task> getTasks({bool? completed}) {
    if (completed == null) {
      return List.unmodifiable(_tasks);  // Return immutable list
    }
    return _tasks.where((t) => t.isCompleted == completed).toList();
  }

  /// Menampilkan tasks ke console
  void displayTasks({bool? completed}) {
    final tasks = getTasks(completed: completed);

    if (tasks.isEmpty) {
      print("\n📭 Tidak ada tugas.\n");
      return;
    }

    print("\n" + "=" * 40);
    print(completed == null ? "📋 SEMUA TUGAS" :
          completed ? "✅ TUGAS SELESAI" : "⏳ TUGAS BELUM SELESAI");
    print("=" * 40);

    for (var i = 0; i < tasks.length; i++) {
      print("${i + 1}. ${tasks[i]}");
    }
    print("=" * 40 + "\n");
  }

  /// Menandai task selesai berdasarkan index
  /// Menggunakan nullable parameter untuk fleksibilitas
  bool completeTask(int index, [bool complete = true]) {
    if (index < 0 || index >= _tasks.length) {
      print("✗ Index tugas tidak valid");
      return false;
    }

    final task = _tasks[index];
    if (complete) {
      task.complete();
      print("✓ Task '${task.title}' ditandai selesai");
    } else {
      task.uncomplete();
      print("✓ Task '${task.title}' ditandai belum selesai");
    }
    return true;
  }

  /// Menghapus task berdasarkan index
  bool deleteTask(int index) {
    if (index < 0 || index >= _tasks.length) {
      print("✗ Index tugas tidak valid");
      return false;
    }

    final removed = _tasks.removeAt(index);
    print("✓ Task '${removed.title}' dihapus");
    return true;
  }

  /// Mencari task berdasarkan keyword
  List<Task> searchTasks(String keyword) {
    if (keyword.isEmpty) return [];

    return _tasks.where((task) =>
      task.title.toLowerCase().contains(keyword.toLowerCase())
    ).toList();
  }

  /// Menampilkan statistik
  void showStats() {
    print("\n" + "=" * 40);
    print("📊 STATISTIK TUGAS");
    print("=" * 40);
    print("Total tugas     : $totalTasks");
    print("Selesai         : $completedTasks (${_calculatePercentage(completedTasks)}%)");
    print("Belum selesai   : $pendingTasks (${_calculatePercentage(pendingTasks)}%)");

    if (totalTasks > 0) {
      print("\n📈 Progress: ${"█" * (completedTasks * 10 ~/ totalTasks)}${"░" * (10 - (completedTasks * 10 ~/ totalTasks))}");
    }
    print("=" * 40 + "\n");
  }

  // Helper private method
  double _calculatePercentage(int count) {
    if (totalTasks == 0) return 0;
    return (count / totalTasks * 100).toStringAsFixed(1);
  }
}

/// Class UI Handler: menangani interaksi dengan pengguna
class TodoApp {
  final TaskManager _manager = TaskManager();

  void run() {
    _printWelcome();

    while (true) {
      stdout.write("\n📝 > ");
      final input = stdin.readLineSync();

      if (input == null) continue;

      if (input.toLowerCase() == 'exit') {
        _printGoodbye();
        break;
      }

      _processCommand(input);
    }
  }

  void _processCommand(String input) {
    final parts = input.split(' ');
    final command = parts[0].toLowerCase();

    try {
      switch (command) {
        case 'help':
          _showHelp();
          break;

        case 'add':
          if (parts.length < 2) {
            print("⚠️ Gunakan: add <judul tugas>");
          } else {
            final title = parts.sublist(1).join(' ');
            _manager.addTask(title: title);
          }
          break;

        case 'list':
          _handleListCommand(parts);
          break;

        case 'done':
          _handleDoneCommand(parts);
          break;

        case 'undone':
          _handleUndoneCommand(parts);
          break;

        case 'delete':
          _handleDeleteCommand(parts);
          break;

        case 'search':
          _handleSearchCommand(parts);
          break;

        case 'stats':
          _manager.showStats();
          break;

        case 'clear':
          _clearScreen();
          break;

        default:
          print("❌ Perintah '$command' tidak dikenal. Ketik 'help' untuk bantuan");
      }
    } catch (e) {
      print("❌ Error: $e");
    }
  }

  void _handleListCommand(List<String> parts) {
    if (parts.length == 1) {
      _manager.displayTasks();
    } else {
      switch (parts[1]) {
        case 'all':
          _manager.displayTasks();
          break;
        case 'done':
          _manager.displayTasks(completed: true);
          break;
        case 'pending':
          _manager.displayTasks(completed: false);
          break;
        default:
          print("⚠️ Filter tidak dikenal. Gunakan: list [all/done/pending]");
      }
    }
  }

  void _handleDoneCommand(List<String> parts) {
    if (parts.length < 2) {
      print("⚠️ Gunakan: done <nomor tugas>");
      return;
    }

    final index = int.tryParse(parts[1]);
    if (index == null) {
      print("⚠️ Nomor tugas harus berupa angka");
      return;
    }

    _manager.completeTask(index - 1, true);
  }

  void _handleUndoneCommand(List<String> parts) {
    if (parts.length < 2) {
      print("⚠️ Gunakan: undone <nomor tugas>");
      return;
    }

    final index = int.tryParse(parts[1]);
    if (index == null) {
      print("⚠️ Nomor tugas harus berupa angka");
      return;
    }

    _manager.completeTask(index - 1, false);
  }

  void _handleDeleteCommand(List<String> parts) {
    if (parts.length < 2) {
      print("⚠️ Gunakan: delete <nomor tugas>");
      return;
    }

    final index = int.tryParse(parts[1]);
    if (index == null) {
      print("⚠️ Nomor tugas harus berupa angka");
      return;
    }

    _manager.deleteTask(index - 1);
  }

  void _handleSearchCommand(List<String> parts) {
    if (parts.length < 2) {
      print("⚠️ Gunakan: search <keyword>");
      return;
    }

    final keyword = parts.sublist(1).join(' ');
    final results = _manager.searchTasks(keyword);

    if (results.isEmpty) {
      print("🔍 Tidak ada tugas dengan kata '$keyword'");
    } else {
      print("\n🔍 HASIL PENCARIAN: '$keyword'");
      for (var i = 0; i < results.length; i++) {
        print("${i + 1}. ${results[i]}");
      }
    }
  }

  void _printWelcome() {
    print("\n" + "=" * 50);
    print("📝  APLIKASI MANAJEMEN TUGAS  📝");
    print("=" * 50);
    print("Ketik 'help' untuk melihat daftar perintah");
    print("Ketik 'exit' untuk keluar");
  }

  void _printGoodbye() {
    print("\n👋 Terima kasih telah menggunakan Aplikasi Manajemen Tugas!");
    print("Sampai jumpa!\n");
  }

  void _showHelp() {
    print("\n" + "=" * 50);
    print("📖 DAFTAR PERINTAH");
    print("=" * 50);
    print("add <judul>     - Menambah tugas baru");
    print("list            - Menampilkan semua tugas");
    print("list all        - Menampilkan semua tugas");
    print("list done       - Menampilkan tugas selesai");
    print("list pending    - Menampilkan tugas belum selesai");
    print("done <no>       - Menandai tugas selesai");
    print("undone <no>     - Menandai tugas belum selesai");
    print("delete <no>     - Menghapus tugas");
    print("search <kata>   - Mencari tugas berdasarkan kata kunci");
    print("stats           - Menampilkan statistik");
    print("clear           - Membersihkan layar");
    print("help            - Menampilkan bantuan ini");
    print("exit            - Keluar aplikasi");
    print("=" * 50);
  }

  void _clearScreen() {
    // ANSI escape code untuk clear screen
    print('\x1B[2J\x1B[0;0H');
    _printWelcome();
  }
}

// Entry point
void main() {
  final app = TodoApp();
  app.run();
}
```

---

## 📌 RANGKUMAN KONSEP KUNCI

### Variabel dan Tipe Data

| Konsep             | Inti Penjelasan                                                           |
| ------------------ | ------------------------------------------------------------------------- |
| **Variabel**       | Tempat menyimpan data di memori                                           |
| **Tipe Data**      | Klasifikasi yang menentukan operasi yang bisa dilakukan                   |
| **Null Safety**    | Memisahkan tipe nullable (`?`) dan non-nullable untuk mencegah error null |
| **final**          | Nilai ditentukan sekali saat runtime                                      |
| **const**          | Nilai konstan yang diketahui saat compile time                            |
| **late**           | Menunda inisialisasi, dijamin akan diisi sebelum digunakan                |
| **type inference** | Dart bisa menebak tipe data dari nilai yang diberikan                     |

### Operator

| Konsep            | Inti Penjelasan                                      |
| ----------------- | ---------------------------------------------------- |
| **Aritmatika**    | Operasi matematika dasar (+,-,\*,/,%,~/)             |
| **Perbandingan**  | Membandingkan nilai, hasil boolean (==,!=,<,>,<=,>=) |
| **Logika**        | Mengkombinasikan boolean (&&, \|\|, !)               |
| **Short-circuit** | Evaluasi berhenti jika hasil sudah pasti             |
| **Cascade (..)**  | Melakukan multiple operasi pada objek yang sama      |

### Struktur Kontrol

| Konsep          | Inti Penjelasan                                   |
| --------------- | ------------------------------------------------- |
| **if-else**     | Percabangan berdasarkan kondisi boolean           |
| **switch-case** | Percabangan berdasarkan nilai pasti (bukan range) |
| **for**         | Perulangan dengan hitungan pasti                  |
| **while**       | Perulangan dengan kondisi di awal                 |
| **do-while**    | Perulangan minimal sekali, kondisi di akhir       |
| **break**       | Menghentikan perulangan                           |
| **continue**    | Melompati iterasi saat ini                        |

### Function

| Konsep             | Inti Penjelasan                                      |
| ------------------ | ---------------------------------------------------- |
| **Parameter**      | Input yang diterima function                         |
| **Return value**   | Output yang dihasilkan function                      |
| **Positional**     | Parameter berdasarkan urutan                         |
| **Named**          | Parameter dengan nama, urutan bebas                  |
| **Arrow function** | Sintaks singkat untuk function satu ekspresi         |
| **Closure**        | Function yang mengingat lingkungan di mana ia dibuat |
| **Higher-order**   | Function yang menerima/mengembalikan function        |

### OOP

| Konsep          | Inti Penjelasan                                       |
| --------------- | ----------------------------------------------------- |
| **Class**       | Blueprint untuk membuat objek                         |
| **Object**      | Instance dari class                                   |
| **Inheritance** | Pewarisan properti/method dari parent class           |
| **Abstract**    | Class yang tidak bisa diinstansiasi, sebagai kerangka |
| **Interface**   | Kontrak yang harus diimplementasikan                  |
| **Mixin**       | Potongan kode yang bisa ditambahkan ke class          |
| **Generic**     | Parameter tipe untuk kode yang reusable               |

---

## PENUTUP

### Apa yang Sudah Dipelajari?

1. **Dasar-dasar Dart**: variabel, tipe data, operator
2. **Null Safety**: fitur penting untuk keamanan kode
3. **Struktur kontrol**: percabangan dan perulangan
4. **Function**: dari dasar hingga higher-order function
5. **Koleksi**: List, Set, Map, dan operasinya
6. **OOP**: class, inheritance, interface, mixin, generic
7. **Aplikasi Praktis**: implementasi dalam aplikasi nyata

### Langkah Selanjutnya

- **Flutter Framework**: Bangun UI dengan Flutter
- **Asynchronous Programming**: Future, Stream, async/await
- **Package Management**: Gunakan package dari pub.dev
- **Testing**: Unit test, widget test
- **State Management**: Provider, BLoC, Riverpod

### Sumber Belajar

- [Dart.dev Official Documentation](https://dart.dev/guides)
- [DartPad](https://dartpad.dev) - Online playground
- [Effective Dart](https://dart.dev/guides/language/effective-dart) - Best practices
- [Flutter Documentation](https://flutter.dev/docs)

---
