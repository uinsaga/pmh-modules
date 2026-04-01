class UserModel {
  String name = "";
  int age = 0;

  void showUserInfo() => print("hello my name is $name, and my age is $age");
}

void main() {
  //membuat object / instantiate object
  UserModel user1 = UserModel();

  //set object user name = Ebrahim
  user1.name = "Ebrahim";

  //set Object user age = 20
  user1.age = 20;

  //show user info from the class method
  user1.showUserInfo();

  var user2 = UserModel()
    ..name = "Abdullah"
    ..age = 21
    ..showUserInfo();
}
