# Implementasi Provider di flutter

## 1. Teori & Konsep Provider

### Mengapa Perlu State Management?
Pada praktikum sebelumnya, Anda membuat **SQLiteHelper** static. Ini solusi untuk *data persistence*, tapi ada masalah:
- UI tidak otomatis update ketika data berubah (perlu `setState`)
- Sharing data antar halaman sulit (harus passing parameter)
- Testing susah karena ketergantungan langsung

### Apa itu Provider?
Provider adalah **state management** resmi yang direkomendasikan tim Flutter. Prinsipnya:
- **ChangeNotifier** → class yang menyimpan data & notifikasi listener
- **ChangeNotifierProvider** → widget yang menyediakan instance ke turunannya
- **Consumer / Provider.of** → cara mengakses & listen perubahan

### Analogi Sederhana
- **ChangeNotifier** → Radio (penyiar berita)
- **notifyListeners()** → Siaran "ada berita baru"
- **Consumer** → Pendengar yang update otomatis

### Hubungan dengan SQLite
Provider **tidak menggantikan** SQLite, tapi **menggabungkan**:
```
SQLite (Database) → Model (Data Class) → Provider (State) → UI (Widget)
```

---

## 2. Contoh Implementasi (Dari Static DB Helper ke Provider)

### Langkah 0: Tambahkan dependency
```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^3.x
  provider: ^6.x
```

### Langkah 1: Model Data (Sama seperti sebelumnya)
```dart
class Mahasiswa {
  final int? id;
  final String nama;
  final String nim;

  Mahasiswa({this.id, required this.nama, required this.nim});

  Map<String, dynamic> toMap() => {'id': id, 'nama': nama, 'nim': nim};

  factory Mahasiswa.fromMap(Map<String, dynamic> map) => Mahasiswa(
        id: map['id'],
        nama: map['nama'],
        nim: map['nim'],
      );
}
```

### Langkah 2: DB Helper (Sama seperti static method)
```dart
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'mahasiswa.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE mahasiswa(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nama TEXT,
          nim TEXT
        )
      ''');
    });
  }

  Future<List<Mahasiswa>> getMahasiswa() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('mahasiswa');
    return List.generate(maps.length, (i) => Mahasiswa.fromMap(maps[i]));
  }

  Future<void> insertMahasiswa(Mahasiswa m) async {
    final db = await database;
    await db.insert('mahasiswa', m.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateMahasiswa(Mahasiswa m) async {
    final db = await database;
    await db.update('mahasiswa', m.toMap(), where: 'id = ?', whereArgs: [m.id]);
  }

  Future<void> deleteMahasiswa(int id) async {
    final db = await database;
    await db.delete('mahasiswa', where: 'id = ?', whereArgs: [id]);
  }
}
```

### Langkah 3: **NEW** Provider (ChangeNotifier) → ini inti perubahan
```dart
class MahasiswaProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Mahasiswa> _mahasiswaList = [];

  List<Mahasiswa> get mahasiswaList => _mahasiswaList;

  // Load data dari DB saat provider dibuat
  Future<void> loadMahasiswa() async {
    _mahasiswaList = await _dbHelper.getMahasiswa();
    notifyListeners(); // ← UI akan rebuild otomatis
  }

  Future<void> addMahasiswa(Mahasiswa mahasiswa) async {
    await _dbHelper.insertMahasiswa(mahasiswa);
    await loadMahasiswa(); // reload & notifikasi
  }

  Future<void> updateMahasiswa(Mahasiswa mahasiswa) async {
    await _dbHelper.updateMahasiswa(mahasiswa);
    await loadMahasiswa();
  }

  Future<void> deleteMahasiswa(int id) async {
    await _dbHelper.deleteMahasiswa(id);
    await loadMahasiswa();
  }
}
```

### Langkah 4: Setup Provider di main.dart
```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MahasiswaProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MahasiswaPage(),
    );
  }
}
```

### Langkah 5: Halaman Utama (Menggunakan Consumer)
```dart
class MahasiswaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Panggil load data saat pertama kali
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MahasiswaProvider>().loadMahasiswa();
    });

    return Scaffold(
      appBar: AppBar(title: Text('Daftar Mahasiswa')),
      body: Consumer<MahasiswaProvider>(
        builder: (context, provider, child) {
          if (provider.mahasiswaList.isEmpty) {
            return Center(child: Text('Belum ada data'));
          }
          return ListView.builder(
            itemCount: provider.mahasiswaList.length,
            itemBuilder: (context, index) {
              final mhs = provider.mahasiswaList[index];
              return ListTile(
                title: Text(mhs.nama),
                subtitle: Text(mhs.nim),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => provider.deleteMahasiswa(mhs.id!),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AddMahasiswaPage()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
```

### Langkah 6: Halaman Tambah (Menggunakan Provider.of tanpa listen)
```dart
class AddMahasiswaPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nimController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Mahasiswa')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (v) => v!.isEmpty ? 'Harus diisi' : null,
              ),
              TextFormField(
                controller: _nimController,
                decoration: InputDecoration(labelText: 'NIM'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final mhs = Mahasiswa(
                      nama: _namaController.text,
                      nim: _nimController.text,
                    );
                    // context.read (tidak listen) untuk panggil method
                    await context.read<MahasiswaProvider>().addMahasiswa(mhs);
                    Navigator.pop(context);
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 3. Perbandingan Sebelum vs Sesudah Provider

| Aspek | Tanpa Provider (static helper) | Dengan Provider |
|-------|-------------------------------|-----------------|
| **Update UI** | Perlu `setState` manual | Otomatis setelah `notifyListeners()` |
| **Akses data antar halaman** | Passing parameter atau static variable | `context.read<Provider>()` dimanapun |
| **Kode di Widget** | Bercampur logic CRUD + UI | UI murni, logic di Provider |
| **Testing** | Sulit mock database | Mudah mock Provider |
| **Rebuild** | Seluruh halaman rebuild | Hanya widget dalam `Consumer` |

---

## 4. Tugas Praktikum (Mahasiswa)

**Soal:**
Modifikasi aplikasi **Catatan Harian** (SQLite sebelumnya) menjadi menggunakan Provider dengan fitur:
1. Tampilkan list catatan (judul, isi, tanggal)
2. Tambah catatan baru (form)
3. Hapus catatan dengan konfirmasi dialog
4. Edit catatan yang sudah ada

**Kriteria penilaian:**
- ✅ Menggunakan `ChangeNotifierProvider` di `main.dart`
- ✅ Menggunakan `Consumer` untuk widget yang dinamis
- ✅ Menggunakan `context.read` untuk operasi yang tidak perlu listen
- ✅ Data tetap tersimpan di SQLite (tidak hanya di memory)

**Pertanyaan teoritis (dikumpulkan):**
1. Jelaskan perbedaan `context.watch`, `context.read`, dan `Consumer`!
2. Apa keuntungan menggunakan Provider dibanding hanya mengandalkan `setState`?
3. Pada kode di atas, mengapa `loadMahasiswa()` dipanggil di `addPostFrameCallback`?
