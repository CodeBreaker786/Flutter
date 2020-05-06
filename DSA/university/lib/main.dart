import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:university/providers/database.dart';
import 'package:university/screens/Home.dart';
import 'package:university/screens/auth.dart';
import 'package:university/screens/profile.dart';
import 'package:university/screens/searchScreen.dart';
import 'package:university/screens/wraper.dart';

import 'models/AuthModel.dart';
import 'models/UserModel.dart';
import 'providers/NavigationBarModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NavigationBarModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataBase(),
        ),
        StreamProvider<User>.value(value: AuthService().user)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            // textTheme: GoogleFonts.dancingScriptTextTheme(
            //   Theme.of(context).textTheme,
            // ),
            accentColor: Colors.lightBlue[100],
            primaryColor: Colors.blue[400]),
        home: Wraper(),
        routes: {
          HomeScreen.route: (context) => HomeScreen(),
          SearchScreen.route: (context) => SearchScreen(),
          Profile.route: (context) => Profile(),
          AuthPage.route: (context) => AuthPage(),
        },
      ),
    );
  }
}
