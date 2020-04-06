import 'package:flutter/material.dart';
import 'package:sharemycartmobile/views/shooping_page.dart';
import 'package:sharemycartmobile/views/needs_page.dart';

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

        body: Page()
    );
  }
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  var navIndex = 0;
  final pages = List<Widget>.unmodifiable([
    ShoppingPage(),
    NeedsPage(),
  ]);

  final iconsList = List<IconData>.unmodifiable([
    Icons.shopping_cart,
    Icons.shop_two,
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          bottomNavigationBar: MyNavBar(
            icons: iconsList,
            onPressed: (i) => setState(() => navIndex = i),
            activeIndex: navIndex,
          ),
          body: pages[navIndex],
    );
  }
}

class MyNavBar extends StatefulWidget {
  const MyNavBar({ @required this.icons, @required this.onPressed, @required this.activeIndex }) : assert(icons != null);
  final List<IconData> icons;
  final Function(int) onPressed;
  final int activeIndex;

  @override
  _MyNavBarState createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          for (var i = 0; i < widget.icons.length; i++)
            IconButton(
              icon: Icon(widget.icons[i]),
              color: i == widget.activeIndex ? Colors.deepOrange : Colors.black54,
              onPressed: () => widget.onPressed(i),
            ),
        ],
      ),
    );
  }
}
