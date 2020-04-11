import 'package:flutter/foundation.dart';
import 'package:iee/Quiz_App/Models/Question.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBase with ChangeNotifier {
  static Database DB;
  List<QuestionModel> _Questiondata = [];

  List<QuestionModel> get questions {
    return [..._Questiondata];
  }

  Future OpenDb() async {
    if (DB == null) {
      DB = await openDatabase(join(await getDatabasesPath(), "Question.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE Question(id INTEGER PRIMARY KEY AUTOINCREMENT ,Question TEXT,Option1 TEXT,Option2 TEXT,Option3 TEXT,Option4 TEXT,Answer TEXT )");
      });
    }
  }

  Future insert(QuestionModel questionModel) async {
    await OpenDb();
    await DB.insert('Question', questionModel.toMap()).then((_) {
      FetchData();
    });
    notifyListeners();
  }

  Future<void> deleteNote(int id) async {
    await OpenDb();

    var result = await DB.rawDelete('DELETE FROM Question WHERE id = $id');
    notifyListeners();
    FetchData();
  }

  Future<void> FetchData() async {
    await OpenDb();
    var data = await DB.query('Question');
    List<QuestionModel> temparydata = List<QuestionModel>();
    data.forEach((sigle) {
      var Option = List<String>();
      Option.add(sigle['Option1']);
      Option.add(sigle['Option2']);
      Option.add(sigle['Option3']);
      Option.add(sigle['Option4']);
      temparydata.add(QuestionModel.withId(
          sigle['Question'], Option, sigle['Answer'], sigle['id']));
    });

    _Questiondata = temparydata;
    print(_Questiondata.length.toString());
    notifyListeners();
  }
}
