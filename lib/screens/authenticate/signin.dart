import 'package:brew_crew/model/user.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  final toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade800,
        title: const Text("Login to Coffee Brow"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person_add_alt))
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Username',
                ),
                onChanged: (value) => setState(() {
                  email = value;
                }),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                onChanged: (value) => setState(() {
                  password = value;
                }),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  onPressed: () async {
                    print(email);
                    print(password);
                  },
                  child: Text("Login!"))
            ],
          ))),
    );
  }
}
