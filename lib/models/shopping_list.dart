import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ShoppingList {
  String name;
  String type;
  List<Item> items;

  List({ @required this.name, @required this.type, this.items });

  factory ShoppingList.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return ShoppingList(
      name: data['name'],
      type: data['type'],
      items: data['items'],
    );
  }
}