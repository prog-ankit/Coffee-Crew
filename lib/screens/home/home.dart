import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/model/user.dart';

import 'brew_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List brewuserData = [];
  Stream<QuerySnapshot>? data;
  @override
  void initState() {
    //TODO: implement
    super.initState();
    fetchDataList();
  }

  void fetchDataList() async {
    await DatabaseService().brewData().then((value) => setState(() {
          data = value;
        }));

    //For Technique-1
    // if (result == null) {
    //   print("Null Result");
    // } else {
    //   // print(result);
    //   // print("Home ==> ${result[0]}");
    //   setState(() {
    //     brewuserData = result;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final currUser = Provider.of<custUser>(context);
    String myText = "";
    if (currUser != null) {
      myText = currUser.uid.toString();
    }
    final AuthService _auth = AuthService();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow.shade800,
          title: Text("Coffee Brow!!"),
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
                print("Printed Here!!");
                await _auth.signOut();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: const Text(
                "Log Out",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: data,
          builder: ((context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("NO DATA PRESENT!!!"),
              );
            } else {
              return ListView(
                children: snapshot.data!.docs.map((document) {
                  return Center(
                    child: Container(
                      child: Text("Title: " + document['name']),
                    ),
                  );
                }).toList(),
              );
            }
          }),
        ));
  }
}
