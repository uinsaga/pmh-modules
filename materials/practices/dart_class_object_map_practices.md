# PRAKTIKUM DART

## Topik: Class, Object, List, dan Map

**Tujuan:**
Mahasiswa mampu:

- Membuat class dan object di Dart
- Mengelola data menggunakan List
- Menggunakan Map sebagai representasi data key-value
- Mengubah object ↔ Map (fondasi ke SQLite)

---

# STUDI KASUS

Kita akan membuat sistem sederhana:
👉 **Manajemen Data Mahasiswa**

Nantinya ini akan dipakai ulang saat masuk ke SQLite (karena struktur Map mirip dengan row database).

---

**Sebelum Mulai:**

Sebelum mengerjakan praktikum pastikan kalian buat project dart degan nama `praktikum_dart_pp6`. 

perintah buat project di terminal:

```bash
dart create praktikum_dart_pp6
```

setelah itu silakan buka project nya di editor masing-masing dan kerjakan praktikum dibawah ini:

---

# BAGIAN 1 — CLASS & OBJECT

### Praktek 1: Membuat Class Mahasiswa

Buat class `Mahasiswa` dengan atribut:

- id
- nama
- jurusan
- angkatan

```dart
class Mahasiswa {
  int id;
  String nama;
  String jurusan;
  int angkatan;

  Mahasiswa({
    required this.id,
    required this.nama,
    required this.jurusan,
    required this.angkatan,
  });
}
```

---

### Praktek 2: Membuat Object

```dart
void main() {
  Mahasiswa mhs1 = Mahasiswa(
    id: 1,
    nama: "Budi",
    jurusan: "Informatika",
    angkatan: 2022,
  );

  print(mhs1.nama);
}
```

---

# BAGIAN 2 — LIST (MENYIMPAN BANYAK DATA)

### Praktek 3: List Object

```dart
List<Mahasiswa> daftarMahasiswa = [];

void main() {
  daftarMahasiswa.add(
    Mahasiswa(id: 1, nama: "Budi", jurusan: "TI", angkatan: 2022),
  );

  daftarMahasiswa.add(
    Mahasiswa(id: 2, nama: "Siti", jurusan: "SI", angkatan: 2021),
  );

  for (var mhs in daftarMahasiswa) {
    print(mhs.nama);
  }
}
```

---

### Praktek 4: Operasi List

Mahasiswa diminta:

- Tambah data
- Hapus data berdasarkan id
- Update data

Contoh hapus:

```dart
daftarMahasiswa.removeWhere((mhs) => mhs.id == 1);
```

---

# BAGIAN 3 — MAP (SIMULASI DATABASE)

👉 Ini bagian penting untuk SQLite nanti

### Praktek 5: Convert Object → Map

Tambahkan method di class:

```dart
Map<String, dynamic> toMap() {
  return {
    'id': id,
    'nama': nama,
    'jurusan': jurusan,
    'angkatan': angkatan,
  };
}
```

---

### Praktek 6: Convert Map → Object

```dart
factory Mahasiswa.fromMap(Map<String, dynamic> map) {
  return Mahasiswa(
    id: map['id'],
    nama: map['nama'],
    jurusan: map['jurusan'],
    angkatan: map['angkatan'],
  );
}
```

---

# BAGIAN 4 — SIMULASI DATABASE SEDERHANA

### Praktek 7: Gunakan List<Map>

```dart
List<Map<String, dynamic>> database = [];
```

---

### Praktek 8: Insert Data

```dart
void insertMahasiswa(Mahasiswa mhs) {
  database.add(mhs.toMap());
}
```

---

### Praktek 9: Ambil Data

```dart
List<Mahasiswa> getMahasiswa() {
  return database.map((data) => Mahasiswa.fromMap(data)).toList();
}
```

---

### Praktek 10: Update & Delete

Update:

```dart
void updateMahasiswa(int id, Mahasiswa newData) {
  for (int i = 0; i < database.length; i++) {
    if (database[i]['id'] == id) {
      database[i] = newData.toMap();
    }
  }
}
```

Delete:

```dart
void deleteMahasiswa(int id) {
  database.removeWhere((data) => data['id'] == id);
}
```

---

# TUGAS MINI PROJECT (WAJIB)

Buat program dengan fitur:

1. Tambah mahasiswa
2. Tampilkan semua data
3. Update mahasiswa
4. Hapus mahasiswa

👉 Output cukup di console

---

# OUTPUT YANG DIHARAPKAN

Mahasiswa mengumpulkan laporan praktikum dalam format PDF yang berisi:

- Screenshot kode dan hasil running
- Penjelasan singkat:
  - Class
  - List
  - Map
  - toMap & fromMap

---
