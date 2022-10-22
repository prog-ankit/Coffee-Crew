import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/model/user.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
              await _auth.signOut().then((value) =>
                  Navigator.of(context).pushReplacementNamed('/authenticate'));
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
      body: Text(myText),
    );
  }
}
