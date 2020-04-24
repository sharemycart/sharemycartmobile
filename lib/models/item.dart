import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Item {
  String docId;
  String name;
  double quantity;
  String unit;
  String createdAt;

  Item({
    @required this.docId,
    @required this.name,
    @required this.quantity,
    @required this.unit,
    @required this.createdAt });

  factory Item.fromMap(DocumentSnapshot doc) {
    var data = doc.data;

    return Item(
      docId: doc.documentID,
      name: data['name'],
      quantity: data['quantity'],
      unit: data['unit'],
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'createdAt': createdAt,
    };
  }
}