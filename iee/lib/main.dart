import 'package:flutter/material.dart';
import 'package:iee/Quiz_App/Models/Questions.dart';
import 'package:iee/Quiz_App/Screens/Question_list.dart';
import 'package:iee/Quiz_App/Screens/Quiz_Screen.dart';
import 'package:provider/provider.dart';

import 'Quiz_App/Screens/AddQuestion.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("vtre");
    return ChangeNotifierProvider(
      create: (ctx) => DataBase(),
      child: MaterialApp(
        routes: {
          Add_Screen.RouteName: (ctx) => Add_Screen(),
          Quiz_Screen.RouteName: (ctx) => Quiz_Screen()
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.black12,
          primaryColor: Colors.amber,
          accentColor: Colors.blueGrey,
          primarySwatch: Colors.cyan,
        ),
        home: Qusetion_List(),
      ),
    );
  }
}
