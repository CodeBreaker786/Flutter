import 'package:dsaa/providers/database.dart';
import 'package:dsaa/screens/CropImagel.dart';
import 'package:dsaa/screens/Details.dart';
import 'package:dsaa/screens/Home.dart';
import 'package:dsaa/screens/auth.dart';
import 'package:dsaa/screens/practice.dart';
import 'package:dsaa/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          create: (context) => database(),
        ),
        StreamProvider<User>.value(value: AuthService().user)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            accentColor: Colors.lightBlue[100], primaryColor: Colors.blue[400]),
        home: practice(),
        routes: {
          HomeScreen.route: (context) => HomeScreen(),
          Details.route: (context) => Details(),
          Profile.route: (context) => Profile(),
          AuthPage.route: (context) => AuthPage(),
          ImageCapture.route: (context) => ImageCapture(),
        },
      ),
    );
  }
}
