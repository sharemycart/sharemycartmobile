import 'package:flutter/material.dart';
import 'package:sharemycartmobile/views/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Share My Cart',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: new HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        bottomOpacity: 0.5,
        toolbarOpacity: 1,
        title: new Text("Share My Cart", style: new TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.search),
          )
        ],
        elevation: 5.0,
      ),
      body: Home()
    );
  }
}
