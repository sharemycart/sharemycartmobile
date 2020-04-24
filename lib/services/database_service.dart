import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharemycartmobile/models/user.dart';
import 'package:sharemycartmobile/models/shopping_list.dart';
import 'package:sharemycartmobile/constants/firestore_constants.dart';

class DatabaseService {

  final String userUID;
  final Firestore _db = Firestore.instance;

  DatabaseService({ this.userUID} );

  Future<User> getUser() async {
    var snapshot = await _db.collection(UsersDatabaseConstants.COLLECTION).document(userUID).get();
    return User.fromMap(snapshot.data);
  }

  // ShoppingLists from Snapshot
  List<ShoppingList> _shoppingListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ShoppingList.fromFirestore(doc);
    }).toList();
  }

  Stream<List<ShoppingList>> get shoppingLists {
    var ref = _db.collection(ListDatabaseConstants.COLLECTION)
        .where(ListDatabaseConstants.USER_ID_KEY, isEqualTo: userUID)
        .where(ListDatabaseConstants.LIFECYCLE_STATUS_KEY, isEqualTo: ListDatabaseConstants.LIFECYCLE_STATUS_OPEN)
        .orderBy(ListDatabaseConstants.NAME_KEY);
    return ref.snapshots().map(_shoppingListFromSnapshot);
  }

  Future<DocumentReference> addShoppingList(ShoppingList shoppingList) async {
    var ref = _db.collection("lists");
    return await ref.add(shoppingList.toMap());
  }

  Future<void> deleteShoppingList(String documentID) async {
    Map updateToArchived = { ListDatabaseConstants.LIFECYCLE_STATUS_KEY : ListDatabaseConstants.LIFECYCLE_STATUS_ARCHIVED };
    await _db.collection("lists").document(documentID).updateData(updateToArchived);
  }

}