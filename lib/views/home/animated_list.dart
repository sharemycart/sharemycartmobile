import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharemycartmobile/models/shopping_list.dart';
import 'package:sharemycartmobile/services/database_service.dart';

class RenderList extends StatefulWidget {
  @override
  _RenderListState createState() => _RenderListState();
}

class _RenderListState extends State<RenderList> {
  @override
  Widget build(BuildContext context) {
    final shoppingLists = Provider.of<List<ShoppingList>>(context) ?? [];
    for (var list in shoppingLists) {
      print('docID: ${list.docId}');
      print('list name: ${list.name}');
    }

    return ListView.builder(
        itemCount: shoppingLists.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(shoppingLists[index].docId),
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
                    title: new Text(shoppingLists[index].name, style: TextStyle(color: Colors.white),),
                    trailing: Container(
                        child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              await DatabaseService().deleteShoppingList(shoppingLists[index].docId);
                              setState(() {
                                shoppingLists.removeAt(index);
                              });
                            },
                        ),
                    ),
                    onTap: () => {},
                  ),
              ),
            ),
            onDismissed: (direction) async {
              await DatabaseService().deleteShoppingList(shoppingLists[index].docId);
              setState(() {
                shoppingLists.removeAt(index);
              });
            },
          );
        },
    );
  }

}
