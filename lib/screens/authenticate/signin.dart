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
  final _formkey = GlobalKey<FormState>();

  AuthService _authService = new AuthService();
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    final currUser = Provider.of<custUser>(context);

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
              key: _formkey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Username',
                      ),
                      onChanged: (value) => setState(() {
                            email = value;
                          }),
                      validator: ((value) {
                        if (value == null ||
                            !value.contains('@') ||
                            value.isEmpty) {
                          return "Username Can't be Empty and must be an Email address";
                        } else
                          return null;
                      })),
                  const SizedBox(
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
                    validator: (value) => value!.length < 6
                        ? "Password must be greater than 6! Length = ${value.length}"
                        : null,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          custUser? myUser;
                          await _authService
                              .loginWithEmailAndPassword(email, password)
                              .then((custUser result) {
                            if (result.uid == null) {
                              print("User Not Present!!");
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Invalid User!!')),
                              );
                            } else {
                              print("User Logged in ");
                            }
                            print(result.uid);
                          });
                        }
                      },
                      child: Text("Login!"))
                ],
              ))),
    );
  }
}
