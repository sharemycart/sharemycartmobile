import 'package:flutter/foundation.dart';

class User {
  String uid;
  String email;

  User({ @required this.uid, this.email });

  factory User.fromMap(Map data) {
    return User(
      uid: data['uid'],
      email: data['email'],
    );
  }
}
