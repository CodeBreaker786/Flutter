import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference postRef = Firestore.instance.collection("posts");
final CollectionReference portalRef = Firestore.instance.collection("portal");
