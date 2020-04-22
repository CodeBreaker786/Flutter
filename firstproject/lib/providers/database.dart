import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstproject/models/UserModel.dart';
import 'package:flutter/cupertino.dart';

class database with ChangeNotifier {
  final Firestore _database = Firestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  User currentUser;

  get user => currentUser;

  Future<void> update() async {
    FirebaseUser user;
    user = await FirebaseAuth.instance.currentUser();
    QuerySnapshot data = await _database
        .collection("portal")
        .document(user.uid)
        .snapshots()
        .forEach((action) async {
      currentUser = User(
          name: action.data['name'],
          fatherName: action.data['fatherName'],
          uid: action.data['uid'],
          url: action.data['url'],
          clas: action.data['clas'],
          status: action.data['status'],
          phoneNo: action.data['phoneNo'],
          rollNo: action.data['rollNo']);
    });

    notifyListeners();
  }
}
