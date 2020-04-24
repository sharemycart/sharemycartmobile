import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharemycartmobile/constants/firestore_constants.dart';
import 'package:sharemycartmobile/models/shopping_list.dart';
import 'package:sharemycartmobile/services/database_service.dart';
import 'package:sharemycartmobile/views/home/animated_list.dart';

class ShoppingPage extends StatefulWidget {
  ShoppingPage({Key key}) : super(key: key);

  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {

  var db = DatabaseService();

  var shoppingListToBeAdded;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);

    return StreamProvider<List<ShoppingList>>.value(
      value: DatabaseService(userUID: user.uid).shoppingLists,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurpleAccent,
          tooltip: "Add a Shopping List",
          child: new Icon(Icons.add_shopping_cart),
          onPressed: () {
            showDialog(context: context,
            builder: (_) => new AlertDialog(
              title: new Text("New Shopping List"),
              shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              content: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          icon: new Icon(Icons.shopping_cart),
                          hintText: "Groceries",
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter a title for Shopping List";
                          }
                          return null;
                        },
                        onSaved: (shoppingListName) {
                          pushShoppingList(shoppingListName, user.uid);
                        },
                      ),
                    ],
                  )
              ),
              actions: <Widget>[
                MaterialButton(
                  color: Colors.deepPurpleAccent,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      Navigator.pop(context);
                    }
                  },
                  child: new Text("Add", style: new TextStyle(color: Colors.white)),
                ),
              ],
            ));
          },
        ),
        body: RenderList(),
        ),
      );
  }

  void pushShoppingList(String shoppingListName, String userId) async {
    shoppingListToBeAdded = new ShoppingList(
      name: shoppingListName,
      userId: userId,
      type: ListDatabaseConstants.TYPE_SHOPPING,
      lifecycleStatus: ListDatabaseConstants.LIFECYCLE_STATUS_OPEN,
      isCurrent: true,
      createdAt: FieldValue.serverTimestamp(),
      editedAt: FieldValue.serverTimestamp(),
    );
    await db.addShoppingList(shoppingListToBeAdded);
  }

}

