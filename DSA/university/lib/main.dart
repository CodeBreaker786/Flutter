import 'package:university/providers/database.dart';
import 'package:university/screens/CropImagel.dart';
import 'package:university/screens/Details.dart';
import 'package:university/screens/Home.dart';
import 'package:university/screens/auth.dart';
import 'package:university/screens/profile.dart';
import 'package:university/screens/wraper.dart';
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
        home: wraper(),
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
