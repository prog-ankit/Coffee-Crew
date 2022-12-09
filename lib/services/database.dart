import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  String? uid;
  DatabaseService({this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brew_crew');

  Future updateUserData(String sugar, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugar,
      'name': name,
      'strength': strength,
    });
  }

  Future<Stream<QuerySnapshot<Object?>>> brewData() async {
    //1st technqiue to get and send data to other file
    // List data = [];
    // try {
    //   await brewCollection.get().then((querySnapshot) {
    //     querySnapshot.docs.forEach((element) {
    //       data.add(element.data());
    //     });
    //   });
    // } catch (e) {
    //   print(e);
    // }
    // return data;
    //Return Type would be - Future<List>

    //2nd technqiue - Stream Builder
    return brewCollection.snapshots();
  }
}
