import 'package:flutter/material.dart';

import 'package:gcuf/providers/Navigation_Bar.dart';
import 'package:gcuf/screens/Wraper.dart';
import 'package:gcuf/screens/authication/auth.dart';
import 'package:gcuf/screens/home/Home.dart';
import 'package:gcuf/screens/profile/profile.dart';
import 'package:gcuf/screens/search/searchScreen.dart';
import 'package:provider/provider.dart';
import 'package:gcuf/providers/database.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NavigationBottomBar(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataBase(),
        ),
        // StreamProvider<User>.value(value: AuthService().user)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            }),
            // textTheme: GoogleFonts.dancingScriptTextTheme(
            //   Theme.of(context).textTheme,
            // ),
            accentColor: Colors.lightBlue[100],
            primaryColor: Colors.blue[400]),
        home: Wraper(),
        routes: {
          Home.route: (context) => Home(),
          SearchScreen.route: (context) => SearchScreen(),
          Profile.route: (context) => Profile(),
          AuthPage.route: (context) => AuthPage(),
        },
      ),
    );
  }
}
