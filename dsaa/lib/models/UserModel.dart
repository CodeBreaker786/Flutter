import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String phoneNo;

  String fatherName;

  String name;

  String department;

  String clas;

  String status;

  String url;

  String uid;

  int rollNo = 0;

  User(
      {this.name,
      this.fatherName,
      this.rollNo,
      this.clas,
      this.department,
      this.status,
      this.url,
      this.uid,
      this.phoneNo});

  set setPhone(value) {
    phoneNo = value;
  }

  set setFName(value) {
    fatherName = value;
  }

  set setName(value) {
    name = value;
  }

  set setDpt(value) {
    department = value;
  }

  set setClass(value) {
    clas = value;
  }

  set setStatus(value) {
    status = value;
  }

  set setUid(value) {
    uid = value;
  }

  set setRollNo(value) {
    rollNo = value;
  }

  get getName => name;

  get getUid => uid;

  get getFName => fatherName;

  get getDpt => department;

  get getClass => clas;

  get getRollNo => rollNo;

  get getStatus => status;

  User fromMap(DocumentSnapshot map) {
    return User(
        uid: map['uid'],
        url: map['url'],
        status: map['status'],
        name: map['name'],
        fatherName: map['fatherName'],
        rollNo: map['rollNo'],
        clas: map['clas'],
        department: map['department'],
        phoneNo: map['phoneNo']);
  }
//
//  void update() async {
//    await _database.collection("portal").document().snapshots();
//  }
}
