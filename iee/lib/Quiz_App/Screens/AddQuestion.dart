import 'package:flutter/material.dart';
import 'package:iee/Quiz_App/Models/Question.dart';
import 'package:iee/Quiz_App/Models/Questions.dart';
import 'package:provider/provider.dart';

class Add_Screen extends StatefulWidget {
  static final RouteName = '/AddQuestion';
  Function function;

  Add_Screen({this.function});

  @override
  _Add_ScreenState createState() => _Add_ScreenState();
}

class _Add_ScreenState extends State<Add_Screen> {
  TextEditingController questionController = TextEditingController();
  TextEditingController optionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  List<String> enteredOption = List<String>();
  String EnteredQuestion, EnteredAnser;
  DataBase db_helper = DataBase();
  QuestionModel NewData;
  int OptionIndex = 0;

  Map Labels = {
    'Question': 'Enter a Question',
    'Option': 'Enter Answers',
    'Answer': 'Enter Answer of the Question'
  };
  Map State = {
    'Question': 'Enter Question',
    'Option': [
      'Option 1',
      'Option 2',
      'Option 3',
      'Option 4',
    ],
    'Answer': 'Enter Correct Answer'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Question"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: getFilds(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: FloatingActionButton(
                        splashColor: Theme.of(context).primaryColor,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(Icons.arrow_forward),
                        onPressed: () {
                          Upload_data(widget.function);
                        }),
                  )
                ],
              )),
        )),
      ),
    );
  }

  Future<void> Upload_data(Function function) async {
    NewData = QuestionModel(
        questionController.text, enteredOption, answerController.text);
    Provider.of<DataBase>(context, listen: false).insert(NewData);
    Navigator.of(context).pop();

    // await Firestore.instance.collection("Quiz").document('$length').setData({
    //'Question': QuestionController.text,
    // 'Option': EnteredOption,
    // 'Answer': AnswerController.text,
    //});
  }

  Widget getFilds() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: TextFormField(
            controller: questionController,
            enabled: (questionController.text.length < 100) ? true : false,
            onChanged: (val) {
              setState(() {});
            },
            onFieldSubmitted: (val) {
              setState(() {
                EnteredQuestion = val;
                print(EnteredQuestion);
              });
            },
            decoration: new InputDecoration(
              errorText: (questionController.text.isEmpty)
                  ? 'Field should not be empty'
                  : null,
              labelText: Labels['Question'],
              hintText: State['Question'],
              helperText: (questionController.text.length > 1)
                  ? 'Question should consist of 100 alphabits'
                  : null,
              hasFloatingPlaceholder: true,
              fillColor: Colors.white,
              hoverColor: Colors.amber,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
              //fillColor: Colors.green
            ),
            keyboardType: TextInputType.emailAddress,
            style: new TextStyle(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: TextFormField(
            controller: optionController,
            onChanged: (val) {
              setState(() {});
            },
            enabled: (OptionIndex < 4) ? true : false,
            onFieldSubmitted: (val) {
              setState(() {
                if (OptionIndex < 4) {
                  enteredOption.add(val);
                  print(enteredOption);
                  optionController.clear();
                  OptionIndex++;
                }
              });
            },
            decoration: new InputDecoration(
              errorText:
                  optionController.text.isEmpty ? "Field is empty" : null,
              helperText:
                  (OptionIndex > 0) ? 'you can enter on 4 option' : null,
              labelText: OptionIndex < 4
                  ? State['Option'][OptionIndex]
                  : "You Can Maximum Four Answer",
              hintText: OptionIndex < 4
                  ? enteredOption.toString()
                  : "You Can Maximum Four Answer",

              hasFloatingPlaceholder: true,
              fillColor: Colors.white,
              hoverColor: Colors.amber,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
              //fillColor: Colors.green
            ),
            keyboardType: TextInputType.emailAddress,
            style: new TextStyle(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: TextFormField(
            controller: answerController,
            onChanged: (val) {
              setState(() {});
            },
            onFieldSubmitted: (val) {
              setState(() {
                EnteredAnser = val;
                print(val);
              });
            },
            decoration: new InputDecoration(
              labelText: State['Answer'],
              hintText: State['Anwser'],
              errorText:
                  answerController.text.isEmpty ? "Field is empty" : null,
              //helperText:(AnswerController.text.isEmpty )?'you can enter on 4 option' : null ,

              hasFloatingPlaceholder: true,
              fillColor: Colors.white,
              hoverColor: Colors.amber,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
              //fillColor: Colors.green
            ),
            keyboardType: TextInputType.emailAddress,
            style: new TextStyle(),
          ),
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
