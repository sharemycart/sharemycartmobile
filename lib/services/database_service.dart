import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sharemycartmobile/models/user.dart';
import 'package:sharemycartmobile/models/shopping_list.dart';

class DatabaseService {
  final Firestore _db = Firestore.instance;
  Future<User> getUser(String uid) async {
    var snapshot = await _db.collection("users").document(uid).get();
    return User.fromMap(snapshot.data);
  }

  Stream<List<ShoppingList>> getShoppingListsStream(FirebaseUser user) {
    var ref = _db.collection("lists").document(user.uid).collection("items");
    return ref.snapshots().map((list) => list.documents.map((doc) => ShoppingList.fromFirestore(doc)));
  }

}