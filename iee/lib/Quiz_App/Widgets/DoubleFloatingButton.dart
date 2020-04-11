import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:iee/Quiz_App/Screens/AddQuestion.dart';
import 'package:iee/Quiz_App/Screens/Quiz_Screen.dart';

class FloatingButton extends StatefulWidget {
  @override
  _FloatingButtonState createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      visible: true,
      onOpen: () {
        setState(() {
          isOpen = true;
        });
      },
      onClose: () {
        setState(() {
          isOpen = false;
        });
      },
      backgroundColor: isOpen ? Colors.red : Colors.amber,
      curve: Curves.fastOutSlowIn,
      children: [
        // FAB 1
        SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Colors.orange,
            onTap: () {
              Navigator.of(context).pushNamed(Add_Screen.RouteName);
            },
            label: 'Add Question',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: Colors.orange),
        // FAB 2
        SpeedDialChild(
            child: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.of(context).pushNamed(Quiz_Screen.RouteName);
            },
            backgroundColor: Colors.orangeAccent,
            label: 'Start Quiz',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: Colors.orangeAccent)
      ],
    );
  }
}
