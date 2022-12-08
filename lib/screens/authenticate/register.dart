// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:brew_crew/design/inputdecorated.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

import '../../design/loading.dart';

class Register extends StatefulWidget {
  final toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String email;
  late String password;
  bool loading = false;
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.yellow.shade300,
            appBar: AppBar(
              backgroundColor: Colors.yellow.shade800,
              title: const Text("Register to Coffee Brow"),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: const Icon(Icons.login))
              ],
            ),
            body: Container(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: inputdecorator.copyWith(
                              label: const Text('Email Address')),
                          onChanged: (value) => setState(() {
                            email = value;
                          }),
                          validator: (value) {
                            value == null || value.isEmpty
                                ? "Username Can't be Empty"
                                : null;
                            // if (value == null || value.isEmpty)
                            //   return "Username Can't be Empty";
                            // else
                            //   return null;
                          },
                        ),
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
                          validator: (value) {
                            value!.length < 8
                                ? "Password must be greater than 8"
                                : null;

                            // if (value!.length < 8)
                            //   return "Password must be greater than 8";
                            // else
                            // return null;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: inputdecorator.copyWith(
                              label: const Text('Confirm Password')),
                          validator: (value) {
                            value != password
                                ? "Password Doesn't match!!"
                                : null;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);

                                _authService
                                    .registerWithEmailAndPassword(
                                        email, password)
                                    .then((result) {
                                  // print(result);
                                  // print(result.uid);

                                  if (result.uid == null) {
                                    setState(() => loading = false);
                                    print("Failed to Register the User!!");
                                  } else
                                    print(
                                        "Successfully Registered New User!!!");
                                });
                              }
                            },
                            child: const Text("Register!"))
                      ],
                    ))),
          );
  }
}
