import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharemycartmobile/models/item.dart';

class ShoppingList {
   String id;
   String name;
   String type;
   List<Item> items;

  ShoppingList({ this.id, this.name, this.type, this.items });

  factory ShoppingList.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data;

    return ShoppingList(
        id: data['id'],
        name: data['name'],
        type: data['type'],
        items: data['items']);
  }
}