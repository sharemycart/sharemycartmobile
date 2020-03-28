import 'package:flutter/material.dart';
import 'package:sharemycartmobile/views/shooping_page.dart';
import 'package:sharemycartmobile/views/needs_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var navIndex = 0;
  final pages = List<Widget>.unmodifiable([
    ShoppingPage(),
    NeedsPage(),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          bottomNavigationBar: MyNavBar(),
          body: pages[navIndex],
    );
  }
}

class MyNavBar extends StatefulWidget {
  @override
  _MyNavBarState createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        color: Colors.amber,
    );
  }
}
