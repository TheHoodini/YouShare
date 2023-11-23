import 'package:firebase_database/firebase_database.dart';

class AppUser {
  String? key;
  String name;
  String username;
  String email;
  String salute;
  String uid;
  List friends;

  AppUser(this.name, this.username, this.key, this.email, this.salute, this.uid,
      this.friends);

  AppUser.fromJson(DataSnapshot snapshot, Map<dynamic, dynamic> json)
      : key = snapshot.key ?? "0",
        name = json['name'] ?? "name",
        username = json['username'] ?? 'username',
        email = json['email'] ?? "email",
        salute = json['salute'] ?? 'Hey there! I\'m using YouShare.',
        uid = json['uid'] ?? "uid",
        friends = json['friendList'] ?? [];

  toJson() {
    return {
      "name": name,
      "username": username,
      "email": email,
      "salute": salute,
      "uid": uid,
      "friends": friends
    };
  }
}
