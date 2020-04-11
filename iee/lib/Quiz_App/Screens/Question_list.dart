import 'package:flutter/material.dart';
import 'package:iee/Quiz_App/Models/Questions.dart';
import 'package:iee/Quiz_App/Widgets/DoubleFloatingButton.dart';
import 'package:iee/Quiz_App/Widgets/QuestionList.dart';
import 'package:iee/Screens/Widgets.dart';
import 'package:provider/provider.dart';

class Qusetion_List extends StatefulWidget {
  static final RouteName = '/QuestionList';

  @override
  _Qusetion_ListState createState() => _Qusetion_ListState();
}

class _Qusetion_ListState extends State<Qusetion_List> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    /* Future.delayed(Duration.zero).then((_) {
      Provider.of<DB_Helper>(context, listen: false).FetchData();
    });*/
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
        print("once");
      });
      Provider.of<DataBase>(
        context,
      ).FetchData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Question",
            style: style(),
          ),
        ),
        body: RefreshIndicator(
          color: Colors.amber,
          displacement: 80,
          onRefresh: () => _refreshProducts(context),
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : QuestionList(),
        ),
        floatingActionButton: FloatingButton());
  }

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<DataBase>(context, listen: false).FetchData();
  }
}

/* void updateListView() {
    final Future dbFuture = databaseHelper.OpenDb();
    dbFuture.then((database) {
      Future noteListFuture = databaseHelper.getData();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
          Loding = false;
        });
      });
    });
  }
*/ /*
  void _delete(Question, context) async {
    int result = await databaseHelper.deleteNote(Question.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }*/

void _showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message));
  Scaffold.of(context).showSnackBar(snackBar);
}
