import 'dart:js';

import 'package:brew_crew/model/user.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/authenticate/signin.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final currUser = Provider.of<custUser>(context);
    print("From Wrapper: ${currUser.uid}");
    if (currUser.uid != null) {
      return Home();
    } else {
      return Authenticate();
    }
  }
}
