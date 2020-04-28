import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:university/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class DataBase with ChangeNotifier {
  final Firestore _database = Firestore.instance;
  // final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  User currentUser;

  get user => currentUser;

  Future<void> update() async {
    FirebaseUser user;
    user = await FirebaseAuth.instance.currentUser();
    await _database
        .collection("portal")
        .document(user.uid)
        .snapshots()
        .forEach((action) async {
      currentUser = User(
          name: action.data['name'],
           email: action.data['email'],
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
