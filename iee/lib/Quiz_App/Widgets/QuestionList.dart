import 'package:flutter/material.dart';
import 'package:iee/Quiz_App/Models/Questions.dart';
import 'package:provider/provider.dart';

class QuestionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DataBase>(context);
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
          itemCount: database.questions.length,
          itemBuilder: (ctx, index) {
            return Dismissible(
              key: ValueKey(database.questions[index]),
              background: Card(
                color: Colors.red,
                child: ListTile(
                  trailing: Icon(
                    Icons.delete,
                    size: 35,
                  ),
                  leading: Icon(
                    Icons.edit,
                    size: 35,
                  ),
                ),
              ),
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  Provider.of<DataBase>(context, listen: false)
                      .deleteNote(index);
                }
                if (direction == DismissDirection.startToEnd) {
                  print("edit method is called ");
                }
              },
              child: Card(
                elevation: 10,
                child: InkWell(
                  splashColor: Colors.amberAccent,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        database.questions[index].Question[0].toUpperCase(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    trailing: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    title: Text(
                      database.questions[index].Question,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
