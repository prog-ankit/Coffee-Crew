import 'package:brew_crew/design/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/brew.dart';
import 'brew_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List brewuserData = [];
  // Stream<QuerySnapshot>? data;
  @override
  void initState() {
    //TODO: implement
    super.initState();
    // fetchDataList();
  }

  void fetchDataList() async {
    // await DatabaseService().brewData().then((value) => setState(() {
    //       data = value;
    //     }));

    //For Technique-1
    // await DatabaseService().brewData();
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
    final AuthService auth = AuthService();

    void _showPanelbottom() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return const bottomPanel();
          });
    }

    return StreamProvider<List<brew>>.value(
      initialData: const [],
      value: DatabaseService().brewData,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow.shade800,
          title: const Text("Coffee Brow!!"),
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
                print("Settings Here!!");
                _showPanelbottom();
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              label: const Text(
                "Settings",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                print("User Signed Out!!");
                await auth.signOut();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: const Text(
                "Log Out",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
