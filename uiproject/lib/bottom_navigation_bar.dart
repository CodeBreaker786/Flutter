import 'package:flutter/material.dart';
import 'package:uiproject/colors.dart';
import 'package:uiproject/screens/home_page/home_page.dart';
import 'package:uiproject/screens/splash_screen/splash_screen.dart';

class BottomNaviBar extends StatefulWidget {
  @override
  _BottomNaviBarState createState() => _BottomNaviBarState();
}

class _BottomNaviBarState extends State<BottomNaviBar> {
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
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: UiColors.darkblue,
          currentIndex: pageIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
          ]),
      body: PageView(
        children: <Widget>[SplashScreen(), HomeScreen()],
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
