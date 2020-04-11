class QuestionModel {
  String _Question;
  String _Answer;
  List<String> _Options;
  int _id;
  QuestionModel.withId(this._Question, this._Options, this._Answer, this._id);
  QuestionModel(this._Question, this._Options, this._Answer);

  int get id => this._id;
  String get Question => this._Question;
  String get Answer => this._Answer;
  List<String> get Options => this._Options;

  set id(int id) {
    this._id = id;
  }

  set Question(String question) {
    this._Question = question;
  }

  set Answer(String answer) {
    this._Answer = answer;
  }

  set Option(List<String> option) {
    this._Options = option;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['Question'] = _Question;
    map['Option1'] = Options[0];
    map['Option2'] = Options[1];
    map['Option3'] = Options[2];
    map['Option4'] = Options[3];
    map['Answer'] = _Answer;

    return map;
  }

  Map formMap(Map data) {
    var map = Map<String, dynamic>();
    map['Question'] = _Question;
    map['Option'] = [Options[0], Options[1], Options[2], Options[3]];
    map['Answer'] = _Answer;

    return map;
  }
}
