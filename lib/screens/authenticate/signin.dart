import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
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
            dynamic result = await _auth.signInano();
            if (result == null) {
              print("Error Sign In");
            } else {
              print("Sign In Sucess!!");
              print(result.uid);
            }
          },
          child: Text("Login Anonymous"),
        ),
      ),
    );
  }
}
