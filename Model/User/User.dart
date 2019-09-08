import 'dart:convert';
import '../Api.dart';

class User extends Api {
  int userID;
  String name;
  String username;
  String password;
  String mobile;
  String email;
  bool activeUser;
  UserGroup userGroup;

  User(
      {this.userID,
      this.name,
      this.username,
      this.password,
      this.mobile,
      this.email,
      this.activeUser,
      this.userGroup});

  User.fromjson(x) {
    if(x==null)
    return;
    this.userID = x["userID"];
    this.name = x["name"];
    this.username = x["username"];
    this.password = x["password"];
    this.mobile = x["mobile"];
    this.email = x["email"];
    this.activeUser = x["acticeUser"];
    this.userGroup = x["userGroup"];
  }
  Future<List<User>> getUsers() async {
    var res = await getUrl('user');
    var w = jsonDecode(res.body);
    var users = new List<User>();
    for (var user in w) {
      users.add(User.fromjson(user));
    }
    return users;
  }

  Future<User> getUser(int id) async {
    var res = await getUrl('user/' + id.toString());
    var w = jsonDecode(res.body);
    return User.fromjson(w);
  }

  Future<int> editUser(int id, User user) async {
    var res = await putUrl(url: 'user/' + id.toString(), body: user);
    return res.statusCode;
  }

  Future<User> createUser(User user) async {
    var res = await postUrl(url: 'user/', body: user);
    var w = jsonDecode(res.body);
    return User.fromjson(w);
  }

  Future<User> deleteUser(int id) async {
    var res = await deleteUrl('user/' + id.toString());
    var w = jsonDecode(res.body);
    return User.fromjson(w);
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': this.userID,
      'name': this.name,
      'username': this.username,
      'password': this.password,
      'mobile': this.mobile,
      'email': this.email,
      'activeUser': this.activeUser,
      'userGroup': this.userGroup
    };
  }
}

class UserGroup {
  int usergroupID;
  String groupName;

  UserGroup({this.usergroupID, this.groupName});

  UserGroup.fromjson(x) {
    if (x == null) return;
    this.usergroupID = x["usergroupID"];
    this.groupName = x["groupName"];
  }
}
