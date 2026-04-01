class Person {
  String name = "";
  int age = 0;
  String gender = "";
  String address = "";

  String info() {
    return "halo nama saya $name, umur: $age, jenis kelamin: $gender, alamat: $address ";
  }

  void printInfo() {
    String informasi = info();
    print(informasi);
  }
}

class Mahasiswa extends Person {
  String nim = "";
  bool isGraduated = false;

  void printMhsInfo() {
    var info = super.info();
    print(
      "$info, nim saya adalah $nim dan status kuliah saya ${isGraduated ? "Lulus" : "Belum Lulus"} ",
    );
  }
}

void main() {
  //object 1
  Mahasiswa wafalhana = Mahasiswa();
  wafalhana.name = "wafalhana";
  wafalhana.age = 20;
  wafalhana.gender = "lk";
  wafalhana.address = "salatiga";
  wafalhana.nim = "0001";
  wafalhana.isGraduated = true;
  wafalhana.printMhsInfo();

  print("\n------------\n");

  //object 2
  Person farid = Person();
  farid.name = "Farid";
  farid.age = 21;
  farid.gender = "lk";
  farid.address = "bawen";
  farid.printInfo();
}
