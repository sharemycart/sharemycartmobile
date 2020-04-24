import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharemycartmobile/constants/firestore_constants.dart';

class ShoppingList {
   String docId;
   String userId;
   String name;
   String type;
   String lifecycleStatus;
   bool isCurrent;
   dynamic createdAt;
   dynamic editedAt;

  ShoppingList({
    this.docId,
    this.userId,
    this.name,
    this.type,
    this.lifecycleStatus,
    this.isCurrent,
    this.createdAt,
    this.editedAt,
  });

  factory ShoppingList.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data;

    return ShoppingList(
      docId: doc.documentID,
      userId: data[ListDatabaseConstants.USER_ID_KEY] ?? '',
      name: data[ListDatabaseConstants.NAME_KEY] ?? '',
      type: data[ListDatabaseConstants.TYPE_KEY] ?? '',
      lifecycleStatus: data[ListDatabaseConstants.LIFECYCLE_STATUS_KEY] ?? '',
      isCurrent: data[ListDatabaseConstants.IS_CURRENT_KEY] ?? true,
      createdAt: data[ListDatabaseConstants.CREATED_AT_KEY],
      editedAt: data[ListDatabaseConstants.EDITED_AT_KEY],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ListDatabaseConstants.USER_ID_KEY : userId,
      ListDatabaseConstants.NAME_KEY : name,
      ListDatabaseConstants.TYPE_KEY : type,
      ListDatabaseConstants.LIFECYCLE_STATUS_KEY : lifecycleStatus,
      ListDatabaseConstants.IS_CURRENT_KEY : isCurrent,
      ListDatabaseConstants.CREATED_AT_KEY : createdAt,
      ListDatabaseConstants.EDITED_AT_KEY : editedAt,
    };
  }

}