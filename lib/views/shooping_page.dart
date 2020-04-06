import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingPage extends StatefulWidget {
  ShoppingPage({Key key}) : super(key: key);

  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {


  var itemIndex = new List<int>();

  var db = Firestore.instance;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      onSaved: (value) {
//                        pushShoppingList(value);
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
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection("lists").document("7JNwPKwSX9UZEXizKg1x").collection("listitems").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LinearProgressIndicator();
          return AnimatedList(
            key: _listKey,
            initialItemCount: snapshot.data.documents.length,
            itemBuilder: (context, index, animation) {
              return _buildItem(context, snapshot.data.documents[index], animation);
            }
          );
        }
      )
    );

  }

  void pushShoppingList(String title) async {

  }

  void popShoppingList(DocumentSnapshot doc) {

  }

  Widget _buildItem(BuildContext context,  DocumentSnapshot item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        color: Colors.redAccent,
        elevation: 3.0,
        shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
        ),
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10.0),
              leading: Container(child: Icon(Icons.shopping_cart)),
              title: new Text(item['listName'], style: TextStyle(color: Colors.white),),
              trailing: Container(
                  child: Icon(Icons.arrow_forward_ios)),
              onTap: () {},
            )
        ),
      ),
    );
  }

}

