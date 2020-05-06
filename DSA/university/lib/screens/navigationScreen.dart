import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:university/screens/post.dart';
import 'package:university/screens/profile.dart';
import 'package:university/screens/searchScreen.dart';

import 'Home.dart';
import 'auth.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }
  // List<Widget> screens = [HomeScreen(), Details(), Profile(), AuthPage()];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onPageChanged(index) {
    setState(() {
      this.pageIndex = index;
    });
  }

  void onTap(index) {
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    //bool offset = Provider.of<NavigationBarModel>(context).navigationBar;

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      bottomNavigationBar: Offstage(
        offstage: false,
        child: CurvedNavigationBar(
          height: 50,

          items: [
            Icon(Icons.home),
            Icon(Icons.search),
            Icon(Icons.add),
            Icon(Icons.call_to_action),
            Icon(Icons.person_pin),
          ],
          // color: Color(0xff00224B),backgroundColor: Theme.of(context).primaryColor,
          index: pageIndex,
          color: Theme.of(context).primaryColor,
          // color: Colors.transparent,
          onTap: onTap,
          backgroundColor: Theme.of(context).accentColor,
        ),
      ),
      body: PageView(
        children: <Widget>[
          HomeScreen(),
          SearchScreen(),
          Posts(),
          AuthPage(),
          Profile()
        ],
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
