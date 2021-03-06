import 'package:flutter/material.dart';

class NeedsPage extends StatefulWidget {
  @override
  _NeedsPageState createState() => _NeedsPageState();
}

class _NeedsPageState extends State<NeedsPage> {
  var needsList = List<String>();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurpleAccent,
          tooltip: "Add a Needs List",
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
                              pushNeedsList(value);
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
        body: AnimatedList(
          key: _listKey,
          initialItemCount: needsList.length,
          itemBuilder: (context, index, animation) => _buildItem(context, needsList[index], animation),
        )
    );
  }

  void pushNeedsList(String title) {
    setState(() {
      needsList.insert(0, title);
      _listKey.currentState.insertItem(0);
    });
  }

  void popNeedsList(index) {
    setState(() {
      var itemToRemove = needsList.removeLast();
      _listKey.currentState.removeItem(
          index, (context, animation) => _buildItem(context, itemToRemove, animation),
          duration: const Duration(milliseconds: 250));
    });
  }

  Widget _buildItem(BuildContext context, String item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        color: Colors.redAccent,
        elevation: 3.0,
        shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
        ),
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10.0),
              leading: Container(child: Icon(Icons.shopping_cart)),
              title: new Text(item, style: TextStyle(color: Colors.white),),
              trailing: Container(child: Icon(Icons.arrow_forward_ios),),
            )
        ),
      ),
    );
  }

}

