import 'package:brew_crew/model/user.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final currUser = Provider.of<custUser>(context);
    return Scaffold(
      backgroundColor: Colors.yellow.shade300,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade800,
        title: const Text("Login to Coffee Brow"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () async {
            // if (currUser == null) {
            //   print("No User");
            // } else {
            //   print("User Exists!!");
            // }
            custUser result = await _auth.signInano();
            if (result == null) {
              print("Error Sign In");
            } else {
              print("Sign In Sucess!!");
              print(result.uid);
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
          child: const Text("Login Anonymous"),
        ),
      ),
    );
  }
}
