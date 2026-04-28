import 'package:flutter/material.dart';

class UserListStaticApp extends StatefulWidget {
  const UserListStaticApp({super.key});

  @override
  State<UserListStaticApp> createState() => _UserListStaticAppState();
}

class _UserListStaticAppState extends State<UserListStaticApp> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _ageCtrl = TextEditingController();

  final List<Map<String, dynamic>> _userList = [
    {"id": 1, "name": "satu", "age": 10},
    {"id": 2, "name": "dua", "age": 11},
    {"id": 3, "name": "tiga", "age": 12},
    {"id": 4, "name": "empat", "age": 13},
  ];

  void _showForm(int? id) async {
    if (id != null) {
      var user = _userList.firstWhere((e) => e["id"] == id);
      _nameCtrl.text = user['name'];
      _ageCtrl.text = user['age'].toString();
    } else {
      _nameCtrl.clear();
      _ageCtrl.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
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
              decoration: const InputDecoration(hintText: "Name"),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _ageCtrl,
              decoration: const InputDecoration(hintText: "Age"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                _handleSave(id, _nameCtrl.text, int.parse(_ageCtrl.text));
              },
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

  void _handleSave(int? id, String name, int age) {
    if (id != null) {
    } else {
      int lastId = _userList.length + 1;
      Map<String, dynamic> newUser = {"id": lastId, "name": name, "age": age};
      setState(() {
        _userList.add(newUser);
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Tambah user berhasil")));
    }
  }

  void _handleDelete(int id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Konfirmasi Hapus"),
        content: Text("Apakah anda yakin ingin menghapus user ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _userList.removeWhere((e) => e["id"] == id);
              });

              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("user berhasil di hapus")));
            },
            child: Text("Hapus"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List User Data")),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _userList.length,
          itemBuilder: (ctx, i) => Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(_userList[i]["name"]),
              subtitle: Text("Umur: ${_userList[i]["age"]}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _showForm(_userList[i]["id"]),
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () => _handleDelete(_userList[i]["id"]),
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
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
