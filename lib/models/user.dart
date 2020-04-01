import 'package:flutter/foundation.dart';

class User {
  String uid;
  String name;
  String email;

  User({ @required this.uid, @required this.name, this.email });

  factory User.fromMap(Map data) {
    return User(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
    );
  }
}
