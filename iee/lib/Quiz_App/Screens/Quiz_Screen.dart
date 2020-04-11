import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iee/Quiz_App/Models/Questions.dart';
import 'package:iee/Screens/Widgets.dart';
import 'package:provider/provider.dart';

import 'Result_Screen.dart';

class Quiz_Screen extends StatefulWidget {
  static final RouteName = '/QuizScreen';
  @override
  _Quiz_ScreenState createState() => _Quiz_ScreenState();
}

class _Quiz_ScreenState extends State<Quiz_Screen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  int index = 0;
  String title = "Quiz";
  Widget build(BuildContext context) {
    var Question = Provider.of<DataBase>(context, listen: false);
    return index < Question.questions.length
        ? Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      //Navigator.of(context).popAndPushNamed('/Add_Screen');
                      showModalBottomSheet(
                          context: context, builder: (BuildContext bc) {});
                    })
              ],
              title: Text(
                title,
                style: style(),
              ),
            ),
            body: StaggeredGridView.count(crossAxisCount: 10, children: [
              myCircularItems(Question.questions.length, index),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text_Card(
                    Question.questions[index].Question,
                    null,
                    TextStyle(
                        fontSize: 35,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold)),
              ),
              ...(Question.questions[index].Options)
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text_Card(
                            e.toString(),
                            NextQuestion,
                            TextStyle(
                              fontSize: 28,
                              fontStyle: FontStyle.italic,
                            )),
                      ))
                  .toList(),
            ], staggeredTiles: [
              StaggeredTile.extent(
                  10, MediaQuery.of(context).size.height * 0.3),
              StaggeredTile.extent(
                  10, MediaQuery.of(context).size.height * 0.25),
              ...(Question.questions[index].Options)
                  .map(
                    (e) => StaggeredTile.extent(
                        5, MediaQuery.of(context).size.height * 0.15),
                  )
                  .toList(),
            ]))
        : Result_Screen();
  }

  void NextQuestion() {
    setState(() {
      index++;
      print(index);
    });
  }
}
