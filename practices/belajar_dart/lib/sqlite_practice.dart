import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite CRUD Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UserListScreen(),
    );
  }
}

// 1. MODEL DATA
class User {
  final int? id;
  final String name;
  final int age;

  User({this.id, required this.name, required this.age});

  // Konversi User ke Map (untuk simpan ke DB)
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }

  // Konversi Map ke User (saat ambil dari DB)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(id: map['id'], name: map['name'], age: map['age']);
  }
}

// 2. DATABASE HELPER (LOGIKA CRUD)
class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  static Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)',
        );
      },
    );
  }

  // CREATE
  static Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // READ
  static Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) => User.fromMap(maps[i]));
  }

  // UPDATE
  static Future<int> updateUser(User user) async {
    final db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // DELETE
  static Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}

// 3. UI (USER INTERFACE)
class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> _users = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshUsers();
  }

  // Mengambil ulang data dari DB
  void _refreshUsers() async {
    final data = await DatabaseHelper.getUsers();
    setState(() {
      _users = data;
    });
  }

  // Menampilkan form input (Tambah/Edit)
  void _showForm(int? id) async {
    if (id != null) {
      final existingUser = _users.firstWhere((element) => element.id == id);
      _nameController.text = existingUser.name;
      _ageController.text = existingUser.age.toString();
    } else {
      _nameController.clear();
      _ageController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(
          15,
          15,
          15,
          MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Nama'),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(hintText: 'Umur'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final name = _nameController.text;
                final age = int.tryParse(_ageController.text) ?? 0;

                if (id == null) {
                  await DatabaseHelper.insertUser(User(name: name, age: age));
                } else {
                  await DatabaseHelper.updateUser(
                    User(id: id, name: name, age: age),
                  );
                }
                _refreshUsers();
                Navigator.pop(context);
              },
              child: Text(id == null ? 'Tambah' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SQLite CRUD')),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            title: Text(_users[index].name),
            subtitle: Text('Umur: ${_users[index].age}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showForm(_users[index].id),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await DatabaseHelper.deleteUser(_users[index].id!);
                    _refreshUsers();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
