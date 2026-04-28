import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database?> _initDB() async {
    String path = p.join(await getDatabasesPath(), "user_db.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)",
        );
      },
    );
  }

  //CREATE
  static Future<int> insertData(String name, int age) async {
    final db = await database;
    Map<String, dynamic> user = {"name": name, "age": age};

    return await db.insert(
      "users",
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //READ
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query("users");
  }

  //UPDATE
  static Future<int> updateData(int id, String name, int age) async {
    final db = await database;
    Map<String, dynamic> user = {"name": name, "age": age};
    return await db.update("users", user, where: "id=?", whereArgs: [id]);
  }

  //DELETE
  static Future<int> deleteData(int id) async {
    final db = await database;
    return await db.delete("users", where: "id=?", whereArgs: [id]);
  }
}

class UserListSQLPage extends StatefulWidget {
  const UserListSQLPage({super.key});

  @override
  State<UserListSQLPage> createState() => _UserListSQLPageState();
}

class _UserListSQLPageState extends State<UserListSQLPage> {
  List<Map<String, dynamic>> _users = [];

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _ageCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    //set users data here
    _reloadData();
  }

  void _reloadData() async {
    var users = await DatabaseHelper.getUsers();
    setState(() {
      _users = users;
    });
  }

  //show form
  void _showForm(int? id) async {
    if (id != null) {
      var user = _users.firstWhere((e) => e["id"] == id);
      _nameCtrl.text = user["name"];
      _ageCtrl.text = user["age"].toString();
    } else {
      _nameCtrl.clear();
      _ageCtrl.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          MediaQuery.of(context).viewInsets.bottom + 100,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameCtrl,
              decoration: InputDecoration(hintText: "Input Name"),
            ),
            TextField(
              controller: _ageCtrl,
              decoration: InputDecoration(hintText: "Input Age"),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () =>
                  _handleSave(id, _nameCtrl.text, int.parse(_ageCtrl.text)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text(
                id == null ? "TAMBAH" : "PERBAHARUI",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSave(int? id, String name, int age) async {
    if (id == null) {
      await DatabaseHelper.insertData(name, age);
    } else {
      await DatabaseHelper.updateData(id, name, age);
    }

    _reloadData();
  }

  void _handleDelete(int id) async {
    await DatabaseHelper.deleteData(id);
    _reloadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SQLITE Impl")),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (ctx, i) => Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            title: Text(_users[i]["name"]),
            subtitle: Text(_users[i]["age"].toString()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => _showForm(_users[i]["id"]),
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () => _handleDelete(_users[i]["id"]),
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(null),
        child: Icon(Icons.add),
      ),
    );
  }
}
