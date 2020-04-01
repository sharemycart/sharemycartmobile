import 'package:flutter/foundation.dart';

class Item {
  String name;
  double quantity;
  String unit;
  String uid;

  Item({ @required this.name, @required this.quantity, @required this.unit, @required this.uid });

  factory Item.fromMap(Map data) {
    return Item(
      name: data['name'],
      quantity: data['quantity'],
      unit: data['unit'],
      uid: data['uid'],
    );
  }
}