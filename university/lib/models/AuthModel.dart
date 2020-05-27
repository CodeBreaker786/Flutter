import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'UserModel.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _database = Firestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    //print(user.uid);
    // database.Uid = user.uid;
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName);
      await _database.collection("portal").document(user.uid).setData({
        'name': user.displayName,
        'email': user.email,
        'fatherName': null,
        "rollNo": null,
        "clas": null,
        "department": null,
        "status": null,
        'url': user.photoUrl,
        'uid': user.uid,
        "phoneNo": user.phoneNumber
      });
      print(user.phoneNumber);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(
      String name, String email, String password, BuildContext context) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      await _database.collection("portal").document(user.uid).setData({
        'name': name,
        'email': email,
        'fatherName': null,
        "rollNo": null,
        "clas": null,
        "department": null,
        "status": null,
        'url': null,
        'uid': user.uid,
        "phoneNo": null
      });

      // create a new document for the user with the uid
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
