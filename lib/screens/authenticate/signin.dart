import 'package:brew_crew/design/inputdecorated.dart';
import 'package:brew_crew/model/user.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../design/loading.dart';

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
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    // final currUser = Provider.of<custUser>(context);

    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.yellow.shade300,
            appBar: AppBar(
              backgroundColor: Colors.yellow.shade800,
              title: const Text("Login to Coffee Brow"),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: const Icon(Icons.person_add_alt))
              ],
            ),
            body: Container(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            decoration: inputdecorator.copyWith(
                                label: const Text('Email Address')),
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
                          decoration: inputdecorator.copyWith(
                              label: const Text('Password')),
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
                                setState(() {
                                  loading = true;
                                });
                                custUser? myUser;
                                await _authService
                                    .loginWithEmailAndPassword(email, password)
                                    .then((custUser result) {
                                  if (result.uid == null) {
                                    print("User Not Present!!");
                                    setState(
                                      () => loading = false,
                                    );
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   const SnackBar(
                                    //       content: Text('Invalid User!!')),
                                    // );
                                  } else {
                                    print("User Logged in ");
                                  }
                                  // print(result.uid);
                                });
                              }
                            },
                            child: Text("Login!"))
                      ],
                    ))),
          );
  }
}
