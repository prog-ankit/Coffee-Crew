import 'package:brew_crew/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String email;
  late String password;

  AuthService _authService = new AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade800,
        title: const Text("Register to Coffee Brow"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.login))
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Username',
                    ),
                    onChanged: (value) => setState(() {
                      email = value;
                    }),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Username Can't be Empty";
                      else
                        return null;
                    },
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
                    validator: (value) {
                      if (value!.length < 8)
                        return "Password must be greater than 8";
                      else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                    validator: (value) {
                      if (value != password)
                        return "Password Doesn't match!!";
                      else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print(email);
                          print(password);
                          dynamic result = _authService
                              .registerWithEmailAndPassword(email, password);
                          if (result == null)
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Error in Regitering')),
                            );
                          else
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Done Registration')),
                            );
                        }
                      },
                      child: Text("Register!"))
                ],
              ))),
    );
  }
}
