import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email;
  String? password;
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
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Confirm Password',
                ),
                onChanged: (value) => setState(() {}),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(onPressed: () {}, child: Text("Register!"))
            ],
          ))),
    );
  }
}
